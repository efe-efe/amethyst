import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierBanish } from "../../../modifiers/modifier_banish";
import { ModifierRecast } from "../../../modifiers/modifier_recast";
import { ModifierThinker, ModifierThinkerParams } from "../../../modifiers/modifier_thinker";
import { ProjectileBehavior } from "../../../projectiles";
import { clampPosition, direction2D, giveManaAndEnergyPercent, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";

@registerAbility("spectre_special_attack")
class SpectreSpecialAttack extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_1;
    }

    GetPlaybackRateOverride() {
        return 0.7;
    }

    GetCastingCrawl() {
        return 20;
    }

    OnSpellStart() {
        const damage = this.GetSpecialValueFor("ability_damage");
        const origin = this.caster.GetAbsOrigin();
        const point = CustomAbilitiesLegacy.GetCursorPosition(this);
        const projectileName = "particles/spectre/spectre_special_attack.vpcf";
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const hitbox = this.GetSpecialValueFor("hitbox");
        const pathDuration = this.GetSpecialValueFor("path_duration");
        const radius = this.GetSpecialValueFor("radius");
        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        const debuffDuration = this.GetSpecialValueFor("debuff_duration");
        const projectileDirection = direction2D(origin, point);
        const projectileDistance = this.GetCastRange(Vector(0, 0, 0), undefined);
        const projectileVelocity = projectileDirection.__mul(projectileSpeed);

        this.ProjectileAttack({
            source: this.caster,
            effectName: projectileName,
            spawnOrigin: origin,
            velocity: projectileVelocity,
            groundOffset: 0,
            unitBehavior: ProjectileBehavior.NOTHING,
            wallBehavior: ProjectileBehavior.NOTHING,
            groundLock: true,
            isDestructible: false,
            // bIsReflectable = false,
            unitTest: (unit, projectile) =>
                unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                ApplyDamage({
                    victim: unit,
                    attacker: this.caster,
                    damage: damage,
                    damage_type: DamageTypes.MAGICAL
                });
                ModifierSpectreSpecialAttackDebuff.apply(unit, projectile.getSource(), this, { duration: debuffDuration });
                if (projectile.getSource() == this.caster) {
                    if (!isObstacle(unit) && !isGem(unit)) {
                        giveManaAndEnergyPercent(this.caster, manaGainPct, true);
                    }
                }
                this.PlayEffectsOnImpact(unit);
            },
            afterUpdate: projectile => {
                ModifierSpectreSpecialAttackThinker.createThinker(this.caster, this, projectile.getPosition(), {
                    duration: pathDuration,
                    radius: radius,
                    visibility: "collapse"
                });
            }
        });

        // Vanilla projectile for particle purposes
        const info = {
            Source: this.caster,
            Ability: this,
            vSpawnOrigin: Vector(origin.x, origin.y, origin.z + 128),
            bDeleteOnHit: false,
            iUnitTargetTeam: UnitTargetTeam.ENEMY,
            iUnitTargetFlags: UnitTargetFlags.NONE,
            iUnitTargetType: UnitTargetType.HERO + UnitTargetType.BASIC,
            EffectName: projectileName,
            fDistance: projectileDistance,
            fStartRadius: hitbox,
            fEndRadius: hitbox,
            vVelocity: projectileVelocity,
            bHasFrontalCone: false,
            bReplaceExisting: false,
            fExpireTime: GameRules.GetGameTime() + 8.0,
            bProvidesVision: true,
            iVisionTeamNumber: this.caster.GetTeamNumber(),
            iVisionRadius: hitbox
        };

        ProjectileManager.CreateLinearProjectile(info);
        EmitSoundOn("Hero_Spectre.DaggerCast", this.caster);
        // 	LinkAbilityCooldowns(this.caster, 'spectre_ex_special_attack')
    }

    PlayEffectsOnImpact(target: CDOTA_BaseNPC) {
        EmitSoundOn("Hero_Spectre.DaggerImpact", target);
        const particleId = ParticleManager.CreateParticle(
            "particles/econ/items/spectre/spectre_transversant_soul/spectre_ti7_crimson_spectral_dagger_path_owner_impact.vpcf",
            ParticleAttachment.ABSORIGIN,
            target
        );
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerAbility("spectre_ex_special_attack")
class SpectreExSpecialAttack extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_FLAIL;
    }

    GetPlaybackRateOverride() {
        return 1.0;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const point = clampPosition(origin, cursor, { maxRange: this.GetCastRange(Vector(0, 0, 0), undefined) });
        EmitSoundOn("Hero_Spectre.Haunt", this.caster);

        EFX("particles/spectre/spectre_illusion_warp.vpcf", ParticleAttachment.CUSTOMORIGIN, this.caster, {
            cp0: {
                ent: this.caster,
                point: "attach_hitloc"
            },
            cp1: point.__add(Vector(0, 0, 128)),
            cp2: {
                ent: this.caster,
                point: "attach_hitloc"
            },
            release: true
        });

        ModifierSpectreExSpecialAttackThinker.createThinker(this.caster, this, point, {
            radius: this.GetSpecialValueFor("radius"),
            delayTime: this.GetSpecialValueFor("delay_time")
        });
        // 	LinkAbilityCooldowns(this.caster, 'spectre_special_attack')
    }
    // function spectre_ex_special_attack:OnUpgrade()
    // 	CustomAbilitiesLegacy:LinkUpgrades(this, "spectre_ex_special_attack_recast")
    // 	const related = this.caster.FindAbilityByName('spectre_ex_special_attack_recast')
    // 	if (this.GetLevel() > related:GetLevel()){
    // 		related:UpgradeAbility(true)
    // 	}
    // }
}

@registerAbility("spectre_ex_special_attack_recast")
class SpectreExSpecialAttackRecast extends CustomAbility {
    targets: CDOTA_BaseNPC[] = [];

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const point = clampPosition(origin, cursor, { maxRange: this.GetCastRange(Vector(0, 0, 0), undefined) });

        for (const target of this.targets) {
            target.RemoveModifierByName(ModifierSpectreExSpecialAttackBanish.name);
            FindClearSpaceForUnit(target, point, true);
        }

        EFX("particles/spectre/spectre_illusion_warp.vpcf", ParticleAttachment.CUSTOMORIGIN, this.caster, {
            cp0: {
                ent: this.caster,
                point: "attach_hitloc"
            },
            cp1: point.__add(Vector(0, 0, 128)),
            cp2: {
                ent: this.caster,
                point: "attach_hitloc"
            },
            release: true
        });
        EmitSoundOnLocationWithCaster(point, "Hero_Spectre.Reality", this.caster);

        this.ClearTargets();
    }

    AddTarget(target: CDOTA_BaseNPC) {
        this.targets.push(target);
    }

    ClearTargets() {
        this.targets = [];
    }

    // OnUpgrade(){
    // 	CustomAbilitiesLegacy:LinkUpgrades(this, "spectre_ex_special_attack")
    // 	const related = this.caster.FindAbilityByName('spectre_ex_special_attack')
    // 	if (this.GetLevel() > related:GetLevel()){
    // 		related:UpgradeAbility(true)
    // 	}
    // }
}

@registerModifier({ customNameForI18n: "modifier_spectre_special_attack_thinker" })
class ModifierSpectreSpecialAttackThinker extends ModifierThinker {
    particleIdMain?: ParticleID;
    particleIdSecond?: ParticleID;

    IsAura() {
        return true;
    }

    GetModifierAura() {
        return ModifierSpectreSpecialAttackBuff.name;
    }

    GetAuraRadius() {
        return this.radius;
    }

    GetAuraDuration() {
        return this.Value("buff_duration");
    }

    GetAuraSearchTeam() {
        return UnitTargetTeam.BOTH;
    }

    GetAuraEntityReject(unit: CDOTA_BaseNPC) {
        return !CustomEntitiesLegacy.Allies(this.caster, unit);
    }

    GetAuraSearchType() {
        return UnitTargetType.HERO + UnitTargetType.BASIC;
    }

    OnCreated(params: ModifierThinkerParams) {
        super.OnCreated(params);

        if (IsServer()) {
            this.PlayEffects();
        }
    }

    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            this.StopEffects();
            UTIL_Remove(this.parent);
        }
    }

    PlayEffects() {
        this.particleIdMain = ParticleManager.CreateParticle(
            "particles/econ/items/dazzle/dazzle_ti6/dazzle_ti6_shallow_grave_ground_steam.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(this.particleIdMain, 0, this.parent.GetAbsOrigin());
        ParticleManager.SetParticleControl(this.particleIdMain, 1, this.parent.GetAbsOrigin());

        this.particleIdSecond = ParticleManager.CreateParticle(
            "particles/econ/items/lifestealer/ls_ti9_immortal/ls_ti9_open_wounds_ground.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(this.particleIdSecond, 0, this.parent.GetAbsOrigin());
        ParticleManager.SetParticleControl(this.particleIdSecond, 5, this.parent.GetAbsOrigin());
    }

    StopEffects() {
        if (this.particleIdMain) {
            ParticleManager.DestroyParticle(this.particleIdMain, false);
            ParticleManager.ReleaseParticleIndex(this.particleIdMain);
        }
        if (this.particleIdSecond) {
            ParticleManager.DestroyParticle(this.particleIdSecond, false);
            ParticleManager.ReleaseParticleIndex(this.particleIdSecond);
        }
    }
}

@registerModifier({ customNameForI18n: "modifier_spectre_special_attack_debuff" })
export class ModifierSpectreSpecialAttackDebuff extends CustomModifier {
    OnCreated() {
        if (IsServer()) {
            this.StartIntervalThink(0.2);
        }
    }

    OnIntervalThink() {
        const origin = this.parent.GetAbsOrigin();
        ModifierSpectreSpecialAttackThinker.createThinker(this.caster, this.ability, origin, {
            duration: this.GetRemainingTime(),
            radius: this.Value("radius")
        });
        const particle_cast = "particles/econ/items/slark/slark_ti6_blade/slark_ti6_pounce_start_spiral.vpcf";
        const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined);
        ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin());
        ParticleManager.SetParticleControl(particleId, 3, this.parent.GetAbsOrigin());
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    GetEffectName() {
        return "particles/econ/items/spectre/spectre_transversant_soul/spectre_transversant_spectral_dagger_path_owner.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.ABSORIGIN_FOLLOW;
    }
}

@registerModifier({ customNameForI18n: "modifier_spectre_special_attack_buff" })
export class ModifierSpectreSpecialAttackBuff extends CustomModifier {
    particleId?: ParticleID;

    IsDebuff() {
        return false;
    }

    IsHidden() {
        return false;
    }

    IsPurgable() {
        return false;
    }

    OnCreated() {
        if (IsServer()) {
            this.PlayEffects();
        }
    }

    OnDestroy() {
        if (IsServer()) {
            EFX("particles/units/heroes/hero_spectre/spectre_death.vpcf", ParticleAttachment.WORLDORIGIN, this.parent, {
                cp0: this.parent.GetAbsOrigin(),
                cp3: this.parent.GetAbsOrigin(),
                release: true
            });
            this.StopEffects();
        }
    }

    CheckState() {
        return {
            [ModifierState.INVISIBLE]: this.GivesInvisibility(),
            [ModifierState.NO_UNIT_COLLISION]: true,
            [ModifierState.FLYING_FOR_PATHING_PURPOSES_ONLY]: true
        };
    }

    GivesInvisibility() {
        return this.ability.GetLevel() >= 2 && !this.parent.FindModifierByName("modifier_casting") && this.parent == this.caster;
    }

    DeclareFunctions() {
        return [ModifierFunction.INVISIBILITY_LEVEL, ModifierFunction.MOVESPEED_BONUS_PERCENTAGE];
    }

    GetModifierInvisibilityLevel() {
        if (IsServer()) {
            if (this.ability.GetLevel() >= 2 && !this.parent.FindModifierByName("modifier_casting")) {
                return 2;
            }
        }

        return 0;
    }

    GetModifierMoveSpeedBonus_Percentage() {
        return this.Value("speed_buff_pct");
    }

    PlayEffects() {
        this.particleId = ParticleManager.CreateParticle(
            "particles/econ/items/lifestealer/lifestealer_immortal_backbone/lifestealer_immortal_backbone_rage_swirl.vpcf",
            ParticleAttachment.CUSTOMORIGIN,
            this.parent
        );
        ParticleManager.SetParticleControlEnt(
            this.particleId,
            2,
            this.parent,
            ParticleAttachment.POINT_FOLLOW,
            "attach_hitloc",
            this.parent.GetAbsOrigin(),
            true
        );
    }

    StopEffects() {
        if (this.particleId) {
            ParticleManager.DestroyParticle(this.particleId, false);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }
}

@registerModifier({ customNameForI18n: "modifier_spectre_ex_special_attack_thinker" })
class ModifierSpectreExSpecialAttackThinker extends ModifierThinker {
    particleId?: ParticleID;
    origin!: Vector;

    OnCreated(params: ModifierThinkerParams) {
        super.OnCreated(params);

        if (IsServer()) {
            this.origin = this.parent.GetAbsOrigin();
            this.particleId = ParticleManager.CreateParticle(
                "particles/spectre/spectre_illusion_warp_ground.vpcf",
                ParticleAttachment.WORLDORIGIN,
                undefined
            );
            ParticleManager.SetParticleControl(this.particleId, 0, this.parent.GetAbsOrigin());
            ParticleManager.SetParticleControl(this.particleId, 1, this.parent.GetAbsOrigin());
            ParticleManager.SetParticleControl(this.particleId, 2, this.parent.GetAbsOrigin());
            ParticleManager.SetParticleControl(this.particleId, 3, Vector(this.radius, 0, 0));
        }
    }

    OnReady() {
        EmitSoundOn("Hero_Spectre.HauntCast", this.parent);
        const spectreExBasicAttackRecast = SpectreExSpecialAttackRecast.findOne(this.caster);
        spectreExBasicAttackRecast?.ClearTargets();

        const enemies = CustomEntitiesLegacy.FindUnitsInRadius(
            this.caster,
            this.origin,
            this.radius,
            UnitTargetTeam.ENEMY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.NONE,
            FindOrder.ANY
        );

        for (const enemy of enemies) {
            ModifierSpectreExSpecialAttackBanish.apply(enemy, this.caster, this.ability, { duration: this.Value("banish_duration") });
            spectreExBasicAttackRecast?.AddTarget(enemy);

            const particleId = ParticleManager.CreateParticle(
                "particles/units/heroes/hero_spectre/spectre_death.vpcf",
                ParticleAttachment.WORLDORIGIN,
                undefined
            );
            ParticleManager.SetParticleControl(particleId, 0, enemy.GetAbsOrigin());
            ParticleManager.SetParticleControl(particleId, 3, enemy.GetAbsOrigin());
            ParticleManager.ReleaseParticleIndex(particleId);
        }

        if (enemies.length > 0) {
            ModifierSpectreExSpecialAttackRecast.apply(this.caster, this.caster, this.ability, {
                duration: this.Value("banish_duration"),
                abilityLeft: SpectreExSpecialAttack.name,
                abilityRight: SpectreExSpecialAttackRecast.name
            });
        }
        this.Destroy();
    }

    OnDestroy() {
        if (IsServer()) {
            UTIL_Remove(this.parent);

            if (this.particleId) {
                ParticleManager.DestroyParticle(this.particleId, false);
                ParticleManager.ReleaseParticleIndex(this.particleId);
            }

            EFX("particles/spectre/spectre_illusion_warp_radius.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
                cp0: this.origin,
                cp1: this.origin,
                cp2: Vector(this.radius),
                release: true
            });
        }
    }
}

@registerModifier({ customNameForI18n: "modifier_spectre_ex_special_attack_recast" })
class ModifierSpectreExSpecialAttackRecast extends ModifierRecast {}
// if (IsClient()){ require("wrappers/modifiers") }
// Modifiers.Recast(modifier_spectre_ex_special_attack_recast)

@registerModifier({ customNameForI18n: "modifier_spectre_ex_special_attack_banish" })
class ModifierSpectreExSpecialAttackBanish extends ModifierBanish {
    CheckState() {
        return {
            ...super.CheckState(),
            [ModifierState.COMMAND_RESTRICTED]: true
        };
    }

    OnDestroy() {
        super.OnDestroy();
        if (IsServer()) {
            const particleId = ParticleManager.CreateParticle(
                "particles/units/heroes/hero_spectre/spectre_death.vpcf",
                ParticleAttachment.WORLDORIGIN,
                undefined
            );
            ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin());
            ParticleManager.SetParticleControl(particleId, 3, this.parent.GetAbsOrigin());
            ParticleManager.ReleaseParticleIndex(particleId);
            this.parent.AddNewModifier(this.caster, this.ability, "modifier_generic_fading_slow", {
                duration: this.Value("fading_slow_duration"),
                max_slow_pct: this.Value("fading_slow_pct")
            });
        }
    }
}
