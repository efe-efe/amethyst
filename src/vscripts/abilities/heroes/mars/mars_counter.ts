import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { OnHitEvent } from "../../../modifiers/modifier_combat_events";
import { ModifierCounter } from "../../../modifiers/modifier_counter";
import { ModifierDisplacement } from "../../../modifiers/modifier_displacement";
import { ModifierStun } from "../../../modifiers/modifier_stunned";
import { direction2D, fullyFaceTowards, getCursorPosition } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";

@registerAbility("mars_counter")
class MarsCounter extends CustomAbility {
    OnSpellStart() {
        EmitSoundOn("Hero_Mars.Shield.Block", this.caster);
        EmitSoundOn("Hero_Mars.Block_Projectile", this.caster);

        this.caster.AddNewModifier(this.caster, this, "modifier_mars_counter_countering", {
            duration: this.GetSpecialValueFor("counter_duration")
        });

        const particleId = ParticleManager.CreateParticle(
            "particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff_circle_outer_pulse.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.caster
        );
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerModifier("modifier_mars_counter_countering")
class ModifierMarsCounter extends ModifierCounter {
    OnCreated() {
        super.OnCreated();

        if (IsServer()) {
            this.parent.StartGesture(GameActivity.DOTA_OVERRIDE_ABILITY_3);
            this.StartIntervalThink(0.03);
        }
    }

    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            ParticleManager.ReleaseParticleIndex(
                ParticleManager.CreateParticle(
                    "particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff_circle_outer_pulse.vpcf",
                    ParticleAttachment.ABSORIGIN_FOLLOW,
                    this.parent
                )
            );
        }
    }

    OnIntervalThink() {
        const mouse = getCursorPosition(this.caster);
        const direction = direction2D(this.parent.GetAbsOrigin(), mouse);
        this.PlayEffectsOnCast();
        fullyFaceTowards(this.parent, Vector(direction.x, direction.y, this.parent.GetForwardVector().z));
    }

    DeclareFunctions() {
        return [ModifierFunction.ON_ABILITY_EXECUTED, ModifierFunction.TRANSLATE_ACTIVITY_MODIFIERS, ModifierFunction.ON_ORDER];
    }

    GetActivityTranslationModifiers() {
        return "bulwark";
    }

    OnAbilityExecuted(event: ModifierAbilityEvent) {
        if (IsServer() && event.unit == this.parent) {
            this.Destroy();
        }
    }

    PlayEffectsMeele(target: CDOTA_BaseNPC) {
        const particleId = EFX("particles/mars/mars_second_attack_light.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.parent, {});

        ParticleManager.SetParticleControlEnt(
            particleId,
            1,
            target,
            ParticleAttachment.POINT_FOLLOW,
            "attach_hitloc",
            target.GetAbsOrigin(),
            true
        );
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    OnOrder(event: ModifierUnitEvent) {
        if (event.unit == this.parent && (event.order_type == UnitOrder.STOP || event.order_type == UnitOrder.HOLD_POSITION)) {
            this.Destroy();
        }
    }

    PlayEffectsOnCast() {
        const particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_mars/mars_shield_of_mars.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.parent
        );
        ParticleManager.SetParticleControlForward(particleId, 0, this.parent.GetForwardVector());
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsOnTrigger() {
        EmitSoundOn("Hero_Mars.Shield.Block", this.parent);
        EmitSoundOn("Hero_Mars.Block_Projectile", this.parent);

        const particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_mars/mars_shield_of_mars.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.parent
        );
        ParticleManager.SetParticleControlForward(particleId, 0, this.parent.GetForwardVector());
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    GetStatusEffectName() {
        return "particles/econ/items/effigies/status_fx_effigies/status_effect_effigy_gold_lvl2_dire.vpcf";
    }

    GetMovementSpeedPercentage() {
        return 50;
    }

    Visuals() {
        return [];
    }

    OnHit(event: OnHitEvent) {
        if (!IsServer() || !event.triggerCounters) {
            return true;
        }

        const direction =
            event.attackCategory == "projectile"
                ? event.projectile.getVelocity().Normalized()
                : direction2D(event.source.GetAbsOrigin(), this.parent.GetAbsOrigin());

        const projection = direction.x * this.parent.GetForwardVector().x + direction.y * this.parent.GetForwardVector().y;

        if (projection <= -0.8) {
            if (event.attackCategory == "projectile") {
                if (event.projectile.getIsReflectable()) {
                    event.projectile.setVelocity(event.projectile.getVelocity(), event.projectile.getPosition());
                    event.projectile.setSource(this.parent);
                    // projectile:SetVisionTeam(self:GetParent():GetTeam())
                    event.projectile.resetDistanceTraveled();
                    // projectile:ResetRehit()
                } else {
                    if (event.projectile.getIsDestructible()) {
                        event.projectile.scheduleDestroy();
                    }
                }
            }

            if (event.attackCategory == "meele" || event.attackCategory == "single") {
                ModifierMarsCounterDisplacement.apply(event.source, this.parent, this.ability, {
                    x: direction.x * -1,
                    y: direction.y * -1,
                    distance: 300,
                    speed: 150 / 0.1,
                    peak: 50
                });

                ApplyDamage({
                    victim: event.source,
                    attacker: this.parent,
                    damage: this.Value("meele_damage"),
                    damage_type: DamageTypes.PURE
                });

                this.PlayEffectsMeele(event.source);
            }

            this.PlayEffectsOnTrigger();
            return false;
        }

        return true;
    }
}

@registerModifier("modifier_mars_counter_displacement")
class ModifierMarsCounterDisplacement extends ModifierDisplacement {
    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            ModifierStun.apply(this.parent, this.caster, undefined, { duration: this.Value("meele_stun_duration") });
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_FLAIL;
    }

    GetOverrideAnimationRate() {
        return 1.0;
    }

    CheckState() {
        return {
            ...super.CheckState(),
            [ModifierState.NO_HEALTH_BAR]: true,
            [ModifierState.NO_UNIT_COLLISION]: true
        };
    }
}
