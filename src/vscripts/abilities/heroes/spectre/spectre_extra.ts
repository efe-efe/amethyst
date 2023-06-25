import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierRecast } from "../../../modifiers/modifier_recast";
import { clamp, direction2D, getCursorPosition, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";

@registerAbility("spectre_extra")
class SpectreExtra extends CustomAbility {
    OnSpellStart() {
        SpectreExtraRecast.findOne(this.caster)?.ResetDamage();
        ModifierSpectreExtra.apply(this.caster, this.caster, this, { duration: this.GetSpecialValueFor("duration") });
    }
    // function spectre_extra:OnUpgrade()
    // 	CustomAbilitiesLegacy:LinkUpgrades(this, "spectre_extra_recast")
    // }
}

@registerAbility("spectre_extra_recast")
class SpectreExtraRecast extends CustomAbility {
    extraDamage = 0;

    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_1;
    }

    GetPlaybackRateOverride() {
        return 1.0;
    }

    GetCastingCrawl() {
        return 80;
    }

    GetIgnoreActivationCycle() {
        return true;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = getCursorPosition(this.caster);
        const spectreExtra = SpectreExtra.findOne(this.caster);
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);
        const damage = spectreExtra?.GetSpecialValueFor("recast_damage") ?? 0;
        const maxDamage = spectreExtra?.GetSpecialValueFor("max_damage") ?? 0;
        const finalDamage = clamp(damage + this.extraDamage, maxDamage, 0);

        this.ProjectileAttack({
            source: this.caster,
            effectName: "particles/spectre/spectre_extra_recast.vpcf",
            spawnOrigin: origin.__add(Vector(projectileDirection.x * 45, projectileDirection.y * 45, 96)),
            velocity: projectileDirection.__mul(projectileSpeed),
            groundOffset: 0,
            unitTest: (unit, projectile) =>
                unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                ApplyDamage({
                    victim: unit,
                    attacker: projectile.getSource(),
                    damage: finalDamage,
                    damage_type: DamageTypes.MAGICAL
                });
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(projectile.getPosition());
            }
        });
        EmitSoundOn("Hero_Nevermore.Raze_Flames", this.caster);
    }

    PlayEffectsOnFinish(position: Vector) {
        EFX("particles/units/heroes/hero_arc_warden/arc_warden_wraith_cast.vpcf", ParticleAttachment.WORLDORIGIN, this.caster, {
            cp0: position,
            cp1: position,
            cp2: position,
            release: true
        });
    }

    AddDamage(damage: number) {
        this.extraDamage = this.extraDamage + damage;
    }

    ResetDamage() {
        this.extraDamage = 0;
    }
    // function spectre_extra_recast:OnUpgrade()
    // 	CustomAbilitiesLegacy:LinkUpgrades(this, "spectre_extra")
    // }
}

@registerModifier({ customNameForI18n: "modifier_spectre_extra" })
class ModifierSpectreExtra extends CustomModifier {
    particleIdMain?: ParticleID;
    particleIdSecond?: ParticleID;

    IsHidden() {
        return false;
    }

    IsDebuff() {
        return false;
    }

    IsPurgable() {
        return false;
    }

    IsAura() {
        return true;
    }

    GetModifierAura() {
        return ModifierSpectreDebuff.name;
    }

    GetAuraRadius() {
        return this.Value("radius");
    }

    GetAuraDuration() {
        return 0.0;
    }

    GetAuraSearchTeam() {
        return UnitTargetTeam.BOTH;
    }

    GetAuraEntityReject(unit: CDOTA_BaseNPC) {
        return CustomEntitiesLegacy.Allies(this.caster, unit);
    }

    GetAuraSearchType() {
        return UnitTargetType.HERO + UnitTargetType.BASIC;
    }

    OnCreated() {
        if (IsServer()) {
            this.PlayEffectsOnCreated();
        }
    }

    OnDestroy() {
        if (IsServer()) {
            this.ability.StartCooldown(this.ability.GetCooldown(this.ability.GetLevel()));
            this.StopEffects();
            if (this.ability.GetLevel() >= 2) {
                ModifierSpectreRecast.apply(this.parent, this.parent, this.ability, {
                    abilityLeft: SpectreExtra.name,
                    abilityRight: SpectreExtraRecast.name,
                    duration: 5.0
                });
            }
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.MOVESPEED_BONUS_PERCENTAGE];
    }

    GetModifierMoveSpeedBonus_Percentage() {
        return this.Value("speed_buff_pct");
    }

    PlayEffectsOnCreated() {
        EmitSoundOn("Hero_Spectre.Haunt", this.parent);
        this.particleIdMain = ParticleManager.CreateParticle(
            "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_blade_fury_abyssal.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.parent
        );
        ParticleManager.SetParticleControl(this.particleIdMain, 2, this.parent.GetAbsOrigin());

        this.particleIdSecond = ParticleManager.CreateParticle(
            "particles/econ/items/silencer/silencer_ti6/silencer_last_word_status_ti6_ring_mist.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.parent
        );
        ParticleManager.SetParticleControl(this.particleIdSecond, 3, this.parent.GetAbsOrigin());
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

    // function modifier_spectre_extra:GetStatusLabel() return "Darkness" }
    // function modifier_spectre_extra:GetStatusPriority() return 1 }
    // function modifier_spectre_extra:GetStatusStyle() return "Darkness" }
}
// if (IsClient()){ require("wrappers/modifiers") }
// Modifiers.Status(modifier_spectre_extra)

@registerModifier({ customNameForI18n: "modifier_spectre_extra_recast" })
class ModifierSpectreRecast extends ModifierRecast {}
// if (IsClient()){ require("wrappers/modifiers") }
// Modifiers.Recast(modifier_spectre_extra_recast)

@registerModifier({ customNameForI18n: "modifier_spectre_debuff" })
class ModifierSpectreDebuff extends CustomModifier {
    damageDone = 0;

    OnCreated() {
        if (IsServer()) {
            this.damageDone = 0;
            this.StartIntervalThink(this.Value("think_interval"));
        }
    }

    OnIntervalThink() {
        if (!isObstacle(this.parent) && !isGem(this.parent)) {
            this.damageDone = this.damageDone + this.Value("damage_per_second");
        }

        ApplyDamage({
            victim: this.parent,
            attacker: this.caster,
            damage: this.Value("damage_per_second"),
            damage_type: DamageTypes.PURE
        });
        this.PlayEffects();
    }

    PlayEffects() {
        EmitSoundOn("Hero_Spectre.Desolate", this.caster);
        EmitSoundOn("Hero_Spectre.Attack", this.parent);
        EFX("particles/spectre/spectre_extra_impact.vpcf", ParticleAttachment.ABSORIGIN, this.parent, {
            release: true
        });
    }

    OnDestroy() {
        if (IsServer()) {
            this.caster.Heal(this.damageDone, this.ability);
            SpectreExtraRecast.findOne(this.caster)?.AddDamage(this.damageDone);
        }
    }
}
