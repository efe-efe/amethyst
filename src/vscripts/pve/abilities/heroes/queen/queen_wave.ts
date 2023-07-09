import { CustomAbility } from "../../../../abilities/framework/custom_ability";
import { registerAbility } from "../../../../lib/dota_ts_adapter";
import { ProjectileBehavior } from "../../../../projectiles";
import { areUnitsAllied, direction2D } from "../../../../util";

@registerAbility("queen_wave")
class QueenWave extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_4;
    }

    GetPlaybackRateOverride() {
        return 0.8;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnAbilityPhaseStart() {
        if (super.OnAbilityPhaseStart()) {
            EFX("particles/units/heroes/hero_dawnbreaker/dawnbreaker_converge.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
                relese: true
            });
            return true;
        }
        return false;
    }

    OnSpellStart() {
        const origin = this.caster.GetOrigin();
        const point = this.GetCursorPosition();
        const projectileDirection = direction2D(origin, point);
        const projectileSpeed = 850;
        const projectileDistance = 1000;
        const damage = this.GetSpecialValueFor("ability_damage");

        this.ProjectileAttack({
            source: this.caster,
            effectName: "particles/units/heroes/hero_queenofpain/queen_sonic_wave.vpcf",
            distance: projectileDistance,
            startRadius: this.GetSpecialValueFor("hitbox"),
            endRadius: this.GetSpecialValueFor("hitbox") * 4,
            spawnOrigin: origin.__add(Vector(projectileDirection.x * 45, projectileDirection.y * 45, 96)),
            velocity: projectileDirection.__mul(projectileSpeed),
            unitBehavior: ProjectileBehavior.NOTHING,
            groundOffset: 0,
            unitTest: (unit, projectile) => !areUnitsAllied(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                ApplyDamage({
                    victim: unit,
                    attacker: projectile.getSource(),
                    damage: damage,
                    damage_type: DamageTypes.MAGICAL
                });
                this.PlayEffectsOnHit(unit);
            }
        });

        EmitSoundOn("Hero_QueenOfPain.SonicWave", this.caster);
    }

    PlayEffectsOnFinish(position: Vector, path: string) {
        EmitSoundOnLocationWithCaster(position, "Hero_Centaur.DoubleEdge", this.caster);
        EmitSoundOnLocationWithCaster(position, "Hero_Centaur.DoubleEdge.TI9_layer", this.caster);
        EmitSoundOnLocationWithCaster(position, "Hero_Centaur.Gore", this.caster);

        const particleId = ParticleManager.CreateParticle(path, ParticleAttachment.ABSORIGIN, this.caster);
        ParticleManager.SetParticleControl(particleId, 0, position);
        ParticleManager.SetParticleControl(particleId, 1, position);
        ParticleManager.SetParticleControl(particleId, 3, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsOnHit(target: CDOTA_BaseNPC) {
        EmitSoundOn("Hero_Sniper.AssassinateDamage", this.caster);

        const particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_sniper/sniper_assassinate_impact_blood.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            target
        );

        ParticleManager.SetParticleControl(particleId, 0, target.GetAbsOrigin());
        ParticleManager.SetParticleControl(particleId, 1, target.GetAbsOrigin());
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}
