import { registerModifier } from "../lib/dota_ts_adapter";
import { ModifierCombatEvents, OnHitEvent } from "./modifier_combat_events";
import { ModifierNPCShield } from "./modifier_npc_shield";
import { ModifierStun } from "./modifier_stunned";

@registerModifier("modifier_mini_stun")
export class ModifierMiniStun extends ModifierCombatEvents<undefined> {
    OnHit(event: OnHitEvent) {
        if (IsServer() && event.triggerCounters) {
            if (!ModifierNPCShield.findOne(this.parent)) {
                ModifierStun.apply(this.parent, event.source, undefined, {
                    duration: event.attackCategory == "projectile" ? 0.15 : 0.25
                });
            }
        }

        return true;
    }
}
