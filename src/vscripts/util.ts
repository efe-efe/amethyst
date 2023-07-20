import {
    CustomModifierMotionBoth,
    CustomModifierMotionHorizontal,
    CustomModifierMotionVertical
} from "./abilities/framework/custom_modifier";
import { allianceDefinitions, findAllianceDefinitionByUnit } from "./alliance_definitions";
import { ModifierBanish } from "./modifiers/modifier_banish";
import { ModifierChanneling } from "./modifiers/modifier_channeling";
import { ModifierCharges } from "./modifiers/modifier_charges";
import { ModifierCounter } from "./modifiers/modifier_counter";
import { ModifierEnergy } from "./modifiers/modifier_energy";
import { ModifierGem } from "./modifiers/modifier_gem";
import { ModifierHideBar } from "./modifiers/modifier_hide_bar";
import { ModifierObstacle } from "./modifiers/modifier_obstacle";
import { ModifierRadiusMarker } from "./modifiers/modifier_radius_marker";
import { ModifierRecast } from "./modifiers/modifier_recast";
import { ModifierWall } from "./modifiers/modifier_wall";
import { precache, resource } from "./precache";
//@Refactor the amount of imports on an utils file SCREAMS for an import loop...

const resources = precache({
    damage: resource.fx("particles/msg_damage.vpcf"),
    replenishStart: resource.fx("particles/units/heroes/hero_wisp/wisp_death.vpcf"),
    meele: resource.fx("particles/juggernaut/juggernaut_basic_attack_parent.vpcf"),
    meeleDust: resource.fx("particles/juggernaut/juggernaut_basic_attack_dust.vpcf"),
    aoeMark: resource.fx("particles/aoe_marker.vpcf")
});

function getRecastModifiers(unit: CDOTA_BaseNPC) {
    return ModifierRecast.findAll(unit);
}

export function* allAbilities(unit: CDOTA_BaseNPC) {
    for (let index = 0; index < unit.GetAbilityCount(); index++) {
        const ability = unit.GetAbilityByIndex(index);

        if (ability) {
            yield ability;
        }
    }
}

//@Refactor maybe this should change... for now I'll keep it as it is
export function deactivateNonPriorityAbilities(unit: CDOTA_BaseNPC) {
    if (IsServer()) {
        //@Refactor Maybe this is the reason why we use yield thing in AA
        for (let i = 0; i <= 10; i++) {
            const ability = unit.GetAbilityByIndex(i);

            if (ability) {
                // if (!ability.IsCounter() && !ability.IsMobility() && !ability.IsUltimate() && !ability.HasPriority()) {
                ability.SetActivated(false);
                // }
            }
        }
    }
}

export function clamp(value: number, max: number, min: number) {
    if (max && value > max) {
        return max;
    }
    if (min && value < min) {
        return min;
    }
    return value;
}

export function overheadMessageEFX(unit: CDOTA_BaseNPC, value: number, wordLength: number, color: Vector, shield: 7 | 0) {
    const duration = math.max(1, value / 10);

    EFX(resources.damage.path, ParticleAttachment.WORLDORIGIN, undefined, {
        cp0: unit.GetAbsOrigin(),
        cp1: Vector(0, value, shield),
        cp2: Vector(duration, wordLength, 0),
        cp3: color,
        release: true
    });
}

export function sendOverheadDamageMessage(unit: CDOTA_BaseNPC, value: number) {
    const wordLength = string.len(tostring(math.floor(value)));
    const color = Vector(250, 70, 70);

    overheadMessageEFX(unit, value, wordLength, color, 0);
}

export function sendOverheadHealMessage(unit: CDOTA_BaseNPC, value: number) {
    const wordLength = string.len(tostring(math.floor(value))) + 1; //TODO: @Refactor Improve this
    const color = Vector(70, 250, 70);

    overheadMessageEFX(unit, value, wordLength, color, 0);
}

export function sendOverheadShieldMessage(unit: CDOTA_BaseNPC, value: number) {
    const wordLength = string.len(tostring(math.floor(value))) + 1; //TODO: @Refactor Improve this
    const color = Vector(255, 255, 255);

    overheadMessageEFX(unit, value, wordLength, color, 7);
}

export function sendOverheadEnergyMessage(unit: CDOTA_BaseNPC, value: number) {
    const wordLength = string.len(tostring(math.floor(value))) + 1; //TODO: @Refactor Improve this
    const color = Vector(255, 243, 140);

    overheadMessageEFX(unit, value, wordLength, color, 0);
}

export function sendOverheadManaMessage(unit: CDOTA_BaseNPC, value: number) {
    const wordLength = string.len(tostring(math.floor(value))) + 1; //TODO: @Refactor Improve this
    const color = Vector(27, 113, 230);

    overheadMessageEFX(unit, value, wordLength, color, 0);
}

export function setEnergy(unit: CDOTA_BaseNPC, amount: number, informClient: boolean) {
    ModifierEnergy.findOne(unit)?.SetStackCount(Math.max(0, Math.min(Constants.maxEnergy, amount)));

    if (informClient) {
        // CustomEntitiesLegacy:SendDataToClient(unit)
    }
}

export function getMaxEnergy() {
    return Constants.maxEnergy;
}

export function getEnergy(unit: CDOTA_BaseNPC) {
    return ModifierEnergy.findOne(unit)?.GetStackCount() ?? 0;
}

export function giveMana(unit: CDOTA_BaseNPC, amount: number, informClient: boolean, showOverhead: boolean) {
    // if(GameRules.Addon:IsPVE()){
    // 	amount = amount / 2
    // }

    //@Refactor this is too specific
    if (unit.HasModifier("modifier_sapphire")) {
        amount = amount * 2;
    }

    unit.GiveMana(amount);

    if (informClient) {
        // sendDataToClient(unit);
    }
    if (showOverhead) {
        sendOverheadManaMessage(unit, amount);
    }
}

export function giveManaPercent(unit: CDOTA_BaseNPC, percentage: number, informClient: boolean, showOverhead: boolean) {
    const mana = (unit.GetMaxMana() * percentage) / 100;
    giveMana(unit, mana, informClient, showOverhead);
}

export function giveEnergyPercent(unit: CDOTA_BaseNPC, percentage: number, informClient: boolean, showOverhead: boolean) {
    const energy = (getMaxEnergy() * percentage) / 100;
    giveEnergy(unit, energy, informClient, showOverhead);
}

export function giveEnergy(unit: CDOTA_BaseNPC, amount: number, informClient: boolean, showOverhead: boolean) {
    // if(GameRules.Addon:IsPVE()){
    // 	energy = energy / 2
    // }

    setEnergy(unit, getEnergy(unit) + amount, informClient);

    if (showOverhead) {
        sendOverheadEnergyMessage(unit, amount);
    }
}

export function giveManaAndEnergyPercent(unit: CDOTA_BaseNPC, percentage: number, informClient: boolean, showOverhead = true) {
    giveManaPercent(unit, percentage, false, showOverhead);
    giveEnergyPercent(unit, percentage, false, showOverhead);

    if (informClient) {
        // CustomEntitiesLegacy:SendDataToClient(unit)
    }
}

export function giveManaAndEnergy(unit: CDOTA_BaseNPC, amount: number, informClient: boolean, showOverhead = true) {
    giveEnergy(unit, amount, false, showOverhead);
    giveMana(unit, amount, false, showOverhead);

    if (informClient) {
        // CustomEntitiesLegacy:SendDataToClient(unit)
    }
}

export function replenishEFX(target: CDOTA_BaseNPC) {
    const origin = target.GetAbsOrigin();

    const particleId = ParticleManager.CreateParticle(resources.replenishStart.path, ParticleAttachment.CUSTOMORIGIN, target);
    ParticleManager.SetParticleControlEnt(particleId, 0, target, ParticleAttachment.POINT_FOLLOW, "attach_attack1", origin, true);
    ParticleManager.ReleaseParticleIndex(particleId);
}

export function clampPosition(origin: Vector, target: Vector, options?: { maxRange?: number; minRange?: number }) {
    const direction = target.__sub(origin).Normalized();
    const distance = target.__sub(origin).Length2D();
    let result = target;

    if (options?.maxRange && distance > options?.maxRange) {
        result = direction.__mul(options?.maxRange).__add(origin);
    }

    if (options?.minRange && distance < options.minRange) {
        result = direction.__mul(options?.minRange).__add(origin);
    }

    return result;
}

export function direction2D(from: Vector, to: Vector) {
    return Vector(to.x - from.x, to.y - from.y, 0).Normalized();
}

export function meeleEFX(caster: CDOTA_BaseNPC, direction: Vector, radius: number, color?: Vector) {
    const origin = caster.GetAbsOrigin();

    const efx = EFX(resources.meele.path, ParticleAttachment.WORLDORIGIN, undefined, {
        cp0: origin,
        cp0f: direction,
        cp3: Vector(radius, 0, 0)
    });

    if (color) {
        ParticleManager.SetParticleControl(efx, 60, color);
        ParticleManager.SetParticleControl(efx, 61, Vector(1, 0, 0));
    }

    ParticleManager.ReleaseParticleIndex(efx);

    EFX(resources.meeleDust.path, ParticleAttachment.ABSORIGIN_FOLLOW, caster, {
        release: true
    });

    if (radius > 300) {
        meeleEFX(caster, direction, 200, color);
    }
}

export function isConsideredWall(unit: CDOTA_BaseNPC) {
    return ModifierWall.findOne(unit);
}

export function isObstacle(unit: CDOTA_BaseNPC) {
    return ModifierObstacle.findOne(unit);
}

export function isGem(unit: CDOTA_BaseNPC) {
    return ModifierGem.findOne(unit);
}

export function isCountering(unit: CDOTA_BaseNPC) {
    return unit.FindAllModifiers().some(modifier => modifier instanceof ModifierCounter);
}

export function isChanneling(unit: CDOTA_BaseNPC) {
    return unit.FindAllModifiers().some(modifier => modifier instanceof ModifierChanneling);
}

export function isBanished(unit: CDOTA_BaseNPC) {
    return unit.FindAllModifiers().some(modifier => modifier instanceof ModifierBanish);
}

export function attackWithBaseDamage(options: {
    source: CDOTA_BaseNPC;
    target: CDOTA_BaseNPC;
    multiplier?: number;
    damageType?: DamageTypes;
    ability?: CDOTABaseAbility;
}) {
    const preAttackDamage = 0;
    const multiplier = options.multiplier ?? 1;
    const damageType = options.damageType ?? DamageTypes.PHYSICAL;

    // for key, value in pairs(CustomEntitiesLegacy:GetAllModifiersWithType(source, MODIFIER_TYPES.PRE_ATTACK_DAMAGE)) do
    // 	const hModifier = source:FindModifierByName(value)

    // 	if(hModifier ~= undefined){
    // 		if(not hModifier:IsNull()){
    // 			preAttackDamage = preAttackDamage + hModifier:GetPreAttackDamage({
    // 				victim = options.hTarget
    // 			})
    // 		}
    // 	}
    // }

    ApplyDamage({
        victim: options.target,
        attacker: options.source,
        damage: Math.floor((options.source.GetAverageTrueAttackDamage(options.target) + preAttackDamage) * multiplier),
        damage_type: damageType,
        ability: options.ability
    });
}

export function callEntityFuncSafe<K extends string>(entity: { [A in K]: () => void }, key: K) {
    try {
        entity[key]();
    } catch (error) {
        print(error);
    }
}

function isDisplacing(unit: CDOTA_BaseNPC) {
    for (const modifier of unit.FindAllModifiers()) {
        if (
            modifier instanceof CustomModifierMotionHorizontal ||
            modifier instanceof CustomModifierMotionVertical ||
            modifier instanceof CustomModifierMotionBoth
        ) {
            return true;
        }
    }

    return false;
}

export function fullyFaceTowards(unit: CDOTA_BaseNPC, direction: Vector) {
    if (!isDisplacing(unit)) {
        unit.SetForwardVector(direction);
        unit.FaceTowards(unit.GetAbsOrigin().__add(direction));
    }
}

export function strongPurge(unit: CDOTA_BaseNPC) {
    unit.Purge(false, true, false, true, false);
}

export function hideHealthBar(unit: CDOTA_BaseNPC, duration?: number) {
    ModifierHideBar.apply(unit, unit, undefined, { duration });
}

export function unhideHealthBar(unit: CDOTA_BaseNPC) {
    unit.RemoveModifierByName(ModifierHideBar.name);
}

export function createTimedRadiusMarker(
    caster: CDOTA_BaseNPC,
    origin: Vector,
    radius: number,
    delay: number,
    duration: number,
    scope: "public" | "local"
) {
    const [, modifier] = ModifierRadiusMarker.createThinker(caster, undefined, origin, {
        radius: radius,
        delayTime: delay,
        duration: duration + delay,
        scope: scope
    });

    return {
        destroy: () => modifier?.Destroy()
    };
}

export interface Lock {
    locked: boolean;
}

export function lock(): Lock {
    return {
        locked: false
    };
}

export function tryLock<T>(lock: Lock, thenDo: () => T, orElse: T) {
    if (lock.locked) {
        return orElse;
    } else {
        lock.locked = true;
        const value = thenDo();
        lock.locked = false;
        return value;
    }
}

export function interpolate(value: number, min: number, max: number) {
    return value * (max - min) + min;
}

export function fakeAbility(ability: CDOTABaseAbility) {
    if (RandomInt(1, 10) < 3) {
        ability.StartCooldown(0.35);
        return true;
    }

    return false;
}

export function getCursorPosition(source: CDOTA_BaseNPC) {
    const playerId = IsInToolsMode() ? 0 : source.GetPlayerOwnerID();
    return GameRules.Addon.GetCursorPositionForPlayer(playerId);
}

type AbilityKV = Partial<Record<"AbilityEnergyCost", string | number>>;

export function getAbilityEnergyCost(ability: CDOTABaseAbility) {
    function getValueFromKV(ability: CDOTABaseAbility, key: keyof AbilityKV) {
        const abilityKV = ability.GetAbilityKeyValues() as AbilityKV;

        const value = abilityKV[key];

        if (value) {
            return typeof value == "number" ? value : parseInt(value.split(" ")[ability.GetLevel()]);
        }
    }

    return getValueFromKV(ability, "AbilityEnergyCost") ?? 0;
}

const flagToPowerOfTwo = new LuaMap<AbilityBehavior, number>();

function getBehaviorBit(behavior: AbilityBehavior) {
    function whichBitSet() {
        for (let bit = 0; bit < 32; bit++) {
            if (Math.pow(2, bit) >= behavior) {
                return bit;
            }
        }

        return -1;
    }

    const stored = flagToPowerOfTwo.get(behavior);

    if (stored == undefined) {
        const computed = whichBitSet();
        flagToPowerOfTwo.set(behavior, computed);
        return computed;
    } else {
        return stored;
    }
}

export function hasBehavior(behavior: Uint64 | AbilityBehavior, flag: AbilityBehavior) {
    if (typeof behavior == "number") {
        return (behavior & flag) != 0;
    } else {
        return behavior.IsBitSet(getBehaviorBit(flag));
    }
}

// function CustomAbilitiesLegacy:LinkUpgrades(hAbility, sLinkedAbilityName)
//     local caster = hAbility:GetCaster()
//     local linkedAbility = caster:FindAbilityByName(sLinkedAbilityName)
//     if linkedAbility and linkedAbility:GetLevel() == 0 then
//         linkedAbility:UpgradeAbility(true)
//     end
// end

export function distanceBetweenEntities(entity1: CBaseEntity, entity2: CBaseEntity): number {
    return distanceBetweenPoints(entity1.GetAbsOrigin(), entity2.GetAbsOrigin());
}

export function distanceBetweenPoints(point1: Vector, point2: Vector): number {
    return ((point1 - point2) as Vector).Length2D();
}

export function isPlayerHero(hero: CDOTA_BaseNPC) {
    return hero.GetPlayerOwnerID() != -1;
}

export function canUnitWalk(unit: CDOTA_BaseNPC) {
    return !(unit.IsStunned() || unit.IsCommandRestricted() || unit.IsRooted() || unit.IsNightmared() || !unit.IsAlive());
}

export function createRadiusMarker(unit: CDOTA_BaseNPC, origin: Vector, radius: number, scope: "public" | "local", duration: number) {
    function radiusMarkerEfx(particleId: ParticleID, origin: Vector, radius: number, color: Vector, duration: number) {
        ParticleManager.SetParticleControl(particleId, 0, origin);
        ParticleManager.SetParticleControl(particleId, 1, Vector(radius, 1, 1));
        ParticleManager.SetParticleControl(particleId, 2, color);
        ParticleManager.SetParticleControl(particleId, 3, Vector(duration, 0, 0));
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    const red = Vector(255, 1, 1);
    const green = Vector(1, 255, 1);

    if (scope == "public") {
        for (const alliance of allianceDefinitions) {
            for (const team of alliance.teams) {
                const color = unit.GetTeamNumber() == team ? green : red;
                radiusMarkerEfx(
                    ParticleManager.CreateParticleForTeam(resources.aoeMark.path, ParticleAttachment.WORLDORIGIN, undefined, team),
                    origin,
                    radius,
                    color,
                    duration
                );
            }
        }
        return;
    }

    radiusMarkerEfx(
        ParticleManager.CreateParticleForPlayer(resources.aoeMark.path, ParticleAttachment.WORLDORIGIN, undefined, unit.GetPlayerOwner()),
        origin,
        radius,
        green,
        duration
    );
}

export function areUnitsAllied(unitLeft: CDOTA_BaseNPC, unitRight: CDOTA_BaseNPC) {
    return findAllianceDefinitionByUnit(unitLeft) == findAllianceDefinitionByUnit(unitRight);
}

export function findUnitsInRadius(
    source: CDOTA_BaseNPC,
    origin: Vector,
    radius: number,
    teamFilter: UnitTargetTeam,
    typeFilter: UnitTargetType,
    flagFilter: UnitTargetFlags,
    orderFilter: FindOrder
) {
    const units = FindUnitsInRadius(
        source.GetTeamNumber(),
        origin,
        undefined,
        radius,
        UnitTargetTeam.BOTH,
        typeFilter,
        flagFilter,
        orderFilter,
        false
    );

    return filterUnitsByTeamConsideringAlliances(source, units, teamFilter);
}

export function findUnitsInLine(
    source: CDOTA_BaseNPC,
    startPosition: Vector,
    endPosition: Vector,
    radius: number,
    teamFilter: UnitTargetTeam,
    typeFilter: UnitTargetType,
    flagFilter: UnitTargetFlags
) {
    const units = FindUnitsInLine(
        source.GetTeamNumber(),
        startPosition,
        endPosition,
        undefined,
        radius,
        teamFilter,
        typeFilter,
        flagFilter
    );

    return filterUnitsByTeamConsideringAlliances(source, units, teamFilter);
}

export function findUnitsInCone(
    source: CDOTA_BaseNPC, //TODO: @Refactor Change this for team
    direction: Vector,
    minProjection: number,
    center: Vector,
    radius: number,
    teamFilter: UnitTargetTeam,
    typeFilter: UnitTargetType,
    flagFilter: UnitTargetFlags,
    orderFilter: FindOrder
) {
    //minProjection is a value from -1 to 1, 1 when the unit is aligned with direction, -1 is the vector opposite to direction
    return findUnitsInRadius(source, center, radius, teamFilter, typeFilter, flagFilter, orderFilter).filter(unit => {
        const directionToUnit = direction2D(center, unit.GetAbsOrigin());
        const projection = directionToUnit.x * direction.x + directionToUnit.y * direction.y;

        return projection >= minProjection;
    });
}

function filterUnitsByTeamConsideringAlliances(source: CDOTA_BaseNPC, units: CDOTA_BaseNPC[], teamFilter: UnitTargetTeam) {
    return units.filter(
        unit =>
            (teamFilter == UnitTargetTeam.FRIENDLY && areUnitsAllied(source, unit)) ||
            (teamFilter == UnitTargetTeam.ENEMY && !areUnitsAllied(source, unit)) ||
            teamFilter == UnitTargetTeam.BOTH
    );
}

export interface SimpleTrigger {
    triggerAt: number;
    triggered: boolean;
}

export function simpleTrigger(triggerAt: number): SimpleTrigger {
    return {
        triggerAt,
        triggered: false
    };
}

export function triggerNow(timer: SimpleTrigger) {
    if (GameRules.GetGameTime() >= timer.triggerAt && !timer.triggered) {
        timer.triggered = true;
        return true;
    } else {
        return false;
    }
}

export function refreshCooldowns(unit: CDOTA_BaseNPC) {
    for (const ability of allAbilities(unit)) {
        ability.EndCooldown();

        if (ability.GetToggleState()) {
            ability.ToggleAbility();
        }
    }

    for (const modifier of unit.FindAllModifiers()) {
        if (modifier instanceof ModifierCharges) {
            modifier.RefreshCharges();
        }
    }
}

export function randomInArray<T>(array: readonly T[]): T {
    return array[RandomInt(0, array.length - 1)];
}

export function randomInArraySafe<T>(array: readonly T[]): T | undefined {
    return randomInArray(array);
}

export function shuffleArray<T>(array: readonly T[]) {
    return nRandomInArray(array, array.length);
}

export function nRandomInArray<T>(array: readonly T[], n: number): T[] {
    const copy = [...array];
    const result: T[] = [];

    for (; n > 0; n--) {
        const taken = takeRandomFromArray(copy);
        if (taken) {
            result.push(taken);
        }
    }

    return result;
}

export function takeNRandomFromArrayWeighted<T>(array: T[], n: number, scale: (value: T) => number): T[] {
    const result: T[] = [];

    for (; n > 0; n--) {
        const taken = takeRandomFromArrayWeighted(array, scale);
        if (taken) {
            result.push(taken);
        }
    }

    return result;
}

export function takeRandomFromArrayUnsafe<T>(array: T[]): T {
    const randomIndex = RandomInt(0, array.length - 1);
    return array.splice(randomIndex, 1)[0];
}

export function takeRandomFromArray<T>(array: T[]): T | undefined {
    return takeRandomFromArrayUnsafe(array);
}

export function takeRandomFromArrayWeightedUnsafe<T>(entries: T[], scale: (element: T) => number): T {
    const sum = entries.reduce((prev, curr) => prev + scale(curr), 0);

    if (sum == 0) {
        return takeRandomFromArrayUnsafe(entries);
    }

    const selected = RandomFloat(0, sum);

    for (let index = 0, total = 0; index < entries.length; index++) {
        const entry = entries[index];
        total += scale(entry);

        if (selected <= total) {
            return entries.splice(index, 1)[0];
        }
    }

    return entries.splice(0, 1)[0];
}

export function takeRandomFromArrayWeighted<T>(entries: T[], scale: (element: T) => number): T | undefined {
    if (entries.length == 0) return;

    return takeRandomFromArrayWeightedUnsafe(entries, scale);
}

export function isInDeveloperMode() {
    return IsInToolsMode();
}

export function findElementWithSmallestValue<T>(elements: readonly T[], valueFunction: (value: T) => number): T | undefined {
    let min: number = math.huge;
    let smallest: T | undefined;

    for (const element of elements) {
        const value = valueFunction(element);

        if (value < min) {
            min = value;
            smallest = element;
        }
    }

    return smallest;
}

export function valueOrSpecial(ability: CDOTABaseAbility, valueOrName: number | string): number {
    return typeof valueOrName == "number" ? valueOrName : ability.GetSpecialValueFor(valueOrName);
}

export function encodeToJson<T>(value: T): Json<T> {
    return json.encode(value) as unknown as Json<T>;
}

export function decodeFromJson<T>(value: Json<T>) {
    const jsonString = value as unknown as string;
    const [result] = json.decode(jsonString);
    if (result != undefined) {
        return result as T;
    } else {
        throw `Failed to decode json: ${jsonString}`;
    }
}
