import { registerAbility } from "../../../lib/dota_ts_adapter";
import { ModifierFadingSlow } from "../../../modifiers/modifier_fading_slow";
import { direction2D, getCursorPosition, giveManaAndEnergyPercent, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { ModifierNevermoreStacks } from "./nevermore_basic_attack";

@registerAbility("nevermore_second_attack")
class NevermoreSecondAttack extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_ATTACK;
    }
    GetPlaybackRateOverride() {
        return 1.3;
    }
    GetCastingCrawl() {
        return 10;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = getCursorPosition(this.caster);
        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);
        const damage = this.GetSpecialValueFor("ability_damage");
        const fadingSlowPct = this.GetSpecialValueFor("fading_slow_pct");
        const fadingSlowDuration = this.GetSpecialValueFor("fading_slow_duration");
        const cdReductionPerSoul = this.GetSpecialValueFor("cd_reduction_per_soul");

        const modifier = ModifierNevermoreStacks.findOne(this.caster);
        const souls = modifier?.GetStackCount() ?? 0;
        modifier?.SetStackCount(0);

        this.ProjectileAttack({
            source: this.caster,
            effectName: "particles/nevermore/nevermore_second_attack_projectile.vpcf",
            spawnOrigin: origin.__add(Vector(0, 0, 96)),
            velocity: projectileDirection.__mul(projectileSpeed),
            groundOffset: 0,
            unitTest: (unit, projectile) =>
                unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                const damage_table = {
                    victim: unit,
                    attacker: projectile.getSource(),
                    damage: damage,
                    damage_type: DamageTypes.PHYSICAL,
                    ability: this
                };
                ApplyDamage(damage_table);

                ModifierFadingSlow.apply(unit, projectile.getSource(), undefined, {
                    duration: fadingSlowDuration,
                    maxSlowPct: fadingSlowPct
                });

                if (projectile.getSource() == this.caster) {
                    if (!isObstacle(unit) && !isGem(unit)) {
                        giveManaAndEnergyPercent(projectile.getSource(), manaGainPct, true);
                        this.PlayEffectsSoul(unit);
                    }
                }
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(projectile.getPosition());
            }
        });

        const cooldown = this.GetCooldown(this.GetLevel()) - souls * cdReductionPerSoul;
        this.EndCooldown();
        this.StartCooldown(cooldown);

        EmitSoundOn("Hero_Nevermore.Attack", this.caster);
        EmitSoundOn("Hero_Nevermore.Death", this.caster);
    }

    PlayEffectsOnFinish(position: Vector) {
        EmitSoundOnLocationWithCaster(position, "Hero_Nevermore.ProjectileImpact", this.caster);

        const particleId = ParticleManager.CreateParticle(
            "particles/nevermore/nevermore_second_attack_impact.vpcf",
            ParticleAttachment.ABSORIGIN,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 1, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsSoul(target: CDOTA_BaseNPC) {
        const info = {
            Target: this.caster,
            Source: target,
            EffectName: "particles/units/heroes/hero_nevermore/nevermore_necro_souls.vpcf",
            iMoveSpeed: 400,
            vSourceLoc: target.GetAbsOrigin(),
            bDodgeable: false,
            bReplaceExisting: false,
            flExpireTime: GameRules.GetGameTime() + 5,
            bProvidesVision: false
        };
        ProjectileManager.CreateTrackingProjectile(info);
    }
}
