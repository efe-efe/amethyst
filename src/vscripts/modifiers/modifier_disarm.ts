import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier()
export class ModifierDisarm extends CustomModifier<undefined> {
    IsHidden() {
        return true;
    }

    IsDebuff() {
        return false;
    }

    IsPurgable() {
        return false;
    }

    RemoveOnDeath() {
        return false;
    }

    DeclareFunctions() {
        return [ModifierFunction.DISABLE_AUTOATTACK];
    }

    CheckState(): Partial<Record<ModifierState, boolean>> {
        return {
            [ModifierState.DISARMED]: true
        };
    }

    GetDisableAutoAttack(): 0 | 1 {
        return 1;
    }
}
