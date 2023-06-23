/* eslint-disable @typescript-eslint/no-non-null-assertion */
enum CustomAIState {
    IDLE = 0,
    WANDERING,
    RESTING
}

enum CustomAIBehavior {
    FOLLOWER = 0,
    WANDERER,
    STATIC
}

export enum CustomAITier {
    BASIC = 1,
    MID,
    HIGH,
    BOSS
}

export enum NPCNames {
    DIRE_ZOMBIE_RANGE = 0,
    DIRE_ZOMBIE_RANGE_MEGA,
    DIRE_ZOMBIE_MEELE_MEGA,
    RADIANT_ZOMBIE_RANGE_MEGA,
    RADIANT_ZOMBIE_MEELE_MEGA,
    FLYING_SKULL,
    DIRE_TOWER,
    QUEEN,
    CENTAUR
}
interface CustomAIAbilityRequirements {
    cooldownReady?: boolean;
    phaseReady?: boolean;
    targetInCastRange?: boolean;
    targetInRadius?: boolean;
}

interface CustomAIAbility {
    ability: CDOTABaseAbility;
    priority: number;
    requirements: CustomAIAbilityRequirements;
    cast(ability: CDOTABaseAbility, target: CDOTA_BaseNPC | undefined): void;
    orderType: UnitOrder;
}

interface CustomAIRegisterAbilityOptions {
    ability: CDOTABaseAbility;
    orderType: UnitOrder;
    requirements?: CustomAIAbilityRequirements;
}

interface CustomAIOptions {
    followRange?: number;
    minFollowRange?: number;
    restTime?: number;
    behavior?: CustomAIBehavior;
    shield?: boolean;
}

export type CustomAIType = {
    unit: CDOTA_BaseNPC;
    IsAbilityReady: (ability: CDOTABaseAbility) => boolean;
    RegisterAbility: (options: CustomAIRegisterAbilityOptions) => void;
    Update: () => void;
    BackToOrigin: (origin: Vector) => boolean;
};

function CustomAI(name: string, origin: Vector, options: CustomAIOptions): CustomAIType {
    const followRange = options.followRange ?? 2500;
    const restTime = options.restTime ?? 1.0;
    const tauntedFollowRange = followRange * 1.5;
    const minFollowRange = options.minFollowRange ?? 0;
    const behavior = options.behavior ?? CustomAIBehavior.FOLLOWER;
    const originalPosition = origin;
    const abilities: CustomAIAbility[] = [];
    const tauntedDuration = 3.0;
    const rangeOfAction = 3000;
    const unit = CreateUnitByName(name, origin, true, undefined, undefined, DotaTeam.CUSTOM_1);
    let state = CustomAIState.IDLE;
    let tauntedRemainingDuration = 0.0;
    let remainingRestTime = 0;
    let targetPosition: Vector | undefined;
    let followTarget: CDOTA_BaseNPC | undefined;

    if (options.shield) {
        unit.AddNewModifier(unit, undefined, "modifier_generic_npc_shield", {
            damage_block: unit.GetMaxHealth()
        });
        unit.AddNewModifier(unit, undefined, "modifier_generic_npc_mini_stun", {});
    }

    ListenToGameEvent("entity_hurt", event => OnUnitHurt(event), undefined);

    function FindEnemy(radius: number): CDOTA_BaseNPC | undefined {
        const units = FindUnitsInRadius(
            unit.GetTeamNumber(),
            unit.GetAbsOrigin(),
            undefined,
            radius,
            UnitTargetTeam.ENEMY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.NO_INVIS,
            FindOrder.ANY,
            false
        );

        if (units.length > 0) {
            return units[0];
        } else {
            return undefined;
        }
    }

    function UpdateTarget(): void {
        const currentFollowRange = tauntedRemainingDuration > 0 ? tauntedFollowRange : followRange;

        if (followTarget) {
            if (CustomEntitiesLegacy.GetDistance(unit, followTarget) <= currentFollowRange && !followTarget.IsInvisible()) {
                return;
            } else {
                followTarget = undefined;
            }
        } else {
            followTarget = FindEnemy(followRange);
        }
    }

    function Follow(): boolean {
        const origin = unit.GetAbsOrigin();
        UpdateTarget();

        if (followTarget && followTarget.IsAlive()) {
            const distance = CustomEntitiesLegacy.GetDistance(unit, followTarget);
            let direction = Vector(0, 0);

            if (followTarget.IsAlive() && distance > minFollowRange) {
                direction = followTarget.GetAbsOrigin().__sub(origin).Normalized();
            }

            CustomEntitiesLegacy.SetDirection(unit, direction.x, direction.y);
            return true;
        }
        return false;
    }

    function IsAbilityReady(ability: CDOTABaseAbility): boolean {
        return ability.IsCooldownReady() && !ability.IsInAbilityPhase();
    }

    function RegisterAbility(options: CustomAIRegisterAbilityOptions): void {
        const npcAbility: CustomAIAbility = {
            ability: options.ability,
            orderType: options.orderType,
            priority: abilities.length + 1,
            cast: (ability: CDOTABaseAbility, target: CDOTA_BaseNPC) => {
                ExecuteOrderFromTable({
                    OrderType: options.orderType,
                    UnitIndex: unit.GetEntityIndex(),
                    AbilityIndex: ability.GetEntityIndex(),
                    Position: (target && target.GetAbsOrigin()) || undefined
                });
            },
            requirements: options.requirements
                ? {
                      ...options.requirements,
                      cooldownReady: options.requirements.cooldownReady !== undefined ? options.requirements.cooldownReady : true,
                      phaseReady: options.requirements.phaseReady !== undefined ? options.requirements.phaseReady : true
                  }
                : {
                      cooldownReady: true,
                      phaseReady: true
                  }
        };
        abilities.push(npcAbility);
    }

    function StartRest(restTime: number): void {
        remainingRestTime = restTime * 30;
    }

    function BackToOrigin(origin: Vector): boolean {
        const distanceFromOrigin = originalPosition.__sub(origin).Length2D();

        if (rangeOfAction > distanceFromOrigin) {
            return false;
        }

        const direction = originalPosition.__sub(origin).Normalized();
        CustomEntitiesLegacy.SetDirection(unit, direction.x, direction.y);
        return true;
    }

    function Cast(): boolean {
        if (
            CustomEntitiesLegacy.IsDisplacing(unit) ||
            CustomEntitiesLegacy.IsCasting(unit) ||
            CustomEntitiesLegacy.IsChanneling(unit) ||
            remainingRestTime > 0
        ) {
            return false;
        }

        let abilityToExecute: CustomAIAbility | undefined = undefined;
        let abilityTarget: CDOTA_BaseNPC | undefined = undefined;
        abilities.forEach(npcAbility => {
            const ability = npcAbility.ability;

            // Don't quote me on this, im just fixing warnings
            // if (npcAbility.requirements) {
            if (npcAbility.requirements.cooldownReady) {
                if (!npcAbility.ability.IsCooldownReady()) {
                    return false;
                }
            }
            if (npcAbility.requirements.phaseReady) {
                if (npcAbility.ability.IsInAbilityPhase()) {
                    return false;
                }
            }
            if (npcAbility.requirements.targetInCastRange) {
                abilityTarget = FindEnemy(ability.GetCastRange(Vector(0, 0, 0), undefined));
                if (!abilityTarget) {
                    return false;
                }
            }
            if (npcAbility.requirements.targetInRadius) {
                abilityTarget = FindEnemy(ability.GetSpecialValueFor("radius"));
                if (!abilityTarget) {
                    return false;
                }
            }
            // }
            if (abilityToExecute == undefined) {
                abilityToExecute = npcAbility;
            }
            if (npcAbility.priority > abilityToExecute.priority) {
                abilityToExecute = npcAbility;
            }
        });

        if (abilityToExecute) {
            abilityToExecute = abilityToExecute as CustomAIAbility;
            abilityToExecute.cast(abilityToExecute.ability, abilityTarget);
            StartRest(restTime);
            return true;
        } else {
            return false;
        }
    }

    function StopMoving(): void {
        CustomEntitiesLegacy.SetDirection(unit, 0, 0);
    }

    function MoveTowards(point: Vector): boolean {
        const origin = unit.GetAbsOrigin();
        const distance = point.__sub(origin).Length2D();

        if (distance < 10) {
            return false;
        } else {
            const direction = point.__sub(origin).Normalized();
            CustomEntitiesLegacy.SetDirection(unit, direction.x, direction.y);
            return true;
        }
    }

    function PickTargetPosition(): void {
        const origin = unit.GetAbsOrigin();
        const worldLimits = 1500;
        const x = Clamp(origin.x + RandomInt(-400, 400), worldLimits, -worldLimits);
        const y = Clamp(origin.y + RandomInt(-400, 400), worldLimits, -worldLimits);
        targetPosition = Vector(x, y);
    }

    function ClearTargetPosition(): void {
        targetPosition = undefined;
    }

    function OnUnitHurt(event: EntityHurtEvent): void {
        const victim = EntIndexToHScript(event.entindex_killed) as CDOTA_BaseNPC;
        if (unit === victim) {
            tauntedRemainingDuration = tauntedDuration * 30;
        }
    }

    function Update(): void {
        if (tauntedRemainingDuration > 0) {
            tauntedRemainingDuration = tauntedRemainingDuration - 1;
        }
        if (remainingRestTime > 0) {
            remainingRestTime = remainingRestTime - 1;
        }
        if (!Cast()) {
            if (behavior === CustomAIBehavior.STATIC) {
                return;
            }
            if (behavior === CustomAIBehavior.WANDERER) {
                if (state === CustomAIState.WANDERING && targetPosition) {
                    if (!MoveTowards(targetPosition)) {
                        state = CustomAIState.IDLE;
                        ClearTargetPosition();
                        StopMoving();
                    }
                } else {
                    state = CustomAIState.WANDERING;
                    PickTargetPosition();
                }
            } else {
                if (!Follow()) {
                    StopMoving();
                }
            }
        } else {
            remainingRestTime = 1.0 * 30;
            ClearTargetPosition();
            StopMoving();
        }
    }

    return {
        unit,
        IsAbilityReady,
        RegisterAbility,
        Update,
        BackToOrigin
    };
}

export const CustomAIMeta: {
    [key: number]: {
        factory: (origin: Vector) => CustomAIType;
        tier?: number;
    };
} = {
    [NPCNames.QUEEN]: {
        factory: (origin: Vector): CustomAIType => {
            const ai = CustomAI("npc_dota_hero_queenofpain", origin, {
                minFollowRange: 500
            });

            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName("queen_scream")!,
                orderType: UnitOrder.CAST_NO_TARGET
            });
            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName("queen_dodge")!,
                orderType: UnitOrder.CAST_NO_TARGET
            });
            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName("queen_blink")!,
                orderType: UnitOrder.CAST_POSITION,
                requirements: {
                    targetInCastRange: true
                }
            });
            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName("queen_daggers")!,
                orderType: UnitOrder.CAST_NO_TARGET
            });
            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName("queen_attack")!,
                orderType: UnitOrder.CAST_POSITION,
                requirements: {
                    targetInCastRange: true
                }
            });
            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName("queen_wave")!,
                orderType: UnitOrder.CAST_POSITION,
                requirements: {
                    targetInCastRange: true
                }
            });
            return ai;
        },
        tier: CustomAITier.BOSS
    },
    [NPCNames.CENTAUR]: {
        factory: (origin: Vector): CustomAIType => {
            const ai = CustomAI("npc_dota_hero_centaur", origin, {});

            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName("centaur_axe_attack")!,
                orderType: UnitOrder.CAST_POSITION,
                requirements: {
                    targetInRadius: true
                }
            });
            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName("centaur_range_attack")!,
                orderType: UnitOrder.CAST_POSITION,
                requirements: {
                    targetInCastRange: true
                }
            });
            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName("centaur_short_attack")!,
                orderType: UnitOrder.CAST_NO_TARGET,
                requirements: {
                    targetInRadius: true
                }
            });
            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName("centaur_charge")!,
                orderType: UnitOrder.CAST_POSITION,
                requirements: {
                    targetInCastRange: true
                }
            });
            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName("centaur_rage")!,
                orderType: UnitOrder.CAST_NO_TARGET
            });
            return ai;
        },
        tier: CustomAITier.BOSS
    },
    [NPCNames.RADIANT_ZOMBIE_RANGE_MEGA]: {
        factory: (origin: Vector): CustomAIType => {
            const ai = CustomAI("radiant_creep_range_mega", origin, {
                behavior: CustomAIBehavior.WANDERER,
                shield: true
            });

            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName("radiant_zombie_heal_aura")!,
                orderType: UnitOrder.CAST_NO_TARGET
            });
            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName("dire_zombie_attack")!,
                orderType: UnitOrder.CAST_POSITION,
                requirements: {
                    targetInCastRange: true
                }
            });
            return ai;
        },
        tier: CustomAITier.MID
    },
    [NPCNames.DIRE_ZOMBIE_RANGE]: {
        factory: (origin: Vector): CustomAIType => {
            const ai = CustomAI("dire_creep_range", origin, {
                behavior: CustomAIBehavior.WANDERER,
                shield: true
            });

            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName("dire_creep_attack_range")!,
                orderType: UnitOrder.CAST_POSITION,
                requirements: {
                    targetInCastRange: true
                }
            });
            return ai;
        },
        tier: CustomAITier.BASIC
    },
    [NPCNames.DIRE_ZOMBIE_RANGE_MEGA]: {
        factory: (origin: Vector): CustomAIType => {
            const ai = CustomAI("dire_creep_range_mega", origin, {
                behavior: CustomAIBehavior.WANDERER,
                shield: true
            });

            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName("dire_creep_rage_aura")!,
                orderType: UnitOrder.CAST_NO_TARGET
            });
            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName("dire_creep_attack_range")!,
                orderType: UnitOrder.CAST_POSITION,
                requirements: {
                    targetInCastRange: true
                }
            });
            return ai;
        },
        tier: CustomAITier.MID
    },
    [NPCNames.DIRE_ZOMBIE_MEELE_MEGA]: {
        factory: (origin: Vector): CustomAIType => {
            const ai = CustomAI("dire_creep_meele_mega", origin, {
                followRange: 1500,
                minFollowRange: 200,
                behavior: CustomAIBehavior.FOLLOWER,
                shield: true
            });

            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName("dire_creep_attack_meele")!,
                orderType: UnitOrder.CAST_POSITION,
                requirements: {
                    targetInCastRange: true
                }
            });

            ai.unit.SetHullRadius(95);
            return ai;
        },
        tier: CustomAITier.MID
    },
    [NPCNames.RADIANT_ZOMBIE_MEELE_MEGA]: {
        factory: (origin: Vector): CustomAIType => {
            const ai = CustomAI("radiant_creep_meele_mega", origin, {
                followRange: 1500,
                minFollowRange: 200,
                behavior: CustomAIBehavior.FOLLOWER,
                shield: true
            });

            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName("dire_zombie_attack_meele")!,
                orderType: UnitOrder.CAST_POSITION,
                requirements: {
                    targetInCastRange: true
                }
            });

            ai.unit.SetHullRadius(95);
            return ai;
        },
        tier: CustomAITier.BASIC
    },
    [NPCNames.FLYING_SKULL]: {
        factory: (origin: Vector): CustomAIType => {
            const ai = CustomAI("flying_skull", origin, {
                followRange: 1000,
                minFollowRange: 150,
                behavior: CustomAIBehavior.FOLLOWER,
                shield: true
            });

            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName("flying_skull_dash")!,
                orderType: UnitOrder.CAST_POSITION,
                requirements: {
                    targetInCastRange: true
                }
            });

            return ai;
        },
        tier: CustomAITier.BASIC
    },
    [NPCNames.DIRE_TOWER]: {
        factory: (origin: Vector): CustomAIType => {
            const ai = CustomAI("dire_tower", origin, {
                behavior: CustomAIBehavior.STATIC
            });

            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName("dire_tower_attack")!,
                orderType: UnitOrder.CAST_POSITION,
                requirements: {
                    targetInCastRange: true
                }
            });
            ai.unit.SetHullRadius(100);
            return ai;
        },
        tier: CustomAITier.HIGH
    }
};
