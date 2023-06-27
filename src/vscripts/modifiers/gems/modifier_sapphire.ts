import { registerModifier } from "../../lib/dota_ts_adapter";
import { ModifierShield } from "../modifier_shield";

@registerModifier("modifier_sapphire")
export class ModifierSapphire extends ModifierShield {
    particleId!: ParticleID;

    OnCreated(params: { damageBlock: number }) {
        super.OnCreated(params);

        if (IsServer()) {
            this.particleId = ParticleManager.CreateParticle(
                "particles/generic_gameplay/rune_doubledamage_owner.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent
            );
        }
    }

    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            ParticleManager.DestroyParticle(this.particleId, false);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }

    GetTexture() {
        return "modifier_sapphire";
    }

    DeclareFunctions() {
        return [ModifierFunction.TOOLTIP];
    }

    OnTooltip() {
        return this.GetStackCount();
    }

    // GetStatusLabel() {
    //     return "Sapphire";
    // }
    // GetStatusPriority() {
    //     return 2;
    // }
    // GetStatusStyle() {
    //     return "Sapphire";
    // }
}

// Modifiers.Status(modifier_sapphire)
// Modifiers.Shield(modifier_sapphire)
