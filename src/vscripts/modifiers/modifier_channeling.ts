import { CustomAbility, CustomItem } from "../abilities/framework/custom_ability";
import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier()
export class ModifierChanneling<A extends CDOTABaseAbility | undefined = CustomAbility | CustomItem> extends CustomModifier<A> {}
