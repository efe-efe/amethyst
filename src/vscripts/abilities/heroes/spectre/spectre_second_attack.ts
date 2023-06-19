import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierDisplacement } from "../../../modifiers/modifier_displacement";
import { ModifierFadingSlow } from "../../../modifiers/modifier_fading_slow";
import { direction2D, giveManaAndEnergyPercent, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";

@registerAbility("spectre_second_attack")
class SpectreSecondAttack extends CustomAbility {
    particleId?: ParticleID;

    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_1;
    }

    GetPlaybackRateOverride() {
        return 0.25;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnAbilityPhaseStart() {
        if (super.OnAbilityPhaseStart()) {
            this.PlayEffectsOnPhase();
            return true;
        }
        return false;
    }

    OnAbilityPhaseInterrupted() {
        super.OnAbilityPhaseInterrupted();
        if (this.particleId) {
            DEFX(this.particleId, true);
        }
    }

    OnSpellStart() {
        if (this.particleId) {
            DEFX(this.particleId, false);
        }

        const origin = this.caster.GetAbsOrigin();
        const point = CustomAbilitiesLegacy.GetCursorPosition(this);
        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);
        const damage = this.GetSpecialValueFor("ability_damage");

        this.ProjectileAttack({
            source: this.caster,
            effectName: "particles/spectre/spectre_second_attack.vpcf",
            spawnOrigin: origin.__add(Vector(projectileDirection.x * 45, projectileDirection.y * 45, 96)),
            velocity: projectileDirection.__mul(projectileSpeed),
            groundOffset: 0,
            unitTest: (unit, projectile) =>
                unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                const knockbackDistance = this.GetLevel() >= 2 ? 100 : 75;
                const fadingSlowDuration = this.GetLevel() >= 2 ? 0.7 : 0.5;
                const fadingSlowPct = 100;

                if (this.GetLevel() >= 2) {
                    EFX("particles/spectre/spectre_second_attack_explosion.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, unit, {
                        release: true
                    });
                } else {
                    EFX("particles/spectre/spectre_second_attack_impact.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, unit, {
                        cp1: unit.GetAbsOrigin(),
                        release: true
                    });
                }
                ModifierSpectreSecondAttack.apply(unit, projectile.getSource(), this, {
                    x: projectile.getVelocity().Normalized().x,
                    y: projectile.getVelocity().Normalized().y,
                    distance: knockbackDistance,
                    speed: knockbackDistance / 0.125,
                    peak: 0
                });
                ModifierFadingSlow.apply(unit, projectile.getSource(), undefined, {
                    duration: fadingSlowDuration,
                    maxSlowPct: fadingSlowPct
                });
                ApplyDamage({
                    victim: unit,
                    attacker: projectile.getSource(),
                    damage: damage,
                    damage_type: DamageTypes.MAGICAL
                });
                ScreenShake(unit.GetAbsOrigin(), 100, 300, 0.7, 1000, 0, true);
                if (!isObstacle(unit) && !isGem(unit)) {
                    giveManaAndEnergyPercent(this.caster, manaGainPct, true);
                }
            },
            onFinish: projectile => {
                if (this.GetLevel() >= 2) {
                    if (projectile.hitLog.size == 0) {
                        EFX("particles/spectre/spectre_second_attack_explosion.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
                            cp0: projectile.getPosition(),
                            release: true
                        });
                    }
                    EmitSoundOnLocationWithCaster(projectile.getPosition(), "Hero_Nevermore.Attack", this.caster);
                } else {
                    this.PlayEffectsOnFinish(projectile.getPosition());
                }
            }
        });
        this.caster.StartGestureWithPlaybackRate(GameActivity.DOTA_CAST_ABILITY_1, 2.0);
        EmitSoundOn("Hero_Nevermore.Raze_Flames", this.caster);
    }

    PlayEffectsOnPhase() {
        EmitSoundOn("Hero_Spectre.Haunt", this.caster);
        this.particleId = ParticleManager.CreateParticle(
            "particles/spectre/spectre_second_attack_casting.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.caster
        );
        ParticleManager.SetParticleControlEnt(
            this.particleId,
            1,
            this.caster,
            ParticleAttachment.ABSORIGIN_FOLLOW,
            "attach_hitloc",
            this.caster.GetAbsOrigin(),
            false
        );
    }

    PlayEffectsOnFinish(position: Vector) {
        EmitSoundOnLocationWithCaster(position, "Hero_Nevermore.RequiemOfSouls.Damage", this.caster);
        EFX("particles/units/heroes/hero_arc_warden/arc_warden_wraith_cast.vpcf", ParticleAttachment.ABSORIGIN, this.caster, {
            cp0: position,
            cp1: position,
            cp2: position,
            release: true
        });
    }
}

@registerModifier({ customNameForI18n: "modifier_spectre_second_attack_displacement" })
class ModifierSpectreSecondAttack extends ModifierDisplacement {
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
            [ModifierState.NO_UNIT_COLLISION]: true
        };
    }
}
