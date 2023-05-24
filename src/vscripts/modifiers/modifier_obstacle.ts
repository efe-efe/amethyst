import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier()
export class ModifierObstacle extends CustomModifier<undefined> {
    IsHidden() {
        return true;
    }

    IsPermanent() {
        return true;
    }
}
