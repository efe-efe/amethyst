import { CustomAbility } from "../../../../abilities/framework/custom_ability";
import { registerAbility } from "../../../../lib/dota_ts_adapter";
import { ProjectileBehavior } from "../../../../projectiles";
import { direction2D, fakeAbility } from "../../../../util";

@registerAbility("centaur_range_attack")
class CentaurRangeAttack extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_ATTACK;
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
        const straightDirection = direction2D(origin, point);

        const directions = [
            straightDirection,
            RotatePoint(Vector(0, 0, 0), Vector(0, 0, 0).__add(straightDirection), -30).Normalized(),
            RotatePoint(Vector(0, 0, 0), Vector(0, 0, 0).__add(straightDirection), 30).Normalized()
        ];

        for (const direction of directions) {
            this.LaunchProjectile(direction);
        }

        EmitSoundOn("Hero_Centaur.DoubleEdge.TI9", this.caster);
    }

    LaunchProjectile(direction: Vector) {
        const origin = this.caster.GetOrigin();
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");

        if (fakeAbility(this)) {
            return;
        }

        this.ProjectileAttack({
            source: this.caster,
            effectName: "particles/units/heroes/hero_invoker/invoker_deafening_blast.vpcf",
            distance: this.GetCastRange(Vector(0, 0, 0), undefined),
            spawnOrigin: origin.__add(Vector(direction.x * 45, direction.y * 45, 96)),
            velocity: direction.__mul(projectileSpeed),
            groundOffset: 0,
            unitBehavior: ProjectileBehavior.NOTHING,
            unitTest: (unit, projectile) =>
                unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                ApplyDamage({
                    victim: unit,
                    attacker: projectile.getSource(),
                    damage: this.GetSpecialValueFor("ability_damage"),
                    damage_type: DamageTypes.MAGICAL
                });
                this.PlayEffectsOnHit(unit);
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(
                    projectile.getPosition(),
                    "particles/units/heroes/hero_sniper/sniper_assassinate_impact_sparks.vpcf"
                );
            }
        });
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
