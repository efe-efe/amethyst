import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier({ customNameForI18n: "modifier_generic_stunned" })
export class ModifierStun extends CustomModifier {
    OnCreated() {
        if (IsServer()) {
            this.parent.Stop();
        }
    }

    IsDebuff() {
        return true;
    }

    IsStunDebuff() {
        return true;
    }

    CheckState() {
        return {
            [ModifierState.COMMAND_RESTRICTED]: true,
            [ModifierState.STUNNED]: true
        };
    }

    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_DISABLED;
    }

    GetEffectName() {
        return "particles/generic_gameplay/generic_stunned.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.OVERHEAD_FOLLOW;
    }

    // function modifier_generic_stunned:GetStatusLabel() return "Stun" }
    // function modifier_generic_stunned:GetStatusPriority() return 4 }
    // function modifier_generic_stunned:GetStatusStyle() return "Stun" }
}
// if IsClient() then require("wrappers/modifiers") }
// Modifiers.Status(modifier_generic_stunned)
// Modifiers.Animation(modifier_generic_stunned)
