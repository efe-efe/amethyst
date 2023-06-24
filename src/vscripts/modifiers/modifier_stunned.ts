import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier({ customNameForI18n: "modifier_generic_stunned" })
export class ModifierStun extends CustomModifier<undefined> {
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
}
