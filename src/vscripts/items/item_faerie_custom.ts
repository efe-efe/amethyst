import { CustomItem } from "../abilities/framework/custom_ability";
import { registerAbility } from "../lib/dota_ts_adapter";

@registerAbility("item_faerie_custom")
class ItemFaerie extends CustomItem {
    OnSpellStart() {
        this.caster.Heal(this.GetSpecialValueFor("heal"), this);
        this.PlayEffects();
        this.SpendCharge();
    }

    PlayEffects() {
        EmitSoundOn("DOTA_Item.FaerieSpark.Activate", this.caster);

        const particle_cast = "particles/items3_fx/fish_bones_active.vpcf";
        const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN_FOLLOW, this.caster);
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}
