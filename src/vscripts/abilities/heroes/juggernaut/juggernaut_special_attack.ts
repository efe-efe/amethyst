import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { Translate } from "../../../modifiers/modifier_casting";
import { ModifierFadingSlow } from "../../../modifiers/modifier_fading_slow";
import { ModifierRecast } from "../../../modifiers/modifier_recast";
import { areUnitsAllied, direction2D, getCursorPosition, giveManaAndEnergyPercent, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";
import { defineAbility } from "../../framework/ability_definition";
import { precache, resource } from "../../../precache";
import { addAnimation } from "../../../animation";
import { hasUpgrade } from "../../../upgrades/framework/upgrade_definitions";

const resources = precache({
    projectile: resource.fx("particles/juggernaut/juggernaut_special_attack.vpcf"),
    impact: resource.fx("particles/econ/items/arc_warden/arc_warden_ti9_immortal/arc_warden_ti9_wraith_impact_start.vpcf"),
    jumpTrail: resource.fx("particles/juggernaut/special_attack_recast.vpcf")
});

@registerAbility("juggernaut_special_attack")
class JuggernautSpecialAttack extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_TAUNT;
    }

    GetPlaybackRateOverride() {
        return 2.0;
    }

    GetCastingCrawl() {
        return 10;
    }

    GetAnimationTranslate() {
        return Translate.odachi;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = getCursorPosition(this.caster);
        const damage = this.GetSpecialValueFor("ability_damage");
        const fading_slow_pct = this.GetSpecialValueFor("fading_slow_pct");
        const fading_slow_duration = this.GetSpecialValueFor("fading_slow_duration");
        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        const recastTime = this.GetSpecialValueFor("recast_time");
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);

        this.ProjectileAttack({
            source: this.caster,
            velocity: projectileDirection.__mul(projectileSpeed),
            spawnOrigin: origin.__add(Vector(projectileDirection.x * 45, projectileDirection.y * 45, 96)),
            effectName: resources.projectile.path,
            groundOffset: 0,
            unitTest: (unit, projectile) => !areUnitsAllied(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                ApplyDamage({
                    victim: unit,
                    attacker: projectile.getSource(),
                    damage: damage,
                    damage_type: DamageTypes.MAGICAL,
                    ability: this
                });

                ModifierFadingSlow.apply(unit, this.caster, undefined, {
                    duration: fading_slow_duration,
                    maxSlowPct: fading_slow_pct
                });

                if (projectile.getSource() == this.caster) {
                    if (this.GetLevel() == 2) {
                        if (unit.IsAlive()) {
                            ModifierJuggernautSpecialAttackMark.apply(this.caster, unit, this, { duration: recastTime });
                            ModifierJuggernautSpecialAttackRecast.apply(this.caster, this.caster, undefined, {
                                duration: recastTime,
                                abilityLeft: JuggernautSpecialAttack.name,
                                abilityRight: JuggernautSpecialAttackRecast.name
                            });
                        }
                    }

                    if (!isObstacle(unit) && !isGem(unit)) {
                        giveManaAndEnergyPercent(projectile.getSource(), manaGainPct, true);
                    }
                }
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(projectile.getPosition());
                if (projectile.getSource() == this.caster && hasUpgrade(this.caster, UpgradeId.juggernautDagggerRefresh)) {
                    if (projectile.hitLog.size == 0) {
                        this.StartCooldown(this.GetCooldown(this.GetLevel()) * 1.5);
                    } else {
                        this.EndCooldown();
                        this.StartCooldown(this.GetCooldown(this.GetLevel()) / 5);
                    }
                }
            }
        });

        this.PlayEffectsOnCast();
        super.OnSpellStart();
    }

    PlayEffectsOnFinish(position: Vector) {
        EmitSoundOnLocationWithCaster(position, "Hero_Juggernaut.Attack", this.caster);
        const particleId = ParticleManager.CreateParticle(resources.impact.path, ParticleAttachment.WORLDORIGIN, undefined);
        ParticleManager.SetParticleControl(particleId, 0, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsOnCast() {
        EmitSoundOn("juggernaut_jug_spawn_02", this.caster);
        EmitSoundOn("Hero_Juggernaut.ArcanaTrigger", this.caster);
        EmitSoundOn("Hero_Juggernaut.BladeDance", this.caster);
    }

    // function juggernaut_special_attack:OnUpgrade()
    // 	CustomAbilitiesLegacy:LinkUpgrades(self, "juggernaut_special_attack_recast")
    // }
}

@registerAbility("juggernaut_special_attack_recast")
class JuggernautSpecialAttackRecast extends CustomAbility {
    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const target = ModifierJuggernautSpecialAttackMark.findOne(this.caster)?.caster;
        const randomNumber = RandomInt(1, 9);

        if (target) {
            if (randomNumber > 1) {
                EmitSoundOn(`juggernaut_jug_ability_bladefury_0${randomNumber}`, this.caster);
            }

            FindClearSpaceForUnit(this.caster, target.GetAbsOrigin().__add(target.GetForwardVector().__mul(Vector(-80, -80, -80))), true);
            const particleId = ParticleManager.CreateParticle(resources.jumpTrail.path, ParticleAttachment.WORLDORIGIN, undefined);
            ParticleManager.SetParticleControl(particleId, 0, origin);
            ParticleManager.SetParticleControl(particleId, 1, origin);
            ParticleManager.SetParticleControl(particleId, 3, origin);
            ParticleManager.ReleaseParticleIndex(particleId);
            addAnimation(this.caster, GameActivity.DOTA_SPAWN, { duration: 1.0, rate: 2.0 });
        }
    }

    // function juggernaut_special_attack_recast:OnUpgrade()
    // 	CustomAbilitiesLegacy:LinkUpgrades(self, "juggernaut_special_attack")
    // }
}

@registerModifier("modifier_juggernaut_special_attack_recast")
class ModifierJuggernautSpecialAttackRecast extends ModifierRecast<undefined> {}

@registerModifier("modifier_juggernaut_special_attack_mark")
class ModifierJuggernautSpecialAttackMark extends CustomModifier {}

defineAbility(JuggernautSpecialAttack, {
    category: "special"
});

defineAbility(JuggernautSpecialAttackRecast, {
    category: "special"
});
