import { registerAbility, registerModifier } from "../../../../lib/dota_ts_adapter";
import { CustomAbility } from "../../../framework/custom_ability";
import { CustomModifier } from "../../../framework/custom_modifier";

@registerAbility("invoker_alacrity_custom")
class InvokerAlacrity extends CustomAbility {
    OnSpellStart() {
        ModifierInvokerAlacrity.apply(this.caster, this.caster, this, { duration: this.GetSpecialValueFor("duration") });
        EmitSoundOn("Hero_Invoker.Alacrity", this.caster);
    }
}

@registerModifier({ customNameForI18n: "modifier_invoker_alacrity_custom" })
class ModifierInvokerAlacrity extends CustomModifier {
    OnCreated() {
        if (IsServer()) {
            this.PlayEffects();
        }
    }

    PlayEffects() {
        const particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_invoker/invoker_alacrity.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.parent
        );
        this.AddParticle(particleId, false, false, -1, false, false);
        EmitSoundOn("Hero_Invoker.Alacrity", this.parent);
    }

    DeclareFunctions() {
        return [ModifierFunction.ATTACKSPEED_BONUS_CONSTANT, ModifierFunction.PREATTACK_BONUS_DAMAGE];
    }

    GetModifierAttackSpeedBonus_Constant() {
        return this.Value("attackSpeed");
    }

    GetModifierPreAttack_BonusDamage() {
        return this.Value("extra_damage");
    }

    GetEffectName() {
        return "particles/units/heroes/hero_invoker/invoker_alacrity_buff.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.OVERHEAD_FOLLOW;
    }

    // function modifier_invoker_alacrity_custom:GetStatusLabel() return "Alacrity" }
    // function modifier_invoker_alacrity_custom:GetStatusPriority() return 1 }
    // function modifier_invoker_alacrity_custom:GetStatusStyle() return "Alacrity" }
}
// if(IsClient() ) { require("wrappers/modifiers") }
// Modifiers.Status(modifier_invoker_alacrity_custom)
