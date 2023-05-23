import { BaseModifier, registerModifier } from "../../lib/dota_ts_adapter";

@registerModifier()
export class modifier_generic_disarm extends BaseModifier {
    IsHidden(): boolean {
        return true;
    }
    IsDebuff(): boolean {
        return false;
    }
    IsPurgable(): boolean {
        return false;
    }
    RemoveOnDeath(): boolean {
        return false;
    }

    DeclareFunctions(): ModifierFunction[] {
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
