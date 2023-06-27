import { registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierUpgrade } from "../modifier_upgrade";

@registerModifier("modifier_upgrade_item_boots_of_elves")
class ModifierItemBootsOfElves extends ModifierUpgrade {
    damage = 1;
    asSpeed = 25;

    DeclareFunctions() {
        return [ModifierFunction.PREATTACK_BONUS_DAMAGE, ModifierFunction.ATTACKSPEED_BONUS_CONSTANT];
    }

    GetModifierPreAttack_BonusDamage() {
        return this.damage;
    }

    GetModifierAttackSpeedBonus_Constant() {
        return this.asSpeed;
    }

    GetTexture() {
        return "item_boots_of_elves";
    }
}
