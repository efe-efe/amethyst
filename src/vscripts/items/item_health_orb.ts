import { CustomAbility } from "../abilities/framework/custom_ability";
import { registerAbility } from "../lib/dota_ts_adapter";

@registerAbility("item_health_orb")
class ItemHealthOrb extends CustomAbility {
    OnSpellStart() {
        const heal = 3;

        this.caster.Heal(heal, this);
        CustomEntitiesLegacy.TrueHeal(this.caster, heal);

        EmitSoundOn("DOTA_Item.FaerieSpark.Activate", this.caster);
    }
}
