import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier("modifier_generic_fading_slow")
export class ModifierFadingSlow extends CustomModifier<undefined> {
    maxSlowPct!: number;
    speedPerTick!: number;

    OnCreated(params: { maxSlowPct?: number }) {
        if (IsServer()) {
            this.maxSlowPct = params.maxSlowPct ?? 100;
            const tick = 1 / 8;
            const ticks_number = this.GetDuration() / tick;

            this.speedPerTick = this.maxSlowPct / ticks_number;

            this.SetStackCount(this.maxSlowPct);
            this.StartIntervalThink(tick);
        }
    }

    OnIntervalThink() {
        this.SetStackCount(Math.max(0, this.GetStackCount() - this.speedPerTick));
    }

    DeclareFunctions() {
        return [ModifierFunction.MOVESPEED_BONUS_PERCENTAGE];
    }

    GetModifierMoveSpeedBonus_Percentage() {
        return -this.GetStackCount();
    }

    GetEffectName() {
        return "particles/generic_gameplay/rune_haste.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.OVERHEAD_FOLLOW;
    }

    GetTexture() {
        return "modifier_fading_slow";
    }
}
