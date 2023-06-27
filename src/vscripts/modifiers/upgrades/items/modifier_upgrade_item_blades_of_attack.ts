import { registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierUpgrade } from "../modifier_upgrade";

@registerModifier("modifier_upgrade_item_blades_of_attack")
class ModifierItemBladesOfAttack extends ModifierUpgrade {
    damagePerStack = 2;

    DeclareFunctions() {
        return [ModifierFunction.PREATTACK_BONUS_DAMAGE];
    }

    GetModifierPreAttack_BonusDamage() {
        return this.damagePerStack;
    }

    GetTexture() {
        return "item_blades_of_attack";
    }
}
