import { CustomModifier } from "../../../abilities/framework/custom_modifier";
import { registerModifier } from "../../../lib/dota_ts_adapter";

@registerModifier("modifier_upgrade_item_mithril_hammer")
class ModifierItemMithrilHammer extends CustomModifier {
    damagePerStack = 4;

    DeclareFunctions() {
        return [ModifierFunction.PREATTACK_BONUS_DAMAGE];
    }

    GetModifierPreAttack_BonusDamage() {
        return this.damagePerStack;
    }

    GetTexture() {
        return "item_mithril_hammer";
    }
}
