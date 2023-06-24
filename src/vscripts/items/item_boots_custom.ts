import { CustomAbility } from "../abilities/framework/custom_ability";
import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerAbility, registerModifier } from "../lib/dota_ts_adapter";

@registerAbility("item_boots_custom")
class ItemBoots extends CustomAbility {
    GetIntrinsicModifierName() {
        return ModifierItemBoots.name;
    }
}

@registerModifier({ customNameForI18n: "modifier_item_boots_custom" })
class ModifierItemBoots extends CustomModifier {
    DeclareFunctions() {
        return [ModifierFunction.MOVESPEED_BONUS_PERCENTAGE];
    }

    GetModifierAttackSpeedBonus_Constant() {
        return this.Value("ms_pct");
    }
}
