import { CustomModifier } from "../../abilities/framework/custom_modifier";
import { registerModifier } from "../../lib/dota_ts_adapter";

@registerModifier("modifier_amethyst")
export class ModifierAmethyst extends CustomModifier {
    particleId!: ParticleID;

    OnCreated(params: { mana: number }) {
        if (IsServer()) {
            this.SetStackCount(params.mana);
            this.particleId = ParticleManager.CreateParticle(
                "particles/generic_gameplay/rune_arcane_owner.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.GetParent()
            );
            // CustomEntitiesLegacy:SendDataToClient(this.GetParent())
        }
    }

    OnRefresh(params: { mana: number }) {
        if (IsServer()) {
            this.SetStackCount(this.GetStackCount() + params.mana);
            // CustomEntitiesLegacy:SendDataToClient(this.GetParent())
        }
    }

    OnDestroy() {
        if (IsServer()) {
            ParticleManager.DestroyParticle(this.particleId, false);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.EXTRA_MANA_BONUS];
    }

    GetModifierExtraManaBonus() {
        return this.GetStackCount();
    }
}
