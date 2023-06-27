import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier("modifier_generic_silence")
export class ModifierSilence extends CustomModifier {
    particleId?: ParticleID;

    IsDebuff() {
        return true;
    }

    IsStunDebuff() {
        return false;
    }

    IsPurgable() {
        return true;
    }

    OnCreated() {
        if (IsServer()) {
            this.PlayEffects();
        }
    }

    OnDestroy() {
        if (IsServer()) {
            this.StopEffects();
        }
    }

    PlayEffects() {
        this.particleId = ParticleManager.CreateParticleForPlayer(
            "particles/generic_gameplay/screen_silence_indicator.vpcf",
            ParticleAttachment.EYES_FOLLOW,
            this.parent,
            this.parent.GetPlayerOwner()
        );
    }

    StopEffects() {
        if (this.particleId) {
            ParticleManager.DestroyParticle(this.particleId, false);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }

    GetEffectName() {
        return "particles/generic_gameplay/generic_silenced.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.OVERHEAD_FOLLOW;
    }

    CheckState() {
        return {
            [ModifierState.SILENCED]: true
        };
    }
}
