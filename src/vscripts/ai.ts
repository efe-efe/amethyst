import { Entity, setEntityDirection } from "./entities";
import { ModifierCasting } from "./modifiers/modifier_casting";
import {
    SimpleTrigger,
    direction2D,
    distanceBetweenEntities,
    distanceBetweenPoints,
    findElementWithSmallestValue,
    hasBehavior,
    isChanneling,
    isInDeveloperMode,
    simpleTrigger,
    triggerNow,
    valueOrSpecial
} from "./util";

export type UnitAIContext =
    | {
          id: "moving";
          target: Vector;
          moveTrigger: SimpleTrigger;
      }
    | { id: "idle" }
    | { id: "startedCasting" }
    | { id: "following"; target: CDOTA_BaseNPC }
    | { id: "resting"; restTrigger: SimpleTrigger };

export type UnitAIBehavior = "follower" | "wanderer" | "static";

type UnitAIContextBase = Readonly<{
    entity: Entity;
    unit: CDOTA_BaseNPC;
    abilities: readonly CDOTABaseAbility[];
    allies: readonly CDOTA_BaseNPC[];
    enemies: readonly CDOTA_BaseNPC[];
    minFollowRange: number;
    followRange: number;
    behavior: UnitAIBehavior;
    context: UnitAIContext;
}>;

type RuleContext = {
    caster: CDOTA_BaseNPC;
    ability: CDOTABaseAbility;
    allies: readonly CDOTA_BaseNPC[];
    enemies: readonly CDOTA_BaseNPC[];
};

export type Rule = (target: CDOTA_BaseNPC, ctx: RuleContext, remaining: CDOTA_BaseNPC[]) => boolean;

type AbilityAI = {
    ruleSets: RuleSet[];
};

type RuleSet = {
    rules: Rule[];
};

type CastDecision =
    | {
          outcome: "targetUnit";
          target: CDOTA_BaseNPC;
      }
    | {
          outcome: "targetGround";
          target: Vector;
      }
    | {
          outcome: "targetNothing";
      }
    | {
          outcome: "dontCast";
      };

type AbilityTarget = "unit" | "ground" | "none";

function findClosestGuy(who: CDOTA_BaseNPC, fromWhom: readonly CDOTA_BaseNPC[]): CDOTA_BaseNPC | undefined {
    return findElementWithSmallestValue(fromWhom, unit => distanceBetweenEntities(who, unit));
}

function inferAbilityTarget(ability: CDOTABaseAbility): AbilityTarget | undefined {
    const behavior = ability.GetBehavior();

    if (hasBehavior(behavior, AbilityBehavior.UNIT_TARGET)) {
        return "unit";
    } else if (hasBehavior(behavior, AbilityBehavior.POINT)) {
        return "ground";
    } else if (hasBehavior(behavior, AbilityBehavior.NO_TARGET)) {
        return "none";
    } else {
        print(`Unsupported ability targeting for ${ability.GetAbilityName()}: ${tostring(behavior)}`);
    }
}

function executeRuleChain(units: CDOTA_BaseNPC[], rules: Rule[], context: RuleContext) {
    for (const rule of rules) {
        units = units.filter(unit => rule(unit, context, units));

        if (units.length == 0) {
            return [];
        }
    }

    return units;
}

function inferAbilityAI(ability: CDOTABaseAbility): AbilityAI | undefined {
    const result: Rule[] = [];
    const targetTeam = ability.GetAbilityTargetTeam();

    if ((targetTeam & UnitTargetTeam.ENEMY) != 0) {
        result.push(rules.enemy());
    }

    if ((targetTeam & UnitTargetTeam.FRIENDLY) != 0) {
        result.push(rules.ally());
    }

    const target = inferAbilityTarget(ability);
    if (!target) return;

    switch (target) {
        case "unit":
        case "ground": {
            result.push(rules.isClosest());
            break;
        }

        case "none": {
            result.push(rules.inAOERadius());
            break;
        }
    }

    return { ruleSets: [{ rules: result }] };
}

export function decideHowToCastAbilityByAI(
    unit: CDOTA_BaseNPC,
    allies: readonly CDOTA_BaseNPC[],
    enemies: readonly CDOTA_BaseNPC[],
    ability: CDOTABaseAbility
): CastDecision {
    function unitCanBeUnitTargeted(targetUnit: CDOTA_BaseNPC) {
        if (targetUnit.IsOutOfGame() || targetUnit.IsUntargetableFrom(unit)) {
            return false;
        }

        if (unit.GetTeamNumber() == targetUnit.GetTeamNumber()) {
            return true;
        }
        return !targetUnit.IsUnselectable() && !targetUnit.IsInvisible();
    }

    function flagOrDefault<T extends number>(flag: T, def: T) {
        return flag == 0 ? def : flag;
    }

    function findFittingRuleSetTargets(units: CDOTA_BaseNPC[], sets: RuleSet[]) {
        return sets.map(set => executeRuleChain(units, set.rules, context)).find(targets => targets.length > 0);
    }

    function findCastPositionSafe(targets: CDOTA_BaseNPC[]) {
        // const clusters = biggestUnitClusters(targets, ability.GetCastPoint(), ability.GetAOERadius());
        // const closest = findElementWithSmallestValue(
        //     clusters.map(points => (points.reduce((a, b) => (a + b) as Vector) / points.length) as Vector),
        //     average => distanceBetweenPoints(average, unit.GetAbsOrigin())
        // );
        // return closest ?? targets[0].GetAbsOrigin();
        return targets[0].GetAbsOrigin();
    }

    function findCastPosition(targets: CDOTA_BaseNPC[] | undefined) {
        return targets ? findCastPositionSafe(targets) : undefined;
    }

    const ai = inferAbilityAI(ability);
    if (!ai) return { outcome: "dontCast" };

    const context: RuleContext = { caster: unit, allies, enemies, ability };

    const abilityTarget = inferAbilityTarget(ability);
    if (!abilityTarget) return { outcome: "dontCast" };

    const allTargets = [...allies, ...enemies].filter(target => {
        if (abilityTarget == "unit" && !unitCanBeUnitTargeted(target)) {
            return false;
        }
        return (
            UnitFilter(
                target,
                flagOrDefault(ability.GetAbilityTargetTeam(), UnitTargetTeam.BOTH),
                flagOrDefault(ability.GetAbilityTargetType(), UnitTargetType.ALL),
                ability.GetAbilityTargetFlags(),
                unit.GetTeamNumber()
            ) == UnitFilterResult.SUCCESS
        );
    });

    const maybeTargets = findFittingRuleSetTargets(allTargets, ai.ruleSets);
    if (!maybeTargets) return { outcome: "dontCast" };

    switch (abilityTarget) {
        case "none":
            return { outcome: "targetNothing" };
        case "unit":
            return {
                outcome: "targetUnit",
                target: findClosestGuy(unit, maybeTargets) ?? maybeTargets[0]
            };
        case "ground": {
            return {
                outcome: "targetGround",
                target: findCastPositionSafe(maybeTargets)
            };
        }
        default:
            return unreachable(abilityTarget);
    }
}

export function updateUnitAI({
    entity,
    unit,
    abilities,
    allies,
    enemies,
    behavior,
    context,
    minFollowRange,
    followRange
}: UnitAIContextBase): UnitAIContext {
    function maybeCastSomeAbility(
        unit: CDOTA_BaseNPC,
        allies: readonly CDOTA_BaseNPC[],
        enemies: readonly CDOTA_BaseNPC[],
        abilities: readonly CDOTABaseAbility[]
    ) {
        function isAbilityConsideredForAI(ability: CDOTABaseAbility) {
            if (ability.IsHidden()) return false;
            if (ability.IsPassive()) return false;
            if (!ability.IsFullyCastable()) return false;
            if (!ability.IsActivated()) return false;
            if (ability.GetCaster().IsRooted() && hasBehavior(ability.GetBehavior(), AbilityBehavior.ROOT_DISABLES)) return false;

            return true;
        }

        function isInCastRange(unit: CDOTA_BaseNPC, ability: CDOTABaseAbility, target: Vector) {
            // Spells with no defined cast range should be treated as if they have an infinite cast range.
            const castRange = ability.GetEffectiveCastRange(Vector(0, 0, 0), unit);
            return castRange == 0 || distanceBetweenPoints(target, unit.GetAbsOrigin()) <= castRange;
        }

        const playerId = unit.GetPlayerOwnerID();
        const consideredAbilities = abilities.filter(ability => isAbilityConsideredForAI(ability));
        const nonAutoCastAbilities: CDOTABaseAbility[] = [];

        for (const ability of consideredAbilities) {
            const behavior = ability.GetBehavior();

            if (hasBehavior(behavior, AbilityBehavior.AUTOCAST) && hasBehavior(behavior, AbilityBehavior.ATTACK)) {
                if (!ability.GetAutoCastState()) {
                    ability.ToggleAutoCast();
                }
            } else {
                nonAutoCastAbilities.push(ability);
            }
        }

        for (const ability of nonAutoCastAbilities) {
            const decision = decideHowToCastAbilityByAI(unit, allies, enemies, ability);

            if (isInDeveloperMode() && decision.outcome != "dontCast") {
                DebugDrawText((unit.GetAbsOrigin() + Vector(0, 0, 128)) as Vector, ability.GetAbilityName(), true, 1);
            }

            const isToggle = hasBehavior(ability.GetBehavior(), AbilityBehavior.TOGGLE);

            switch (decision.outcome) {
                case "targetGround": {
                    if (!isInCastRange(unit, ability, decision.target)) {
                        return false;
                    }

                    DebugDrawLine_vCol(unit.GetAbsOrigin(), decision.target, Vector(255, 0, 0), true, ability.GetCastPoint());

                    unit.CastAbilityOnPosition(decision.target, ability, playerId);
                    return true;
                }

                case "targetUnit": {
                    if (!isInCastRange(unit, ability, decision.target.GetAbsOrigin()) && unit.IsRooted()) {
                        return false;
                    }

                    unit.CastAbilityOnTarget(decision.target, ability, playerId);
                    return true;
                }

                case "targetNothing": {
                    if (isToggle) {
                        unit.CastAbilityToggle(ability, playerId);
                    } else {
                        unit.CastAbilityNoTarget(ability, playerId);
                    }

                    return true;
                }
            }
        }

        return false;
    }

    function pickTargetPosition(unit: CDOTA_BaseNPC) {
        const worldLimits = 1000;
        const origin = unit.GetAbsOrigin();

        //@TODO: This is wrong, its calculating the position from the unit to world limits, not from the arena center
        const x = origin.x + RandomInt(-400, 400);
        const y = origin.y + RandomInt(-400, 400);

        if (IsInToolsMode()) {
            DebugDrawLine_vCol(origin, Vector(x, y, 128), Vector(255, 0, 0), true, 1.0);
        }

        return Vector(x, y);
    }

    function isInFollowDistance(target: CDOTA_BaseNPC) {
        const distance = distanceBetweenPoints(target.GetAbsOrigin(), unit.GetAbsOrigin());
        return distance > minFollowRange && distance < followRange;
    }

    function unitCanBeFollowed(target: CDOTA_BaseNPC) {
        return (
            !target.IsOutOfGame() &&
            !target.IsUnselectable() &&
            !target.IsInvulnerable() &&
            !target.IsInvisible() &&
            target.IsAlive() &&
            isInFollowDistance(target)
        );
    }

    function moveTowards(unit: CDOTA_BaseNPC, entity: Entity, point: Vector) {
        const origin = unit.GetAbsOrigin();
        const direction = direction2D(origin, point);
        setEntityDirection(entity, direction.x, direction.y);
    }

    function stopMovement(entity: Entity) {
        setEntityDirection(entity, 0, 0);
    }

    const isCasting = abilities.some(ability => ability.IsInAbilityPhase()) || isChanneling(unit) || ModifierCasting.findOne(unit);

    if (isInDeveloperMode()) {
        DebugDrawText((unit.GetAbsOrigin() + Vector(0, 128, 128)) as Vector, context.id, true, 0.03);
    }

    stopMovement(entity);

    if (context.id == "startedCasting") {
        return { id: "idle" };
    }

    if (!isCasting) {
        if (maybeCastSomeAbility(unit, allies, enemies, abilities)) {
            return {
                id: "startedCasting"
            };
        }

        if (behavior == "static") {
            return context;
        }

        if (context.id == "resting") {
            return triggerNow(context.restTrigger) ? { id: "idle" } : context;
        }

        if (context.id == "moving") {
            if (distanceBetweenPoints(context.target, unit.GetAbsOrigin()) < 10 || triggerNow(context.moveTrigger)) {
                return {
                    id: "resting",
                    restTrigger: simpleTrigger(GameRules.GetGameTime() + 0.35)
                };
            }

            moveTowards(unit, entity, context.target);

            return context;
        }

        if (context.id == "following") {
            if (!isInFollowDistance(context.target)) {
                return {
                    id: "resting",
                    restTrigger: simpleTrigger(GameRules.GetGameTime() + 0.35)
                };
            }

            moveTowards(unit, entity, context.target.GetAbsOrigin());

            return context;
        }

        if (behavior == "wanderer") {
            return {
                id: "moving",
                target: pickTargetPosition(unit),
                moveTrigger: simpleTrigger(GameRules.GetGameTime() + 3)
            };
        }

        if (behavior == "follower") {
            const target = findClosestGuy(unit, enemies.filter(unitCanBeFollowed));

            if (target) {
                return {
                    id: "following",
                    target: target
                };
            }
        }
    }

    if (context.id == "resting") {
        return triggerNow(context.restTrigger) ? { id: "idle" } : context;
    }

    return context;
}

export namespace rules {
    export function inAOERadius(specificValue?: number | string | ((ctx: RuleContext) => number)): Rule {
        return (target, ctx) => {
            const distance = ((ctx.caster.GetAbsOrigin() - target.GetAbsOrigin()) as Vector).Length2D();
            const radiusFromSpecial = ctx.ability.GetSpecialValueFor("radius");
            const radius = specificValue
                ? typeof specificValue == "function"
                    ? specificValue(ctx)
                    : valueOrSpecial(ctx.ability, specificValue)
                : radiusFromSpecial != 0
                ? radiusFromSpecial
                : ctx.ability.GetAOERadius();
            return distance <= radius;
        };
    }

    export function isClosest(): Rule {
        return (target, ctx, remaining) => {
            // @Performance If you thought this is slow, then you'd be totally right, but idgaf and you probably shouldn't either
            const closest = findClosestGuy(ctx.caster, remaining);
            return closest == target;
        };
    }

    export function ally(): Rule {
        return (target, ctx) => ctx.allies.includes(target);
    }

    export function enemy(): Rule {
        return (target, ctx) => ctx.enemies.includes(target);
    }
}
