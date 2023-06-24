import { registerModifier } from "../lib/dota_ts_adapter";
import { ModifierShield } from "./modifier_shield";

@registerModifier({ customNameForI18n: "modifier_generic_npc_shield" })
export class ModifierNPCShield extends ModifierShield {
    GetTexture() {
        return "modifier_shield";
    }
}
