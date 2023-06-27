import { registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierUpgrade } from "../modifier_upgrade";

@registerModifier("modifier_upgrade_item_blade_of_alacrity")
class ModifierItemBladeOfAlacrity extends ModifierUpgrade {
    speedBuffPct = 15;
    asSpeed = 50;

    OnRefresh() {
        if (IsServer()) {
            this.IncrementStackCount();
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.MOVESPEED_BONUS_PERCENTAGE, ModifierFunction.ATTACKSPEED_BONUS_CONSTANT];
    }

    GetModifierAttackSpeedBonus_Constant() {
        return this.asSpeed;
    }

    GetModifierMoveSpeedBonus_Percentage() {
        return this.speedBuffPct;
    }

    GetTexture() {
        return "item_blade_of_alacrity";
    }
}
