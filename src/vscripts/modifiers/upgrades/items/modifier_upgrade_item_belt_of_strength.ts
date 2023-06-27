import { registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierUpgrade } from "../modifier_upgrade";

@registerModifier("modifier_upgrade_item_belt_of_strength")
class ModifierItemBeltOfStrength extends ModifierUpgrade {
    extraHealth = 50;

    DeclareFunctions() {
        return [ModifierFunction.HEALTH_BONUS];
    }

    GetModifierHealthBonus() {
        return this.GetStackCount() * this.extraHealth;
    }

    GetTexture() {
        return "item_belt_of_strength";
    }
}
