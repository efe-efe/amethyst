import { registerAbility } from "../../../lib/dota_ts_adapter";
import { Translate } from "../../../modifiers/modifier_casting";
import { ModifierUpgradeSniperFastSnipe } from "../../../modifiers/upgrades/modifier_favors";
import { ModifierRoot } from "../../../modifiers/modifier_root";
import { ModifierStun } from "../../../modifiers/modifier_stunned";
import { ProjectileBehavior } from "../../../projectiles";
import { areUnitsAllied, direction2D, getCursorPosition, giveManaAndEnergyPercent, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";

class SniperSecondAttackCommon extends CustomAbility {
    PlayEffectsOnCast() {
        EmitSoundOn("Ability.Assassinate", this.caster);
    }

    PlayEffectsOnFinish(position: Vector, path: string) {
        EmitSoundOnLocationWithCaster(position, "Hero_Sniper.AssassinateDamage", this.caster);

        const particleId = ParticleManager.CreateParticle(path, ParticleAttachment.ABSORIGIN, this.caster);
        ParticleManager.SetParticleControl(particleId, 0, position);
        ParticleManager.SetParticleControl(particleId, 1, position);
        ParticleManager.SetParticleControl(particleId, 3, position);

        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsOnHit(unit: CDOTA_BaseNPC) {
        EmitSoundOn("Hero_Sniper.AssassinateDamage", this.caster);

        const particle_cast = "particles/units/heroes/hero_sniper/sniper_assassinate_impact_blood.vpcf";
        const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN_FOLLOW, unit);

        ParticleManager.SetParticleControl(particleId, 0, unit.GetAbsOrigin());
        ParticleManager.SetParticleControl(particleId, 1, unit.GetAbsOrigin());
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerAbility("sniper_second_attack")
class SniperSecondAttack extends SniperSecondAttackCommon {
    particleId?: ParticleID;

    GetAnimation() {
        return this.GetLevel() >= 2 ? GameActivity.DOTA_DIE : GameActivity.DOTA_CAST_ABILITY_1;
    }

    GetAnimationTranslate() {
        return this.GetLevel() >= 2 ? Translate.overkilled : undefined;
    }

    GetPlaybackRateOverride() {
        return this.GetLevel() >= 2 ? 0.8 : 0.5;
    }

    GetCastingCrawl() {
        return this.GetLevel() >= 2 ? 60 : 0;
    }

    GetCastPoint() {
        if (IsServer() && ModifierUpgradeSniperFastSnipe.findOne(this.caster)) {
            return 0.3;
        }

        return super.GetCastPoint();
    }

    OnAbilityPhaseStart() {
        if (super.OnAbilityPhaseStart()) {
            EmitGlobalSound("Ability.AssassinateLoad");

            this.particleId = ParticleManager.CreateParticle(
                "particles/econ/items/wisp/wisp_relocate_channel_ti7.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.caster
            );
            ParticleManager.SetParticleControlEnt(
                this.particleId,
                1,
                this.caster,
                ParticleAttachment.ABSORIGIN_FOLLOW,
                AttachLocation.hitloc,
                this.caster.GetAbsOrigin(),
                false
            );

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
        const point = getCursorPosition(this.caster);
        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);
        const damage = this.GetSpecialValueFor("ability_damage");
        const stunDuration = this.GetSpecialValueFor("stun_duration");
        const reductionPerHit = this.GetSpecialValueFor("reduction_per_hit") / 100;
        const minDamage = this.GetSpecialValueFor("min_damage");

        this.ProjectileAttack({
            source: this.caster,
            effectName: "particles/sniper/sniper_second_attack.vpcf",
            spawnOrigin: origin.__add(Vector(projectileDirection.x * 45, projectileDirection.y * 45, 96)),
            velocity: projectileDirection.__mul(projectileSpeed),
            groundOffset: 0,
            unitBehavior: ProjectileBehavior.NOTHING,
            unitTest: (unit, projectile) => !areUnitsAllied(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                const hits = projectile.hitLog.size;
                const finalDamage = Math.max(minDamage, damage * (1 - hits * reductionPerHit));

                if (hits < 1 && projectile.getSource() == this.caster) {
                    if (!isObstacle(unit) && !isGem(unit)) {
                        giveManaAndEnergyPercent(projectile.getSource(), manaGainPct, true);
                    }
                }

                ApplyDamage({
                    victim: unit,
                    attacker: projectile.getSource(),
                    damage: finalDamage,
                    damage_type: DamageTypes.MAGICAL
                });

                ModifierStun.apply(unit, projectile.getSource(), undefined, { duration: stunDuration });
                this.PlayEffectsOnHit(unit);
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(
                    projectile.getPosition(),
                    "particles/units/heroes/hero_sniper/sniper_assassinate_impact_sparks.vpcf"
                );
            }
        });

        if (this.GetLevel() >= 2) {
            EFX(
                "particles/econ/items/phantom_lancer/phantom_lancer_fall20_immortal/phantom_lancer_fall20_immortal_doppelganger_aoe_gold_bits.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.caster,
                {
                    cp1: origin,
                    release: true
                }
            );
        } else {
            EFX("particles/sniper/sniper_second_attack_endcap_model.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
                cp1: projectileDirection.__mul(100).__add(origin),
                cp1f: this.caster.GetForwardVector(),
                release: true
            });
        }

        this.PlayEffectsOnCast();
        this.caster.StartGestureWithPlaybackRate(GameActivity.DOTA_ATTACK, 3.0);
        // LinkAbilityCooldowns(this.caster, 'sniper_ex_second_attack')
    }
}

@registerAbility("sniper_ex_second_attack")
class SniperExSecondAttack extends SniperSecondAttackCommon {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_1;
    }

    GetPlaybackRateOverride() {
        return 0.5;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = getCursorPosition(this.caster);
        const projectileDirection = direction2D(origin, point);
        const projectileOrigin = origin.__add(Vector(projectileDirection.x * 45, projectileDirection.y * 45, 96));
        this.ThrowProjectile(origin.__add(Vector(0, 0, 96)), projectileDirection, true, this.caster);

        this.PlayEffectsOnCast();
        this.caster.StartGestureWithPlaybackRate(GameActivity.DOTA_ATTACK, 1.5);
        // LinkAbilityCooldowns(this.caster, 'sniper_second_attack')
    }

    ThrowProjectile(origin: Vector, direction: Vector, firstTime: boolean, source: CDOTA_BaseNPC) {
        const damage = this.GetSpecialValueFor("ability_damage");
        const speed = this.GetSpecialValueFor("projectile_speed");
        const rootDuration = this.GetSpecialValueFor("root_duration");
        const reductionPerHit = this.GetSpecialValueFor("reduction_per_hit") / 100;
        const minDamage = this.GetSpecialValueFor("min_damage");

        this.ProjectileAttack({
            source: source,
            effectName: "particles/sniper/sniper_ex_second_attack_new.vpcf",
            spawnOrigin: origin,
            velocity: direction.__mul(speed),
            groundOffset: 0,
            unitBehavior: ProjectileBehavior.NOTHING,
            unitTest: (unit, projectile) => !areUnitsAllied(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                const hits = projectile.hitLog.size;
                const finalDamage = Math.max(minDamage, damage * (1 - hits * reductionPerHit));

                ApplyDamage({
                    victim: unit,
                    attacker: projectile.getSource(),
                    damage: finalDamage,
                    damage_type: DamageTypes.MAGICAL
                });

                ModifierRoot.apply(unit, projectile.getSource(), this, { duration: rootDuration });
                this.PlayEffectsOnHit(unit);
            },
            onFinish: projectile => {
                if (this.GetLevel() >= 2 && firstTime) {
                    const newDirection = projectile
                        .getSource()
                        .GetAbsOrigin()
                        .__add(Vector(0, 0, 96))
                        .__sub(projectile.getPosition())
                        .Normalized();
                    const newOrigin = projectile.getPosition().__add(Vector(newDirection.x * 45, newDirection.y * 45, 0));
                    this.ThrowProjectile(newOrigin, newDirection, false, projectile.getSource());
                }
                this.PlayEffectsOnFinish(
                    projectile.getPosition(),
                    "particles/econ/items/sniper/sniper_fall20_immortal/sniper_fall20_immortal_base_attack_impact.vpcf"
                );
            }
        });
    }
}
