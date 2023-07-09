import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier()
export class ModifierNoHealthbar extends CustomModifier<undefined> {
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

    CheckState() {
        return {
            [ModifierState.NO_HEALTH_BAR]: true
        };
    }
}
