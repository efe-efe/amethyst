import { CustomItem } from "../abilities/framework/custom_ability";
import { registerAbility } from "../lib/dota_ts_adapter";

@registerAbility("item_faerie_custom")
class ItemFaerie extends CustomItem {
    OnSpellStart() {
        this.GetCaster().Heal(this.GetSpecialValueFor("heal"), this);
        this.PlayEffects();
        this.SpendCharge();
    }

    PlayEffects() {
        EmitSoundOn("DOTA_Item.FaerieSpark.Activate", this.GetCaster());

        ParticleManager.ReleaseParticleIndex(
            ParticleManager.CreateParticle(
                "particles/items3_fx/fish_bones_active.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.GetCaster()
            )
        );
    }
}
