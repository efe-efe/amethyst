import { CustomAbility } from "../../../abilities/framework/custom_ability";
import { registerAbility } from "../../../lib/dota_ts_adapter";
import { attackWithBaseDamage, direction2D, fakeAbility } from "../../../util";

@registerAbility("dire_creep_attack_range")
class DireCreepAttackRange extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_ATTACK;
    }

    GetPlaybackRateOverride() {
        return 1.2;
    }

    GetCastingCrawl() {
        return 0;
    }

    GetCastPoint() {
        if (IsServer()) {
            return this.caster.GetAttackAnimationPoint();
        }

        return 0;
    }

    GetCooldown(level: number) {
        if (IsServer()) {
            const attacksPerSecond = this.caster.GetAttacksPerSecond();
            const attackSpeed = 1 / attacksPerSecond;

            return super.GetCooldown(level) + attackSpeed;
        }

        return super.GetCooldown(level);
    }

    OnSpellStart() {
        const point = this.GetCursorPosition();
        const origin = this.caster.GetOrigin();
        const projectileDirection = direction2D(origin, point);
        const projectileSpeed = RandomInt(1500, 2000);

        if (fakeAbility(this)) {
            return;
        }

        this.ProjectileAttack({
            source: this.caster,
            attackType: "basic",
            effectName: "particles/dire_zombie/dire_zombie_projectile.vpcf",
            distance: this.GetCastRange(Vector(0, 0, 0), undefined),
            startRadius: 70,
            spawnOrigin: origin.__add(Vector(0, 0, 96)),
            velocity: projectileDirection.__mul(projectileSpeed),
            groundOffset: 0,
            unitTest: (unit, projectile) =>
                unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                attackWithBaseDamage({
                    source: projectile.getSource(),
                    target: unit,
                    ability: this
                });
            },
            onFinish: projectile => {
                EFX("particles/base_attacks/ti9_dire_ranged_explosion.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
                    cp0: projectile.getPosition(),
                    cp3: projectile.getPosition()
                });
                EmitSoundOn("Hero_QueenOfPain.ShadowStrike.Target", this.caster);
            }
        });

        EmitSoundOn("General.Attack", this.caster);
    }
}
