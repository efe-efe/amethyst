import { registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierUpgrade } from "../modifier_upgrade";

@registerModifier({ customNameForI18n: "modifier_upgrade_phantom_dash_shield" })
export class ModifierUpgradePhantomDashShield extends ModifierUpgrade {
    rangeBonus = 25;
    damageBlock = 10;

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

    GetDamageBlock() {
        if (IsServer()) {
            return this.GetStackCount() * this.damageBlock;
        }

        return 0;
    }

    DeclareFunctions() {
        return [ModifierFunction.CAST_RANGE_BONUS_STACKING];
    }

    GetModifierCastRangeBonusStacking() {
        return this.GetStackCount() * this.rangeBonus;
    }
}
