import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierRecast } from "../../../modifiers/modifier_recast";
import { ProjectileBehavior, ProjectileHandler } from "../../../projectiles";
import { createRadiusMarker, direction2D, getCursorPosition, giveManaAndEnergyPercent, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";

class PuckMobilityCommon extends CustomAbility {
    projectile?: ProjectileHandler;

    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_1;
    }

    PlayEffectsOnCast() {
        EmitSoundOn("Hero_Puck.Illusory_Orb", this.caster);
    }

    PlayEffectsOnFinish(position: Vector, path: string, secondPath?: string) {
        StopSoundOn("Hero_Puck.Illusory_Orb", this.caster);
        let particleId = ParticleManager.CreateParticle(path, ParticleAttachment.WORLDORIGIN, undefined);
        ParticleManager.SetParticleControl(particleId, 0, position);
        ParticleManager.SetParticleControl(particleId, 3, position);
        ParticleManager.ReleaseParticleIndex(particleId);

        if (secondPath) {
            particleId = ParticleManager.CreateParticle(secondPath, ParticleAttachment.WORLDORIGIN, undefined);
            ParticleManager.SetParticleControl(particleId, 0, position);
            ParticleManager.SetParticleControl(particleId, 1, position);
            ParticleManager.ReleaseParticleIndex(particleId);
        }
    }

    Jump() {
        if (this.projectile) {
            FindClearSpaceForUnit(this.caster, this.projectile.getPosition(), true);
            EmitSoundOn("Hero_Puck.EtherealJaunt", this.caster);
            StopSoundOn("Hero_Puck.Illusory_Orb", this.caster);
            this.projectile.scheduleDestroy();
        }
    }
}

@registerAbility("puck_mobility")
class PuckMobility extends PuckMobilityCommon {
    GetPlaybackRateOverride() {
        return 1.0;
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
        const damageAoe = this.GetSpecialValueFor("damage_aoe");
        const radius = this.GetSpecialValueFor("radius");

        this.projectile = this.ProjectileAttack({
            source: this.caster,
            effectName: "particles/econ/items/puck/puck_alliance_set/puck_illusory_orb_aproset.vpcf",
            spawnOrigin: origin.__add(Vector(0, 0, 80)),
            velocity: projectileDirection.__mul(projectileSpeed),
            // 			bIsReflectable = false,
            isDestructible: false,
            groundOffset: 0,
            wallBehavior: ProjectileBehavior.NOTHING,
            unitBehavior: ProjectileBehavior.NOTHING,
            unitTest: (unit, projectile) =>
                unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                ApplyDamage({
                    victim: unit,
                    attacker: projectile.getSource(),
                    damage: damage,
                    damage_type: DamageTypes.MAGICAL
                });
                if (projectile.getSource() == this.caster) {
                    if (!isObstacle(unit) && !isGem(unit)) {
                        if (this.GetLevel() >= 2) {
                            this.EndCooldown();
                        }
                        giveManaAndEnergyPercent(this.caster, manaGainPct, true);
                    }
                }
            },
            onFinish: projectile => {
                const enemies = CustomEntitiesLegacy.FindUnitsInRadius(
                    projectile.getSource(),
                    point,
                    radius,
                    UnitTargetTeam.ENEMY,
                    UnitTargetType.HERO + UnitTargetType.BASIC,
                    UnitTargetFlags.NONE,
                    FindOrder.ANY
                );

                for (const enemy of enemies) {
                    ApplyDamage({
                        victim: enemy,
                        attacker: projectile.getSource(),
                        damage: damageAoe,
                        damage_type: DamageTypes.MAGICAL
                    });
                }
                ScreenShake(projectile.getPosition(), 100, 300, 0.45, 1000, 0, true);
                createRadiusMarker(projectile.getSource(), projectile.getPosition(), radius, "public", 0.1);
                EmitSoundOn("Hero_Puck.EtherealJaunt", projectile.getSource());
                EmitSoundOnLocationWithCaster(projectile.getPosition(), "Hero_Puck.Waning_Rift", projectile.getSource());
                StopSoundOn("Hero_Puck.Illusory_Orb", projectile.getSource());
                this.PlayEffectsOnFinish(
                    projectile.getPosition(),
                    "particles/econ/items/puck/puck_merry_wanderer/puck_illusory_orb_explode_merry_wanderer.vpcf"
                );

                this.projectile = undefined;
            }
        });

        const time = this.GetCastRange(Vector(0, 0, 0), undefined) / projectileSpeed;

        ModifierPuckMobilityRecast.apply(this.caster, this.caster, this, {
            abilityLeft: PuckMobility.name,
            abilityRight: PuckMobilityRecast.name,
            duration: time
        });

        this.PlayEffectsOnCast();

        // 	LinkAbilityCooldowns(caster, 'puck_ex_mobility', {
        // 		["0"] = {
        // 			ability = 'puck_ex_mobility',
        // 			level = 2,
        // 		}
        // 	})
    }

    // function puck_mobility:OnUpgrade()
    // 	CustomAbilitiesLegacy:LinkUpgrades(this, "puck_mobility_recast")
    // }
}

@registerModifier("modifier_puck_mobility_recast")
class ModifierPuckMobilityRecast extends ModifierRecast {}

@registerAbility("puck_mobility_recast")
class PuckMobilityRecast extends CustomAbility {
    GetCastingCrawl() {
        return 0;
    }

    OnSpellStart() {
        PuckMobility.findOne(this.caster)?.Jump();
    }
    // function puck_mobility_recast:OnUpgrade()
    // 	CustomAbilitiesLegacy:LinkUpgrades(this, "puck_mobility")
    // }
}

@registerAbility("puck_ex_mobility")
class PuckExMobility extends PuckMobilityCommon {
    GetPlaybackRateOverride() {
        return 0.5;
    }

    GetCastingCrawl() {
        return 10;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = getCursorPosition(this.caster);
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);
        const damage = this.GetSpecialValueFor("ability_damage");
        const damageAoe = this.GetSpecialValueFor("damage_aoe");
        const radius = this.GetSpecialValueFor("radius");
        const fearDuration = this.GetSpecialValueFor("fear_duration");

        this.projectile = this.ProjectileAttack({
            source: this.caster,
            effectName: "particles/puck/puck_ex_mobility.vpcf",
            spawnOrigin: origin.__add(Vector(0, 0, 80)),
            velocity: projectileDirection.__mul(projectileSpeed),
            // 			bIsReflectable = false,
            isDestructible: false,
            groundOffset: 0,
            wallBehavior: ProjectileBehavior.NOTHING,
            unitBehavior: ProjectileBehavior.NOTHING,
            unitTest: (unit, projectile) =>
                unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                ApplyDamage({
                    victim: unit,
                    attacker: projectile.getSource(),
                    damage: damage,
                    damage_type: DamageTypes.PURE
                });
            },
            onFinish: projectile => {
                const enemies = CustomEntitiesLegacy.FindUnitsInRadius(
                    projectile.getSource(),
                    point,
                    radius,
                    UnitTargetTeam.ENEMY,
                    UnitTargetType.HERO + UnitTargetType.BASIC,
                    UnitTargetFlags.NONE,
                    FindOrder.ANY
                );

                for (const enemy of enemies) {
                    ApplyDamage({
                        victim: enemy,
                        attacker: projectile.getSource(),
                        damage: damageAoe,
                        damage_type: DamageTypes.MAGICAL
                    });

                    ModifierPuckExMobility.apply(enemy, projectile.getSource(), this, {
                        duration: fearDuration
                        // max_slow_pct: fading_slow_pct
                    });
                }
                ScreenShake(projectile.getPosition(), 100, 300, 0.45, 1000, 0, true);
                createRadiusMarker(projectile.getSource(), projectile.getPosition(), radius, "public", 0.1);
                EmitSoundOn("Hero_Puck.EtherealJaunt", projectile.getSource());
                EmitSoundOnLocationWithCaster(projectile.getPosition(), "Hero_Puck.Waning_Rift", projectile.getSource());
                StopSoundOn("Hero_Puck.Illusory_Orb", projectile.getSource());
                this.PlayEffectsOnFinish(
                    projectile.getPosition(),
                    "particles/econ/items/puck/puck_alliance_set/puck_illusory_orb_explode_aproset.vpcf",
                    "particles/econ/items/abaddon/abaddon_alliance/abaddon_death_coil_alliance_explosion.vpcf"
                );

                this.projectile = undefined;
            }
        });

        const time = this.GetCastRange(Vector(0, 0, 0), undefined) / projectileSpeed;

        ModifierPuckExMobilityRecast.apply(this.caster, this.caster, this, {
            abilityLeft: PuckExMobility.name,
            abilityRight: PuckExMobilityRecast.name,
            duration: time
        });

        this.PlayEffectsOnCast();

        // 	LinkAbilityCooldowns(caster, 'puck_mobility', {
        // 		["0"] = {
        // 			ability = this,
        // 			level = 2,
        // 		}
        // 	})
    }
    // function puck_ex_mobility:OnUpgrade()
    // 	CustomAbilitiesLegacy:LinkUpgrades(this, "puck_ex_mobility_recast")
    // }
}

@registerAbility("puck_ex_mobility_recast")
class PuckExMobilityRecast extends CustomAbility {
    GetCastingCrawl() {
        return 0;
    }

    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_2;
    }

    OnSpellStart() {
        PuckExMobility.findOne(this.caster)?.Jump();
    }

    // function puck_ex_mobility_recast:OnUpgrade()
    // 	CustomAbilitiesLegacy:LinkUpgrades(this, "puck_ex_mobility")
    // }
}

@registerModifier("modifier_puck_ex_mobility_recast")
class ModifierPuckExMobilityRecast extends ModifierRecast {}

@registerModifier("modifier_puck_ex_mobility_fear")
class ModifierPuckExMobility extends CustomModifier {}
// if IsClient() then require("wrappers/modifiers") }
// Modifiers.Fear(modifier_puck_ex_mobility_fear)
