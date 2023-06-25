import { CustomItem } from "../abilities/framework/custom_ability";
import { registerAbility } from "../lib/dota_ts_adapter";

@registerAbility("item_health_orb")
class ItemHealthOrb extends CustomItem {
    OnSpellStart() {
        const heal = 3;

        this.GetCaster().Heal(heal, this);
        CustomEntitiesLegacy.TrueHeal(this.GetCaster(), heal);

        EmitSoundOn("DOTA_Item.FaerieSpark.Activate", this.GetCaster());
    }
}
