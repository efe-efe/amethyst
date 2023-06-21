import { registerAbility } from "../../../lib/dota_ts_adapter";
import { attackWithBaseDamage, direction2D, giveManaAndEnergyPercent, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";

@registerAbility("invoker_basic_attack")
export class InvokerBasicAttack extends CustomAbility {
    GetCastPoint() {
        if (IsServer()) {
            return super.GetCastPoint() + this.caster.GetAttackAnimationPoint();
        }

        return super.GetCastPoint();
    }

    GetCooldown(level: number) {
        if (IsServer()) {
            const attacksPerSecond = this.caster.GetAttacksPerSecond();
            const attackSpeed = 1 / attacksPerSecond;

            return super.GetCooldown(level) + attackSpeed;
        }
        return super.GetCooldown(level);
    }

    GetAnimation() {
        return GameActivity.DOTA_ATTACK;
    }

    GetPlaybackRateOverride() {
        return 1.5;
    }

    GetCastingCrawl() {
        return 10;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = CustomAbilitiesLegacy.GetCursorPosition(this);
        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);

        this.ProjectileAttack({
            source: this.caster,
            attackType: "basic",
            effectName: "particles/invoker/invoker_basic_attack.vpcf",
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

                if (projectile.getSource() == this.caster) {
                    if (!isObstacle(unit) && !isGem(unit)) {
                        giveManaAndEnergyPercent(projectile.getSource(), manaGainPct, true);
                    }
                }
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(projectile.getPosition());
            }
        });

        EmitSoundOn("Hero_Invoker.Attack", this.caster);
    }

    PlayEffectsOnFinish(position: Vector) {
        EmitSoundOnLocationWithCaster(position, "Hero_Invoker.ProjectileImpact", this.caster);

        const particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_stormspirit/stormspirit_base_attack_explosion.vpcf",
            ParticleAttachment.ABSORIGIN,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 3, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}
