import { findAbilityDefinitionByName } from "../abilities/framework/ability_definition";
import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";
import { precache, resource } from "../precache";
import { defineUpgrade } from "./framework/upgrade_definitions";

const resources = precache({
    chillStatusFx: resource.fx("particles/status_fx/status_effect_iceblast.vpcf"),
    ancientDash: resource.fx("particles/econ/items/ancient_apparition/ancient_apparation_ti8/ancient_ice_vortex_ti8_start.vpcf"),
    ancientExplosion: resource.fx("particles/creatures/aghanim/aghanim_crystal_attack_impact.vpcf")
});

@registerModifier()
class ModifierApparitionBasicAttack extends CustomModifier<undefined> {
    IsPermanent() {
        return true;
    }

    DeclareFunctions() {
        return [ModifierFunction.ON_TAKEDAMAGE];
    }

    OnTakeDamage(event: ModifierInstanceEvent) {
        if (IsServer() && event.inflictor && event.attacker == this.parent) {
            const definition = findAbilityDefinitionByName(event.inflictor.GetName());

            if (definition?.category == "basic") {
                ModifierApparitionChill.apply(event.unit, this.parent, undefined, { duration: 5 });
            }
        }
    }
}

@registerModifier()
class ModifierApparitionSpecialAttack extends CustomModifier<undefined> {
    IsPermanent() {
        return true;
    }

    DeclareFunctions() {
        return [ModifierFunction.ON_TAKEDAMAGE];
    }

    OnTakeDamage(event: ModifierInstanceEvent) {
        if (IsServer() && event.inflictor && event.attacker == this.parent) {
            const definition = findAbilityDefinitionByName(event.inflictor.GetName());

            if (definition?.category == "special") {
                ModifierApparitionChill.apply(event.unit, this.parent, undefined, { duration: 5 });
            }
        }
    }
}

@registerModifier()
class ModifierApparitionMobility extends CustomModifier<undefined> {
    IsPermanent() {
        return true;
    }

    DeclareFunctions() {
        return [ModifierFunction.ON_ABILITY_FULLY_CAST];
    }

    OnAbilityFullyCast(event: ModifierAbilityEvent) {
        if (IsServer() && event.unit == this.parent) {
            const definition = findAbilityDefinitionByName(event.ability.GetName());

            if (definition?.category == "mobility") {
                const particleId = ParticleManager.CreateParticle(resources.ancientDash.path, ParticleAttachment.WORLDORIGIN, this.parent);
                ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin());
                ParticleManager.ReleaseParticleIndex(particleId);

                const enemies = FindUnitsInRadius(
                    this.caster.GetTeam(),
                    this.parent.GetAbsOrigin(),
                    undefined,
                    250,
                    UnitTargetTeam.ENEMY,
                    UnitTargetType.HERO + UnitTargetType.CREEP,
                    UnitTargetFlags.NONE,
                    FindOrder.ANY,
                    false
                );

                for (const enemy of enemies) {
                    ModifierApparitionChill.apply(enemy, this.parent, undefined, { duration: 5 });
                }
            }
        }
    }
}

//TODO: This is a state. Should have it's own tooltips and values
@registerModifier()
class ModifierApparitionChill extends CustomModifier<undefined> {
    OnCreated() {
        if (IsServer()) {
            this.SetStackCount(1);
        }
    }

    OnRefresh() {
        const maxStacks = 10;

        if (IsServer() && this.GetStackCount() < maxStacks) {
            this.IncrementStackCount();

            if (this.GetStackCount() == maxStacks) {
                ParticleManager.ReleaseParticleIndex(
                    ParticleManager.CreateParticle(resources.ancientExplosion.path, ParticleAttachment.ABSORIGIN_FOLLOW, this.parent)
                );

                this.Destroy();
            }
        }
    }

    GetStatusEffectName() {
        return resources.chillStatusFx.path;
    }

    DeclareFunctions() {
        return [ModifierFunction.MOVESPEED_BONUS_PERCENTAGE];
    }

    GetModifierMoveSpeedBonus_Percentage() {
        return -20 * this.GetStackCount();
    }
}

defineUpgrade({
    type: UpgradeType.blessing,
    legendId: LegendId.apparition,
    icon: "file://{images}/spellicons/ancient_apparition_ice_vortex.png",
    id: UpgradeId.apparitionBasicAttack,
    modifier: ModifierApparitionBasicAttack
});

defineUpgrade({
    type: UpgradeType.blessing,
    legendId: LegendId.apparition,
    icon: "file://{images}/spellicons/ancient_apparition_ice_vortex.png",
    id: UpgradeId.apparitionSpecialAttack,
    modifier: ModifierApparitionSpecialAttack
});

defineUpgrade({
    type: UpgradeType.blessing,
    legendId: LegendId.apparition,
    icon: "file://{images}/spellicons/ancient_apparition_ice_vortex.png",
    id: UpgradeId.apparitionMobility,
    modifier: ModifierApparitionMobility
});
