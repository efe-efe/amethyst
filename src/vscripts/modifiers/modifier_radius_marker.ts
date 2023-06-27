import { registerModifier } from "../lib/dota_ts_adapter";
import { ModifierThinker } from "./modifier_thinker";

@registerModifier("modifier_radius_marker")
export class ModifierRadiusMarker extends ModifierThinker<undefined> {}
