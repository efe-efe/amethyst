import { createRadiusMarker, findUnitsInRadius } from "../../../util";
import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { OnHitEvent } from "../../../modifiers/modifier_combat_events";
import { ModifierCounter } from "../../../modifiers/modifier_counter";
import { ModifierDisplacement } from "../../../modifiers/modifier_displacement";
import { direction2D, giveManaAndEnergy, strongPurge } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";

@registerAbility("storm_counter")
class StormCounter extends CustomAbility {
    OnSpellStart() {
        const duration = this.GetSpecialValueFor("counter_duration");
        ModifierStormCounter.apply(this.caster, this.caster, this, { duration: duration });
    }
}

@registerModifier("modifier_storm_counter_countering")
class ModifierStormCounter extends ModifierCounter {
    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            EmitSoundOn("Hero_Juggernaut.Attack", this.parent);
            const particleId = ParticleManager.CreateParticle(
                "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_omni_slash_tgt_bonus.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.GetCaster()
            );
            ParticleManager.ReleaseParticleIndex(particleId);
        }
    }

    OnHit(event: OnHitEvent) {
        if (IsServer()) {
            if (!event.triggerCounters) {
                return true;
            }

            giveManaAndEnergy(this.parent, this.Value("mana_gain"), true);
            const enemies = findUnitsInRadius(
                this.parent,
                this.parent.GetAbsOrigin(),
                this.Value("radius"),
                UnitTargetTeam.ENEMY,
                UnitTargetType.HERO + UnitTargetType.BASIC,
                UnitTargetFlags.NONE,
                FindOrder.ANY
            );
            for (const enemy of enemies) {
                ApplyDamage({
                    victim: enemy,
                    attacker: this.parent,
                    damage: this.Value("ability_damage"),
                    damage_type: DamageTypes.PURE
                });
                const direction = direction2D(this.parent.GetAbsOrigin(), enemy.GetAbsOrigin());
                ModifierStormCounterDisplacement.apply(enemy, this.parent, this.ability, {
                    x: direction.x,
                    y: direction.y,
                    distance: this.Value("knockback_distance"),
                    speed: this.Value("knockback_distance") / 0.25,
                    peak: 50
                });
            }
            strongPurge(this.parent);
            this.PlayEffectsOnTrigger();
            createRadiusMarker(this.parent, this.parent.GetAbsOrigin(), this.Value("radius"), "public", 0.1);
            ScreenShake(this.parent.GetAbsOrigin(), 100, 300, 0.45, 1000, 0, true);

            //@Refactor check on this... Idk why i manually destroy it
            if (event.attackCategory == "projectile") {
                const projectile = event.projectile;
                if (projectile.getIsDestructible()) {
                    projectile.scheduleDestroy();
                }
            }

            return false;
        }

        return true;
    }

    AfterHit() {
        if (IsServer()) {
            this.Destroy();
        }
    }

    GetMovementSpeedPercentage() {
        return 0;
    }

    DeclareFunctions() {
        return [...super.DeclareFunctions(), ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_1;
    }

    GetOverrideAnimationRate() {
        return 0.5;
    }

    PlayEffectsOnTrigger() {
        EmitSoundOn("stormspirit_ss_laugh_04", this.parent);
        EFX("particles/units/heroes/hero_void_spirit/voidspirit_overload_discharge.vpcf", ParticleAttachment.WORLDORIGIN, this.parent, {
            cp0: this.parent.GetAbsOrigin(),
            release: true
        });
        const particleId = EFX(
            "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_chakra_magic.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.parent,
            {
                cp1: this.parent.GetAbsOrigin()
            }
        );
        ParticleManager.SetParticleControlEnt(
            particleId,
            1,
            this.parent,
            ParticleAttachment.POINT_FOLLOW,
            AttachLocation.hitloc,
            this.parent.GetAbsOrigin(),
            true
        );
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerModifier("modifier_storm_counter_displacement")
class ModifierStormCounterDisplacement extends ModifierDisplacement {
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
