import { registerModifier } from "../../../lib/dota_ts_adapter";
import { direction2D } from "../../../util";
import { ModifierCombatEvents } from "../../modifier_combat_events";
import { ModifierStun } from "../../modifier_stunned";
import { ModifierUpgrade } from "../modifier_upgrade";

@registerModifier("modifier_upgrade_item_basher")
class ModifierItemBasher extends ModifierUpgrade {
    damagePerStack = 10;
    extraHealth = 100;
    procChancePct = 25;

    DeclareFunctions() {
        return [ModifierFunction.HEALTH_BONUS, ModifierFunction.PREATTACK_BONUS_DAMAGE];
    }

    GetModifierPreAttack_BonusDamage() {
        return this.damagePerStack;
    }

    GetModifierHealthBonus() {
        return this.extraHealth;
    }

    OnBasicAttackStarted() {
        if (RandomInt(1, 100) <= this.procChancePct) {
            ModifierItemBasherAttack.apply(this.parent, this.parent, undefined, {});
        }
    }
}

@registerModifier("modifier_upgrade_item_basher_attack")
class ModifierItemBasherAttack extends ModifierCombatEvents<undefined> {
    stunDuration = 1.0;
    damage = 10;

    IsHidden() {
        return true;
    }

    OnBasicAttackEnded() {
        this.Destroy();
    }

    OnBasicAttackLanded(event: { target: CDOTA_BaseNPC }): void {
        if (IsServer() && event.target.IsAlive()) {
            this.Stun(this.GetParent(), event.target);
        }
    }

    Stun(source: CDOTA_BaseNPC, target: CDOTA_BaseNPC) {
        const direction = direction2D(source.GetAbsOrigin(), target.GetAbsOrigin());
        EFX("particles/units/heroes/hero_spirit_breaker/spirit_breaker_greater_bash.vpcf", ParticleAttachment.CUSTOMORIGIN, target, {
            cp0: {
                ent: target,
                point: AttachLocation.hitloc
            },
            cp0f: direction,
            release: true
        });

        ApplyDamage({
            victim: target,
            attacker: this.parent,
            damage: this.damage,
            damage_type: DamageTypes.MAGICAL
        });

        ModifierStun.apply(target, source, undefined, { duration: this.stunDuration });
        EmitSoundOn("DOTA_Item.SkullBasher", target);
    }

    GetTexture() {
        return "item_basher";
    }
}
