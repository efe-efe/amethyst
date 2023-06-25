import { CustomItem } from "../abilities/framework/custom_ability";
import { registerAbility } from "../lib/dota_ts_adapter";
import { giveManaAndEnergy } from "../util";

@registerAbility("item_mana_orb")
class ItemManaOrb extends CustomItem {
    OnSpellStart() {
        const mana = 8;
        giveManaAndEnergy(this.GetCaster(), mana, true, true);

        EmitSoundOn("DOTA_Item.ClarityPotion.Activate", this.GetCaster());
        this.SpendCharge();
    }
}
