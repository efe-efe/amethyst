import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";
import { ModifierFadingSlow } from "./modifier_fading_slow";

@registerModifier({ customNameForI18n: "modifier_adrenaline" })
export class ModifierAdrenaline extends CustomModifier<undefined> {
    speedBuffPct = 20;
    slowDuration = 2.0;
    maxSlowPct = 100;

    IsHidden() {
        return false;
    }
    IsDebuff() {
        return false;
    }
    IsPurgable() {
        return true;
    }

    OnDestroy() {
        if (IsServer()) {
            this.PlayEffects();
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.ON_TAKEDAMAGE, ModifierFunction.MOVESPEED_BONUS_PERCENTAGE, ModifierFunction.ON_ABILITY_EXECUTED];
    }

    OnTakeDamage(event: ModifierInstanceEvent) {
        if (IsServer()) {
            if (event.unit != this.caster) {
                return;
            }

            ModifierFadingSlow.apply(event.unit, event.unit, undefined, {
                duration: this.slowDuration,
                maxSlowPct: this.maxSlowPct
            });

            this.Destroy();
        }
    }

    GetModifierMoveSpeedBonus_Percentage() {
        return this.speedBuffPct;
    }

    OnAbilityExecuted(event: ModifierAbilityEvent) {
        if (IsServer()) {
            if (event.unit != this.parent) {
                return;
            }
            if (
                event.ability.GetName() == "item_death_orb" ||
                event.ability.GetName() == "item_mana_orb" ||
                event.ability.GetName() == "item_health_orb" ||
                event.ability.GetName() == "item_shield_orb"
            ) {
                return;
            }
            this.Destroy();
        }
    }

    GetEffectName() {
        return "particles/adrenaline/adrenaline_owner.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.ABSORIGIN_FOLLOW;
    }

    GetTexture() {
        return "modifier_adrenaline";
    }

    PlayEffects() {
        EmitSoundOn("DOTA_Item.Sheepstick.Activate", this.GetParent());

        ParticleManager.ReleaseParticleIndex(
            ParticleManager.CreateParticle(
                "particles/units/heroes/hero_lion/lion_spell_voodoo.vpcf",
                ParticleAttachment.ABSORIGIN,
                this.parent
            )
        );
    }

    GetStatusEffectName() {
        return "particles/status_fx/status_effect_void_spirit_aether_remnant.vpcf";
    }
}
