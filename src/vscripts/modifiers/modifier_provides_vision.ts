import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier({ customNameForI18n: "modifier_generic_provides_vision" })
export class ModifierProvidesVision extends CustomModifier<undefined> {
    IsDebuff() {
        return false;
    }

    IsHidden() {
        return true;
    }

    IsPurgable() {
        return false;
    }

    OnCreated() {
        if (IsServer()) {
            this.StartIntervalThink(0.05);
        }
    }

    OnIntervalThink() {
        AddFOWViewer(this.caster.GetTeamNumber(), this.parent.GetAbsOrigin(), this.parent.GetCurrentVisionRange(), 0.05, true);
    }
}
