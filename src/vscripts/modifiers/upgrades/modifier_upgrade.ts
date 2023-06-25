import { CustomAbility } from "../../abilities/framework/custom_ability";
import { registerModifier } from "../../lib/dota_ts_adapter";
import { ModifierCombatEvents } from "../modifier_combat_events";

@registerModifier()
export class ModifierUpgrade<A extends CDOTABaseAbility | undefined = CustomAbility> extends ModifierCombatEvents<A> {
    RemoveOnDeath() {
        return false;
    }

    IsPurgable() {
        return false;
    }
}
