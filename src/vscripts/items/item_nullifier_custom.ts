import { CustomAbility } from "../abilities/framework/custom_ability";
import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerAbility, registerModifier } from "../lib/dota_ts_adapter";
import { direction2D, getCursorPosition } from "../util";

@registerAbility("item_nullifier_custom")
class ItemNullifier extends CustomAbility {
    GetCastingCrawl() {
        return 90;
    }

    GetAnimation() {
        return GameActivity.DOTA_ATTACK;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = getCursorPosition(this.caster);
        const projectileDirection = direction2D(origin, point);
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const initialDuration = this.GetSpecialValueFor("initial_duration");
        const duration = this.GetSpecialValueFor("duration");
        const abilityDamage = this.GetSpecialValueFor("ability_damage");

        this.ProjectileAttack({
            source: this.caster,
            effectName: "particles/nullifier/nullifier_proj.vpcf",
            spawnOrigin: origin.__add(Vector(0, 0, 80)),
            velocity: projectileDirection.__mul(projectileSpeed),
            groundOffset: 0,
            unitTest: (unit, projectile) =>
                unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                ModifierItemNullifier.apply(unit, projectile.getSource(), this, { duration: duration });
                ModifierItemNullifierSlow.apply(unit, projectile.getSource(), this, { duration: initialDuration });

                ApplyDamage({
                    victim: unit,
                    attacker: projectile.getSource(),
                    damage: abilityDamage,
                    damage_type: DamageTypes.MAGICAL
                });
                unit.Purge(true, false, false, false, false);
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(projectile.getPosition());
            }
        });

        EmitSoundOn("DOTA_Item.Nullifier.Cast", this.caster);
    }

    PlayEffectsOnFinish(position: Vector) {
        EmitSoundOnLocationWithCaster(position, "DOTA_Item.Nullifier.Target", this.caster);

        const particleId = ParticleManager.CreateParticle(
            "particles/items4_fx/nullifier_proj_impact.vpcf",
            ParticleAttachment.ABSORIGIN,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 0, position);
        ParticleManager.SetParticleControl(particleId, 3, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerModifier("modifier_item_nullifier_custom_slow")
class ModifierItemNullifierSlow extends CustomModifier {
    DeclareFunctions() {
        return [ModifierFunction.MOVESPEED_BONUS_PERCENTAGE];
    }

    GetModifierAttackSpeedBonus_Constant() {
        return -this.ability.GetSpecialValueFor("slow_pct");
    }

    GetEffectName() {
        return "particles/items4_fx/nullifier_slow.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.ABSORIGIN_FOLLOW;
    }
}

@registerModifier("modifier_item_nullifier_custom")
class ModifierItemNullifier extends CustomModifier {
    OnCreated() {
        if (IsServer()) {
            this.parent.Purge(true, false, false, false, false);
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.INCOMING_DAMAGE_PERCENTAGE];
    }

    GetModifierIncomingDamage_Percentage() {
        if (IsServer()) {
            ModifierItemNullifierSlow.apply(this.parent, this.caster, this.ability, {
                duration: this.ability.GetSpecialValueFor("tick_duration")
            });

            this.parent.Purge(true, false, false, false, false);
        }

        return 0;
    }

    GetStatusEffectName() {
        return "particles/status_fx/status_effect_nullifier.vpcf";
    }

    GetEffectName() {
        return "particles/items4_fx/nullifier_mute_debuff.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.ABSORIGIN_FOLLOW;
    }

    // function modifier_item_nullifier_custom:GetStatusLabel() return "Nullify" }
    // function modifier_item_nullifier_custom:GetStatusPriority() return 3 }
    // function modifier_item_nullifier_custom:GetStatusStyle() return "Nullify" }
}
// if(IsClient()){ require("wrappers/modifiers") }
// Modifiers.Status(modifier_item_nullifier_custom)
