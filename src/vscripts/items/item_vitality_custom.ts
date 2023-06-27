import { CustomAbility } from "../abilities/framework/custom_ability";
import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerAbility, registerModifier } from "../lib/dota_ts_adapter";

@registerAbility("item_vitality_custom")
class ItemVitalityBooster extends CustomAbility {
    GetIntrinsicModifierName() {
        return ModifierItemVitalityBooster.name;
    }
}

@registerModifier("modifier_item_vitality_custom")
class ModifierItemVitalityBooster extends CustomModifier {
    DeclareFunctions() {
        return [ModifierFunction.EXTRA_HEALTH_BONUS];
    }

    GetModifierExtraHealthBonus() {
        return this.Value("extra_health");
    }

    GetEffectName() {
        return "particles/vitality_effect/omniknight_repel_buff_ti8_glyph.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.ABSORIGIN_FOLLOW;
    }
}
