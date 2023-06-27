import { CustomAbility } from "../abilities/framework/custom_ability";
import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerAbility, registerModifier } from "../lib/dota_ts_adapter";
import { ModifierBanish } from "../modifiers/modifier_banish";
import { ModifierHideBar } from "../modifiers/modifier_hide_bar";

@registerAbility("item_butterfly_custom")
class ItemButterfly extends CustomAbility {
    OnSpellStart() {
        ModifeirItemButterfly.apply(this.caster, this.caster, this, { duration: this.GetSpecialValueFor("duration") });
        this.PlayEffectsOnCast();
    }

    PlayEffectsOnCast() {
        ParticleManager.ReleaseParticleIndex(
            ParticleManager.CreateParticle(
                "particles/econ/events/ti8/phase_boots_ti8.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.caster
            )
        );
    }
}

@registerModifier("modifier_item_butterfly_custom")
class ModifeirItemButterfly extends CustomModifier {
    OnCreated() {
        if (IsServer()) {
            this.OnIntervalThink();
            this.StartIntervalThink(this.Value("think_duration"));
        }
    }

    OnIntervalThink() {
        ModifierItemButterflyBanish.apply(this.caster, this.caster, this.ability, { duration: this.Value("banish_duration") });
        ModifierHideBar.apply(this.caster, this.caster, undefined, { duration: this.Value("banish_duration") });
        this.PlayEffectsOnBanish();
    }

    DeclareFunctions() {
        return [ModifierFunction.MOVESPEED_BONUS_PERCENTAGE, ModifierFunction.ATTACKSPEED_BONUS_CONSTANT];
    }

    GetModifierAttackSpeedBonus_Constant() {
        return this.Value("aspd");
    }

    GetModifierMoveSpeedBonus_Percentage() {
        return this.Value("ms_pct");
    }

    GetEffectName() {
        return "particles/items2_fx/butterfly_buff.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.ABSORIGIN_FOLLOW;
    }

    PlayEffectsOnBanish() {
        EmitSoundOn("DOTA_Item.Butterfly", this.caster);

        const particleId = ParticleManager.CreateParticle(
            "particles/butterfly_effect/pa_arcana_event_glitch.vpcf",
            ParticleAttachment.WORLDORIGIN,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 0, this.caster.GetOrigin());
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    // function modifier_item_butterfly_custom:GetStatusLabel() return "Flutter" }
    // function modifier_item_butterfly_custom:GetStatusPriority() return 4 }
    // function modifier_item_butterfly_custom:GetStatusStyle() return "Flutter" }
}
// if(IsClient()){ require("wrappers/modifiers") }
// Modifiers.Status(modifier_item_butterfly_custom)

@registerModifier("modifier_item_butterfly_custom_banish")
class ModifierItemButterflyBanish extends ModifierBanish {
    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            this.PlayEffectsOnDestroy();
        }
    }

    PlayEffectsOnDestroy() {
        EmitSoundOn("Hero_PhantomAssassin.Blur.Break", this.caster);

        const particleId = ParticleManager.CreateParticle(
            "particles/butterfly_effect/pa_arcana_event_glitch.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 0, this.caster.GetOrigin());
        ParticleManager.SetParticleControl(particleId, 3, this.caster.GetOrigin());

        ParticleManager.ReleaseParticleIndex(particleId);
    }

    CheckState() {
        return {
            ...super.CheckState(),
            [ModifierState.COMMAND_RESTRICTED]: true
        };
    }
}
