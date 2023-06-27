import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier("modifier_generic_sleep")
export class ModifierSleep extends CustomModifier<undefined> {
    IsDebuff() {
        return true;
    }
    IsStunDebuff() {
        return true;
    }

    CheckState() {
        return {
            [ModifierState.STUNNED]: true,
            [ModifierState.NIGHTMARED]: true,
            [ModifierState.COMMAND_RESTRICTED]: true
        };
    }

    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.ON_TAKEDAMAGE];
    }

    OnTakeDamage(event: ModifierInstanceEvent) {
        if (IsServer() && event.unit == this.parent) {
            this.Destroy();
        }
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_DISABLED;
    }

    GetEffectName() {
        return "particles/generic_gameplay/generic_sleep.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.OVERHEAD_FOLLOW;
    }

    GetTexture() {
        return "modifier_generic_sleep";
    }

    // function modifier_generic_sleep:GetStatusLabel() return "Sleep" }
    // function modifier_generic_sleep:GetStatusPriority() return 4 }
    // function modifier_generic_sleep:GetStatusStyle() return "Sleep" }
}
// if IsClient() then require("wrappers/modifiers") }
// Modifiers.Status(modifier_generic_sleep)
