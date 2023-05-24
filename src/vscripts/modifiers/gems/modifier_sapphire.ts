import { CustomModifier } from "../../abilities/framework/custom_modifier";
import { registerModifier } from "../../lib/dota_ts_adapter";

@registerModifier({ customNameForI18n: "modifier_sapphire" })
class ModifierSapphire extends CustomModifier {
    particleId!: ParticleID;

    OnCreated() {
        if (IsServer()) {
            this.particleId = ParticleManager.CreateParticle(
                "particles/generic_gameplay/rune_doubledamage_owner.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent
            );
        }
    }

    OnDestroy() {
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

    GetStatusLabel() {
        return "Sapphire";
    }
    GetStatusPriority() {
        return 2;
    }
    GetStatusStyle() {
        return "Sapphire";
    }
}

// Modifiers.Status(modifier_sapphire)
// Modifiers.Shield(modifier_sapphire)
