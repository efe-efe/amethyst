import { registerModifier } from "../../lib/dota_ts_adapter";
import { ModifierCombatEvents } from "../modifier_combat_events";

@registerModifier({ customNameForI18n: "modifier_ruby" })
export class ModifierRuby extends ModifierCombatEvents {
    damage!: number;
    particleId!: ParticleID;

    IsHidden() {
        return false;
    }

    OnCreated(params: { damage: number }) {
        if (IsServer()) {
            this.damage = params.damage;
            this.particleId = ParticleManager.CreateParticle(
                "particles/generic_gameplay/rune_haste_owner.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent
            );
        }
    }

    OnDestroy() {
        if (IsServer()) {
            ParticleManager.DestroyParticle(this.particleId, false);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }

    OnBasicAttackStarted() {
        ModifierRubyAttack.apply(this.parent, this.parent, undefined, { damage: this.damage });
        EFX("particles/gems/ruby_rings.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.parent, {
            cp1: this.parent.GetAbsOrigin(),
            release: true
        });
    }

    GetTexture() {
        return "modifier_ruby";
    }

    // function modifier_ruby:GetStatusLabel() return "Ruby" end
    // function modifier_ruby:GetStatusPriority() return 2 end
    // function modifier_ruby:GetStatusStyle() return "Ruby" end
}
// Modifiers.Status(modifier_ruby)

@registerModifier({ customNameForI18n: "modifier_ruby_attack" })
export class ModifierRubyAttack extends ModifierCombatEvents<undefined> {
    damage!: number;

    OnCreated(params: { damage: number }) {
        if (IsServer()) {
            this.damage = params.damage;
        }
    }

    OnBasicAttackEnded() {
        if (IsServer()) {
            this.Destroy();
        }
    }

    OnBasicAttackLanded(event: { target: CDOTA_BaseNPC }): void {
        if (IsServer()) {
            ApplyDamage({
                victim: event.target,
                attacker: this.parent,
                damage: this.damage,
                damage_type: DamageTypes.PURE
            });

            EmitSoundOn("Hero_DoomBringer.LvlDeath", event.target);
            EFX("particles/gems/ruby.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
                cp0: event.target.GetAbsOrigin(),
                cp1: event.target.GetAbsOrigin(),
                release: true
            });
        }
    }
}
