import { registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierUpgrade } from "../modifier_upgrade";

@registerModifier({ customNameForI18n: "modifier_upgrade_phantom_dash_damage" })
export class ModifierUpgradePhantomDashDamage extends ModifierUpgrade {
    rangeBonus = 25;
    damage = 5;

    OnCreated() {
        if (IsServer()) {
            this.SetStackCount(1);
        }
    }

    OnRefresh() {
        if (IsServer()) {
            this.IncrementStackCount();
        }
    }

    GetDamage() {
        if (IsServer()) {
            return this.GetStackCount() * this.damage;
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.CAST_RANGE_BONUS_STACKING];
    }

    GetModifierCastRangeBonusStacking() {
        return this.GetStackCount() * this.rangeBonus;
    }
}
