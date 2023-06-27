import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier("modifier_generic_root")
export class ModifierRoot extends CustomModifier {
    IsDebuff() {
        return true;
    }

    IsStunDebuff() {
        return true;
    }

    CheckState() {
        return {
            [ModifierState.ROOTED]: true
        };
    }

    GetEffectName() {
        return "particles/econ/items/oracle/oracle_fortune_ti7/oracle_fortune_ti7_purge_root_pnt.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.ABSORIGIN_FOLLOW;
    }
}
