import { CustomAbility } from "../abilities/framework/custom_ability";
import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerAbility, registerModifier } from "../lib/dota_ts_adapter";
import { clampPosition, direction2D, getCursorPosition, meeleEFX } from "../util";

@registerAbility("item_diffusal_custom")
class ItemDiffusal extends CustomAbility {
    GetCastingCrawl() {
        return 30;
    }

    GetAnimation() {
        return GameActivity.DOTA_ATTACK;
    }

    OnSpellStart() {
        const cursor = getCursorPosition(this.caster);
        const origin = this.caster.GetOrigin();
        const castRange = this.GetCastRange(Vector(0, 0, 0), undefined);
        const point = clampPosition(origin, cursor, {
            maxRange: castRange
        });
        const radius = this.GetSpecialValueFor("radius");
        const direction = direction2D(origin, point);
        const damage = this.GetSpecialValueFor("ability_damage");
        const duration = this.GetSpecialValueFor("duration");

        meeleEFX(this.caster, direction, radius, Vector(255, 255, 0));

        this.MeeleAttack({
            direction,
            origin,
            radius,
            effect: (target: CDOTA_BaseNPC) => {
                ModifierItemDiffusal.apply(target, this.caster, this, { duration: duration });
                ApplyDamage({
                    victim: target,
                    attacker: this.caster,
                    damage: damage,
                    damage_type: DamageTypes.PHYSICAL
                });

                this.PlayEffectsOnImpact(target);
            },
            baseSound: "DOTA_Item.DiffusalBlade.Activate"
        });

        EmitSoundOnLocationWithCaster(point, "Hero_Juggernaut.PreAttack", this.caster);
        this.PlayEffectsOnFinish(point);
    }

    PlayEffectsOnFinish(position: Vector) {
        const offset = 40;
        const origin = this.caster.GetAbsOrigin();
        const direction = direction2D(origin, position);
        const finalPosition = origin.__add(Vector(direction.x * offset, direction.y * offset, 0));

        let particleId = ParticleManager.CreateParticle(
            "particles/meele_swing_red/pa_arcana_attack_blinkb_red.vpcf",
            ParticleAttachment.POINT,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 0, finalPosition);
        ParticleManager.SetParticleControlForward(particleId, 0, direction);
        ParticleManager.ReleaseParticleIndex(particleId);

        particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_spirit_breaker/spirit_breaker_greater_bash.vpcf",
            ParticleAttachment.POINT,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 0, finalPosition);
        ParticleManager.SetParticleControlForward(particleId, 0, direction);
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsOnImpact(target: CDOTA_BaseNPC) {
        const particleId = ParticleManager.CreateParticle(
            "particles/econ/items/arc_warden/arc_warden_ti9_immortal/arc_warden_ti9_wraith_cast.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            target
        );
        ParticleManager.SetParticleControl(particleId, 1, target.GetAbsOrigin());
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerModifier("modifier_item_diffusal_custom")
class ModifierItemDiffusal extends CustomModifier {
    OnCreated() {
        EmitSoundOn("DOTA_Item.DiffusalBlade.Target", this.parent);
    }

    OnDestroy() {
        StopSoundOn("DOTA_Item.DiffusalBlade.Target", this.parent);
    }

    DeclareFunctions() {
        return [ModifierFunction.MOVESPEED_BONUS_PERCENTAGE, ModifierFunction.INCOMING_DAMAGE_PERCENTAGE];
    }

    GetModifierIncomingDamage_Percentage() {
        if (IsServer()) {
            this.parent.Script_ReduceMana(this.Value("mana_per_tick"), this.ability);
            this.PlayEffectsOnImpact(this.parent);
        }

        return 0;
    }

    GetModifierAttackSpeedBonus_Constant() {
        return -this.Value("ms_pct");
    }

    CheckState() {
        return {
            [ModifierState.NO_UNIT_COLLISION]: true
        };
    }

    PlayEffectsOnImpact(target: CDOTA_BaseNPC) {
        EmitSoundOn("DOTA_Item.DiffusalBlade.Target", target);
        ParticleManager.ReleaseParticleIndex(
            ParticleManager.CreateParticle("particles/generic_gameplay/generic_manaburn.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, target)
        );
    }

    GetEffectName() {
        return "particles/items_fx/diffusal_slow.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.ABSORIGIN_FOLLOW;
    }

    // function modifier_item_diffusal_custom:GetStatusLabel() return "Inhibit" }
    // function modifier_item_diffusal_custom:GetStatusPriority() return 4 }
    // function modifier_item_diffusal_custom:GetStatusStyle() return "Inhibit" }
}
// if(IsClient()){ require("wrappers/modifiers") }
// Modifiers.Status(modifier_item_diffusal_custom)
