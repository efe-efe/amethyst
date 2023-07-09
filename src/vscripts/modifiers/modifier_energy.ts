import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier()
export class ModifierEnergy extends CustomModifier<undefined> {
    IsHidden() {
        return true;
    }

    IsPermanent() {
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

    DeclareFunctions(): ModifierFunction[] {
        return [ModifierFunction.ON_ABILITY_FULLY_CAST];
    }
}
