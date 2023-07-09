import { registerModifier } from "../../../lib/dota_ts_adapter";
import { findUnitsInRadius } from "../../../util";
import { ModifierCombatEvents } from "../../modifier_combat_events";
import { ModifierUpgrade } from "../modifier_upgrade";

@registerModifier("modifier_upgrade_item_maelstrom")
class ModifierItemMaelstrom extends ModifierUpgrade {
    damagePerStack = 10;
    procChancePct = 50;

    OnBasicAttackStarted() {
        if (RandomInt(1, 100) <= this.procChancePct) {
            ModifierItemMaelstromAttack.apply(this.parent, this.parent, undefined, {});
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.PREATTACK_BONUS_DAMAGE];
    }

    GetModifierPreAttack_BonusDamage() {
        return this.damagePerStack;
    }

    GetTexture() {
        return "item_maelstrom";
    }
}

@registerModifier("modifier_upgrade_item_maelstrom_attack")
class ModifierItemMaelstromAttack extends ModifierCombatEvents<undefined> {
    hitLog: CDOTA_BaseNPC[] = [];
    radius = 850;
    remainingProcs = 5;
    damage = 25;

    IsHidden() {
        return true;
    }

    OnBasicAttackEnded() {
        this.Destroy();
    }

    OnBasicAttackLanded(event: { target: CDOTA_BaseNPC }): void {
        if (IsServer() && event.target.IsAlive()) {
            EmitSoundOn("Item.Maelstrom.Chain_Lightning", event.target);

            this.ReleaseBolt(this.parent, event.target);
        }
    }

    ReleaseBolt(source: CDOTA_BaseNPC, target: CDOTA_BaseNPC) {
        this.hitLog.push(target);

        EFX("particles/econ/events/ti10/maelstrom_ti10.vpcf", ParticleAttachment.CUSTOMORIGIN, source, {
            cp0: {
                ent: source,
                point: AttachLocation.hitloc
            },
            cp1: {
                ent: target,
                point: AttachLocation.hitloc
            },
            release: true
        });

        ApplyDamage({
            victim: target,
            attacker: this.parent,
            damage: this.damage,
            damage_type: DamageTypes.MAGICAL
        });

        if (this.remainingProcs > 0) {
            const enemy = findUnitsInRadius(
                this.parent,
                target.GetAbsOrigin(),
                this.radius,
                UnitTargetTeam.ENEMY,
                UnitTargetType.HERO + UnitTargetType.BASIC,
                UnitTargetFlags.NONE,
                FindOrder.ANY
            ).find(enemy => !this.hitLog.some(hit => hit == enemy));

            if (enemy) {
                this.hitLog.push(enemy);
                this.remainingProcs--;
                EmitSoundOn("Item.Maelstrom.Chain_Lightning.Jump", enemy);
                this.ReleaseBolt(target, enemy);
            }
        }
    }
}
