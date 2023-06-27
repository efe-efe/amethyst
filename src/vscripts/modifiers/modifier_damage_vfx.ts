import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier("modifier_damage_fx")
export class ModifierDamageVFX extends CustomModifier<undefined> {
    IsHidden() {
        return true;
    }

    GetEffectAttachType() {
        return ParticleAttachment.ABSORIGIN_FOLLOW;
    }

    GetStatusEffectName() {
        return "particles/damage_received_test.vpcf";
    }
}
