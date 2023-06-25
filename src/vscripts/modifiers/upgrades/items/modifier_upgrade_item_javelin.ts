import { registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierCombatEvents } from "../../modifier_combat_events";
import { ModifierUpgrade } from "../modifier_upgrade";

@registerModifier({ customNameForI18n: "modifier_upgrade_item_javelin" })
class ModifierItemJavelin extends ModifierUpgrade {
    procChancePct = 25;

    OnBasicAttackStarted() {
        if (RandomInt(1, 100) <= this.procChancePct) {
            ModifierItemJavelinAttack.apply(this.parent, this.parent, undefined, {});
        }
    }
}

@registerModifier({ customNameForI18n: "modifier_upgrade_item_javelin_attack" })
class ModifierItemJavelinAttack extends ModifierCombatEvents<undefined> {
    IsHidden() {
        return true;
    }

    OnBasicAttackEnded() {
        this.Destroy();
    }

    OnBasicAttackLanded(event: { target: CDOTA_BaseNPC }): void {
        if (IsServer() && event.target.IsAlive()) {
            ApplyDamage({
                victim: event.target,
                attacker: this.parent,
                damage: 10,
                damage_type: DamageTypes.MAGICAL
            });
            EmitSoundOn("DOTA_Item.Javelin", event.target);
        }
    }

    GetTexture() {
        return "item_javelin";
    }
}
