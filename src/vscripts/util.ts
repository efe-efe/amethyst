import {
    CustomModifierMotionBoth,
    CustomModifierMotionHorizontal,
    CustomModifierMotionVertical
} from "./abilities/framework/custom_modifier";
import { ModifierGem } from "./modifiers/modifier_gem";
import { ModifierHideBar } from "./modifiers/modifier_hide_bar";
import { ModifierObstacle } from "./modifiers/modifier_obstacle";
import { ModifierRecast } from "./modifiers/modifier_recast";
import { ModifierWall } from "./modifiers/modifier_wall";

function getRecastModifiers(unit: CDOTA_BaseNPC) {
    return ModifierRecast.findAll(unit);
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

export function sendDataToClient(unit: CDOTA_BaseNPC) {
    if (unit.IsRealHero() && !unit.IsIllusion()) {
        let allianceName = "NOT_ALLIANCE";

        if (CustomEntitiesLegacy.GetAlliance(unit)) {
            allianceName = CustomEntitiesLegacy.GetAlliance(unit).GetName();
        }

        //TODO: @Refactor Fix the rest
        const data = {
            entityIndex: unit.GetEntityIndex(),
            teamId: unit.GetTeam(),
            playerId: unit.GetPlayerOwnerID(),
            allianceName: allianceName,
            name: unit.GetName(),
            health: unit.GetHealth(),
            maxHealth: unit.GetMaxHealth(),
            // treshold: CustomEntitiesLegacy:GetTreshold(unit),
            // shield: CustomEntitiesLegacy:GetShield(unit),
            mana: unit.GetMana(),
            maxMana: unit.GetMaxMana()
            // status: CustomEntitiesLegacy:GetStatus(unit),
            // recast: CustomEntitiesLegacy:GetRecast(unit),
            // stackbars: CustomEntitiesLegacy:GetStackbars(unit),
            // charges: CustomEntitiesLegacy:GetCharges(unit),
            // cooldown: CustomEntitiesLegacy:GetCooldown(unit),
            // abilities: CustomEntitiesLegacy:GetAbilities(unit),
            // energy: CustomEntitiesLegacy:GetEnergy(unit),
            // maxEnergy: CustomEntitiesLegacy:GetMaxEnergy(unit),
            // energyPerCell: CustomEntitiesLegacy:GetEnergyPerCell(unit),
        };
        //TODO: @Refactor Fix the "nevers";
        CustomNetTables.SetTableValue("units", tostring(unit.GetPlayerID()), data);
    } else {
        if (unit.IsIllusion()) {
            return;
        }

        const data = {
            playerId: undefined,
            entityIndex: unit.GetEntityIndex(),
            teamId: unit.GetTeam(),
            health: unit.GetHealth(),
            maxHealth: unit.GetMaxHealth()
            // shield: CustomEntitiesLegacy:GetShield(unit),
            // status: CustomEntitiesLegacy:GetStatus(unit),
            // beenHurt: CustomEntitiesLegacy:GetBeenHurt(unit),
        };
        CustomNetTables.SetTableValue("units" as never, tostring("_" + unit.GetEntityIndex()), data as never);
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

    EFX("particles/msg_damage.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
        cp0: unit.GetAbsOrigin(),
        cp1: Vector(0, value, shield),
        cp2: Vector(duration, wordLength, 0),
        cp3: color,
        release: true
    });
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

export function getMaxEnergy(unit: CDOTA_BaseNPC) {
    //TODO: @Refactor This should be a modifier
    return 0; //unit.max_energy
}

export function setEnergy(unit: CDOTA_BaseNPC, amount: number, informClient: boolean) {
    //TODO: @Refactor This should be a modifier
    // unit.energy = clamp(amount, getMaxEnergy(unit), 0)

    if (informClient) {
        // CustomEntitiesLegacy:SendDataToClient(unit)
    }
}

export function getEnergy(unit: CDOTA_BaseNPC) {
    //TODO: @Refactor This should be a modifier
    return 0; //unit.energy
}

export function giveMana(unit: CDOTA_BaseNPC, amount: number, informClient: boolean, showOverhead: boolean) {
    // if(GameRules.Addon:IsPVE()){
    // 	amount = amount / 2
    // }

    if (unit.HasModifier("modifier_sapphire")) {
        amount = amount * 2;
    }

    unit.GiveMana(amount);

    if (informClient) {
        sendDataToClient(unit);
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
    const energy = (getMaxEnergy(unit) * percentage) / 100;
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

    const particleId = ParticleManager.CreateParticle(
        "particles/units/heroes/hero_wisp/wisp_death.vpcf",
        ParticleAttachment.CUSTOMORIGIN,
        target
    );
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

export function direction2D(origin: Vector, target: Vector) {
    return Vector(target.x - origin.x, target.y - origin.y, 0).Normalized();
}

export function meeleEFX(caster: CDOTA_BaseNPC, direction: Vector, radius: number, color?: Vector) {
    const origin = caster.GetAbsOrigin();

    //TODO: @Refactor EFX should be re-implemented
    const efx = EFX("particles/juggernaut/juggernaut_basic_attack_parent.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
        cp0: origin,
        cp0f: direction,
        cp3: Vector(radius, 0, 0)
    });

    if (color) {
        ParticleManager.SetParticleControl(efx, 60, color);
        ParticleManager.SetParticleControl(efx, 61, Vector(1, 0, 0));
    }

    ParticleManager.ReleaseParticleIndex(efx);

    EFX("particles/juggernaut/juggernaut_basic_attack_dust.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, caster, {
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

function radiusMarkerEfx(particleId: ParticleID, origin: Vector, radius: number, color: Vector, duration: number) {
    ParticleManager.SetParticleControl(particleId, 0, origin);
    ParticleManager.SetParticleControl(particleId, 1, Vector(radius, 1, 1));
    ParticleManager.SetParticleControl(particleId, 2, color);
    ParticleManager.SetParticleControl(particleId, 3, Vector(duration, 0, 0));
    ParticleManager.ReleaseParticleIndex(particleId);
}

export function createRadiusMarker(unit: CDOTA_BaseNPC, origin: Vector, radius: number, scope: "public" | "local", duration: number) {
    const red = Vector(255, 1, 1);
    const green = Vector(1, 255, 1);

    if (scope == "public") {
        for (const alliance of GameRules.Addon.alliances) {
            for (const team of alliance.teams) {
                const color = unit.GetTeamNumber() == team ? green : red;
                radiusMarkerEfx(
                    ParticleManager.CreateParticleForTeam("particles/aoe_marker.vpcf", ParticleAttachment.WORLDORIGIN, undefined, team),
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
        ParticleManager.CreateParticleForPlayer(
            "particles/aoe_marker.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined,
            unit.GetPlayerOwner()
        ),
        origin,
        radius,
        green,
        duration
    );
}

export function randomInArray<T>(array: readonly T[]): T {
    return array[RandomInt(0, array.length - 1)];
}
