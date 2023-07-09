import { CustomAbility } from "../../../../abilities/framework/custom_ability";
import { CustomModifier } from "../../../../abilities/framework/custom_modifier";
import { registerAbility, registerModifier } from "../../../../lib/dota_ts_adapter";
import { ModifierFadingSlow } from "../../../../modifiers/modifier_fading_slow";
import { areUnitsAllied, direction2D } from "../../../../util";

@registerAbility("queen_attack")
export class QueenAttack extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_1;
    }

    GetPlaybackRateOverride() {
        return 0.9;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnSpellStart() {
        const point = this.GetCursorPosition();
        const distance = this.GetCastRange(Vector(0, 0, 0), undefined);
        this.LaunchProjectile(point, 1500, distance, 20);
        EmitSoundOn("Hero_QueenOfPain.ShadowStrike", this.caster);
    }

    LaunchProjectile(point: Vector, speed: number, distance: number, damage: number) {
        const origin = this.caster.GetOrigin();
        const projectileDirection = direction2D(origin, point);
        const poisonDuration = 4.0;
        const fadingSlowDuration = 4.0;
        const fadingSlowPct = 80;

        this.ProjectileAttack({
            source: this.caster,
            attackType: "basic",
            effectName: "particles/queen/queen_dagger.vpcf",
            distance: distance,
            startRadius: 70,
            spawnOrigin: origin.__add(Vector(0, 0, 96)),
            velocity: projectileDirection.__mul(speed),
            groundOffset: 0,
            unitTest: (unit, projectile) => !areUnitsAllied(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                ApplyDamage({
                    victim: unit,
                    attacker: projectile.getSource(),
                    damage: damage,
                    damage_type: DamageTypes.PHYSICAL,
                    ability: this
                });

                ModifierQueenAttack.apply(unit, projectile.getSource(), this, { duration: poisonDuration });
                ModifierFadingSlow.apply(unit, projectile.getSource(), undefined, {
                    duration: fadingSlowDuration,
                    maxSlowPct: fadingSlowPct
                });
            },
            onFinish: projectile => {
                EFX(
                    "particles/units/heroes/hero_queenofpain/queen_shadow_strike_explosion.vpcf",
                    ParticleAttachment.WORLDORIGIN,
                    undefined,
                    {
                        cp0: projectile.getPosition(),
                        cp3: projectile.getPosition()
                    }
                );
                EmitSoundOn("Hero_QueenOfPain.ShadowStrike.Target", this.caster);
            }
        });
    }
}

@registerModifier("modifier_queen_attack")
class ModifierQueenAttack extends CustomModifier {
    OnCreated() {
        if (IsServer()) {
            this.StartIntervalThink(1.0);
        }
    }

    OnIntervalThink() {
        if (IsServer()) {
            ApplyDamage({
                attacker: this.caster,
                damage: 5,
                damage_type: DamageTypes.PURE,
                victim: this.parent
            });
        }
    }

    GetEffectName() {
        return "particles/generic_gameplay/rune_haste.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.OVERHEAD_FOLLOW;
    }

    GetStatusEffectName() {
        return "particles/status_fx/status_effect_terrorblade_reflection.vpcf";
    }
}
