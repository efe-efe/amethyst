import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier({ customNameForI18n: "modifier_hide_bar" })
export class ModifierHideBar extends CustomModifier<undefined> {
    IsHidden() {
        return true;
    }

    IsPurgable() {
        return false;
    }
}
