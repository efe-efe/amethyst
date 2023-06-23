import { CustomAbility } from "../../../abilities/framework/custom_ability";
import { CustomModifier } from "../../../abilities/framework/custom_modifier";
import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { attackWithBaseDamage, direction2D } from "../../../util";

@registerAbility("dire_tower_attack")
class DireTowerAttack extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CUSTOM_TOWER_ATTACK;
    }

    GetPlaybackRateOverride() {
        return 1.0;
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

    GetIntrinsicModifierName() {
        return ModifierDireTowerAttack.name;
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
        const projectileSpeed = 1000;

        this.ProjectileAttack({
            source: this.caster,
            attackType: "basic",
            effectName: "particles/dire_tower/ti10_dire_tower_attack.vpcf",
            distance: this.GetCastRange(Vector(0, 0, 0), undefined),
            startRadius: 70,
            spawnOrigin: origin.__add(Vector(0, 0, 200)),
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
                EFX(
                    "particles/econ/world/towers/ti10_dire_tower/ti10_dire_tower_attack_impact.vpcf",
                    ParticleAttachment.WORLDORIGIN,
                    undefined,
                    {
                        cp0: projectile.getPosition(),
                        cp3: projectile.getPosition()
                    }
                );
                EmitSoundOn("Tower.HeroImpact", this.caster);
            }
        });

        EmitSoundOn("General.Attack", this.caster);
    }
}

@registerModifier({ customNameForI18n: "modifier_dire_tower_attack" })
class ModifierDireTowerAttack extends CustomModifier {
    OnCreated() {
        if (IsServer()) {
            EFX(
                "particles/econ/world/towers/ti10_dire_tower/ti10_dire_tower_ambient.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent,
                {
                    release: true
                }
            );
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.ON_DEATH];
    }

    OnDeath(event: ModifierInstanceEvent) {
        if (IsServer() && event.unit == this.parent) {
            this.parent.StartGestureWithPlaybackRate(GameActivity.DOTA_CUSTOM_TOWER_DIE, 0.5);
        }
    }
}
