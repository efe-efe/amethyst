import { registerModifier } from "../lib/dota_ts_adapter";
import { CustomModifier } from "../abilities/framework/custom_modifier";

@registerModifier()
export class ModifierUnlimitedSpeed extends CustomModifier<undefined> {
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
        return [ModifierFunction.IGNORE_MOVESPEED_LIMIT];
    }

    GetModifierIgnoreMovespeedLimit(): 0 | 1 {
        return 1;
    }
}
