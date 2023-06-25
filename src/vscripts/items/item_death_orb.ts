import { CustomItem } from "../abilities/framework/custom_ability";
import { registerAbility } from "../lib/dota_ts_adapter";
import { giveManaAndEnergy } from "../util";

@registerAbility("item_death_orb")
class ItemDeathOrb extends CustomItem {
    OnSpellStart() {
        const charges = this.GetCurrentCharges();
        const heal = 24;

        giveManaAndEnergy(this.GetCaster(), charges, true, true);

        if (charges == 100) {
            CustomEntitiesLegacy.TrueHeal(this.GetCaster(), heal);
        }
    }
}
