import { CustomItem } from "../abilities/framework/custom_ability";
import { registerAbility } from "../lib/dota_ts_adapter";
import { giveManaAndEnergy } from "../util";

@registerAbility("item_mango_custom")
class ItemMango extends CustomItem {
    OnSpellStart() {
        giveManaAndEnergy(this.GetCaster(), this.GetSpecialValueFor("mana"), true);
        this.PlayEffects();
        this.SpendCharge();
    }

    PlayEffects() {
        EmitSoundOn("DOTA_Item.Mango.Activate", this.GetCaster());

        const particle_cast = "particles/items3_fx/mango_active.vpcf";
        const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN_FOLLOW, this.GetCaster());
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}
