import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier("modifier_generic_fear")
export class ModifierFear extends CustomModifier<undefined> {}

// if IsClient() then require("wrappers/modifiers") end
// Modifiers.Fear(modifier_generic_fear)
