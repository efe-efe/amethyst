import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { Translate } from "../../../modifiers/modifier_casting";
import { ModifierStun } from "../../../modifiers/modifier_stunned";
import { areUnitsAllied, direction2D, getCursorPosition, giveManaAndEnergyPercent, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";

@registerAbility("storm_second_attack")
export class StormSecondAttack extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_ATTACK;
    }

    GetPlaybackRateOverride() {
        return 1.5;
    }

    GetCastingCrawl() {
        return 10;
    }

    GetAnimationTranslate() {
        return Translate.overload;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = getCursorPosition(this.caster);
        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);
        const damage = this.GetSpecialValueFor("ability_damage");
        const duration = this.GetSpecialValueFor("duration");

        this.ProjectileAttack({
            source: this.caster,
            effectName: "particles/storm/storm_second_attack.vpcf",
            spawnOrigin: origin.__add(Vector(projectileDirection.x * 45, projectileDirection.y * 45, 96)),
            velocity: projectileDirection.__mul(projectileSpeed),
            groundOffset: 0,
            unitTest: (unit, projectile) => !areUnitsAllied(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                ApplyDamage({
                    victim: unit,
                    attacker: this.caster,
                    damage: damage,
                    damage_type: DamageTypes.MAGICAL,
                    ability: this
                });

                if (projectile.getSource() == this.caster) {
                    if (!isObstacle(unit) && !isGem(unit)) {
                        giveManaAndEnergyPercent(projectile.getSource(), manaGainPct, true);

                        if (this.caster.HasModifier("modifier_storm_ultimate")) {
                            // const extraManaPct = manaGainPct * (this.caster.FindModifierByName('modifier_storm_ultimate').GetManaMultiplier() - 1)
                            // giveManaPercent(this.caster, extraManaPct, true, true)
                        }
                    }
                }

                if (this.GetLevel() >= 2) {
                    ModifierStormSecondAttack.apply(unit, projectile.getSource(), this, { duration: duration });
                }
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(projectile.getPosition());
            }
        });
        EmitSoundOn("Hero_StormSpirit.Attack", this.caster);
    }

    PlayEffectsOnFinish(position: Vector) {
        EmitSoundOnLocationWithCaster(position, "Hero_StormSpirit.ProjectileImpact", this.caster);
        EmitSoundOnLocationWithCaster(position, "Hero_StormSpirit.StaticRemnantExplode", this.caster);
        const particleId = ParticleManager.CreateParticle(
            "particles/storm/storm_basic_attack_explosion.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(particleId, 0, position);
        ParticleManager.SetParticleControl(particleId, 3, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerModifier("modifier_storm_second_attack")
class ModifierStormSecondAttack extends CustomModifier {
    OnCreated() {
        if (IsServer()) {
            this.StartIntervalThink(this.Value("think_interval"));
        }
    }

    OnIntervalThink() {
        ApplyDamage({
            attacker: this.parent,
            damage: this.Value("damage_per_tick"),
            damage_type: DamageTypes.PURE,
            victim: this.parent
        });
        EmitSoundOn("Hero_StormSpirit.StaticRemnantExplode", this.parent);
        EFX("particles/econ/events/ti9/shivas_guard_ti9_impact.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.parent, {
            release: true
        });
        ModifierStun.apply(this.parent, this.parent, undefined, { duration: this.Value("stun_duration") });
    }
    // function modifier_storm_second_attack:GetStatusLabel() return "Unstable Energy" }
    // function modifier_storm_second_attack:GetStatusPriority() return 4 }
    // function modifier_storm_second_attack:GetStatusStyle() return "Counter" }
}
// if IsClient() then require("wrappers/modifiers") }
// Modifiers.Status(modifier_storm_second_attack)
