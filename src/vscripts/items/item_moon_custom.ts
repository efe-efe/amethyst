import { CustomAbility } from "../abilities/framework/custom_ability";
import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerAbility, registerModifier } from "../lib/dota_ts_adapter";

@registerAbility("item_moon_custom")
class ItemMoonshard extends CustomAbility {
    GetIntrinsicModifierName() {
        return ModifierItemMoonshard.name;
    }
}

@registerModifier("modifier_item_moon_custom")
class ModifierItemMoonshard extends CustomModifier {
    DeclareFunctions() {
        return [ModifierFunction.ATTACKSPEED_BONUS_CONSTANT];
    }

    GetModifierAttackSpeedBonus_Constant() {
        return this.Value("aspd");
    }

    GetEffectName() {
        return "particles/units/heroes/hero_troll_warlord/troll_warlord_battletrance_buff.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.ABSORIGIN_FOLLOW;
    }

    GetStatusEffectName() {
        return "particles/status_fx/status_effect_troll_warlord_battletrance.vpcf";
    }
}
