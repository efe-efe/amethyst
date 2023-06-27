import { registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierUpgrade } from "../modifier_upgrade";

@registerModifier("modifier_upgrade_item_yasha")
class ModifierItemYasha extends ModifierUpgrade {
    speedBuffPct = 30;
    asSpeed = 80;
    damage = 3;

    OnRefresh() {
        if (IsServer()) {
            this.IncrementStackCount();
        }
    }

    DeclareFunctions() {
        return [
            ModifierFunction.MOVESPEED_BONUS_PERCENTAGE,
            ModifierFunction.ATTACKSPEED_BONUS_CONSTANT,
            ModifierFunction.PREATTACK_BONUS_DAMAGE
        ];
    }

    GetModifierAttackSpeedBonus_Constant() {
        return this.asSpeed;
    }

    GetModifierMoveSpeedBonus_Percentage() {
        return this.speedBuffPct;
    }

    GetModifierPreAttack_BonusDamage() {
        return this.damage;
    }

    GetTexture() {
        return "item_yasha";
    }
}
