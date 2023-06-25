import { registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierUpgrade } from "../modifier_upgrade";

@registerModifier({ customNameForI18n: "modifier_upgrade_phantom_strike_knives" })
export class ModifierUpgradePhantomStrikeKnives extends ModifierUpgrade {
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
}
