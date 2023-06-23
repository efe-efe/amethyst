import { registerModifier } from "../../../lib/dota_ts_adapter";
import { CustomModifier } from "../../framework/custom_modifier";

@registerModifier({ customNameForI18n: "modifier_pango_roll_end_animation" })
export class ModifierPangoRollEndAnimation extends CustomModifier {
    IsHidden() {
        return true;
    }

    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_4_END;
    }

    GetOverrideAnimationRate() {
        return 1.5;
    }
}
