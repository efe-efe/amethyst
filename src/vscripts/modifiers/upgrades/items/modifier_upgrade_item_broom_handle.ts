import { registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierUpgrade } from "../modifier_upgrade";

@registerModifier({ customNameForI18n: "modifier_upgrade_item_broom_handle" })
class ModifierItemBroomHandle extends ModifierUpgrade {
    GetExtraRadius() {
        return 95;
    }

    GetTexture() {
        return "item_broom_handle";
    }
}
