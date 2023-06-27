import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier("modifier_visible")
export class ModifierVisible extends CustomModifier<undefined> {
    IsHidden() {
        return true;
    }

    IsDebuff() {
        return false;
    }

    IsPurgable() {
        return false;
    }

    IsPermanent() {
        return false;
    }

    RemoveOnDeath() {
        return false;
    }
}
