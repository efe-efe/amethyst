import { CustomAbility } from "../../../abilities/framework/custom_ability";
import { CustomModifier } from "../../../abilities/framework/custom_modifier";
import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { DisplacementParams, ModifierDisplacement, OnCollisionEvent } from "../../../modifiers/modifier_displacement";
import { ProjectileBehavior, ProjectileHandler } from "../../../projectiles";
import { direction2D, fullyFaceTowards } from "../../../util";

@registerAbility("flying_skull_dash")
class FlyingSkullDash extends CustomAbility {
    projectile?: ProjectileHandler;

    GetAnimation() {
        return GameActivity.DOTA_ATTACK;
    }

    GetPlaybackRateOverride() {
        return 0.5;
    }

    GetIntrinsicModifierName() {
        return "modifier_flying_skull_dash_intrinsic";
    }

    GetCastingCrawl() {
        return 0;
    }

    OnAbilityPhaseStart() {
        if (super.OnAbilityPhaseStart()) {
            const origin = this.caster.GetAbsOrigin();
            EFX(
                "particles/econ/items/silencer/silencer_ti10_immortal_shield/silencer_ti10_immortal_curse_cast.vpcf",
                ParticleAttachment.ABSORIGIN,
                this.caster,
                {
                    cp0: origin.__add(Vector(0, 0, 128)),
                    release: true
                }
            );
            return true;
        }
        return false;
    }

    OnSpellStart() {
        const point = this.GetCursorPosition();
        const origin = this.caster.GetOrigin();
        const direction = direction2D(origin, point);
        const projectileSpeed = RandomInt(1500, 2000);
        const distance = this.GetSpecialValueFor("dash_range");
        const speed = 1500;
        fullyFaceTowards(this.caster, direction);

        this.projectile = this.ProjectileAttack({
            source: this.caster,
            effectName: "particles/vengeful/vengeful_ex_second_attack.vpcf",
            distance: distance,
            startRadius: 1,
            spawnOrigin: origin.__add(Vector(0, 0, 96)),
            velocity: direction.__mul(projectileSpeed),
            groundOffset: 0,
            wallBehavior: ProjectileBehavior.NOTHING,
            unitTest: (unit, projectile) =>
                unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit)
        });

        ModifierFlyingSkullDashDisplacement.apply(this.caster, this.caster, this, {
            x: direction.x,
            y: direction.y,
            distance: distance,
            speed: speed * RandomFloat(1.0, 1.2),
            peak: 2,
            radius: 100,
            teamFilter: UnitTargetTeam.ENEMY
        });
    }

    OnUpgrade() {
        if (IsServer()) {
            EFX("particles/flying_skull/burn_main.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
                release: true
            });
        }
    }
}

@registerModifier({ customNameForI18n: "modifier_flying_skull_dash_intrinsic" })
class ModifierFlyingSkullDashIntrinsic extends CustomModifier<FlyingSkullDash> {
    DeclareFunctions() {
        return [ModifierFunction.ON_DEATH];
    }

    OnDeath(event: ModifierInstanceEvent) {
        if (IsServer() && event.unit == this.parent) {
            this.ability.projectile?.scheduleDestroy();
        }
    }
}

@registerModifier({ customNameForI18n: "modifier_flying_skull_dash_displacement" })
class ModifierFlyingSkullDashDisplacement extends ModifierDisplacement {
    originalScale!: number;

    OnCreated(params: DisplacementParams) {
        super.OnCreated(params);

        if (IsServer()) {
            this.originalScale = this.parent.GetModelScale();
            this.parent.SetModelScale(this.originalScale / 2);
        }
    }

    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            this.parent.SetModelScale(this.originalScale);
            this.PlayEffectsOnFinish();
        }
    }

    PlayEffectsOnFinish() {
        const position = this.caster.GetAbsOrigin();
        EmitSoundOnLocationWithCaster(position, "Hero_StormSpirit.ProjectileImpact", this.caster);
        EmitSoundOnLocationWithCaster(position, "Hero_StormSpirit.StaticRemnantExplode", this.caster);

        EFX("particles/units/heroes/hero_vengeful/vengeful_magic_missle_end.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: position,
            cp3: position,
            release: true
        });
    }

    OnCollide(event: OnCollisionEvent) {
        if (IsServer() && event.collision == "unit") {
            for (const unit of event.units) {
                if (!ModifierFlyingSkullDash.findOne(unit)) {
                    ModifierFlyingSkullDash.apply(unit, this.caster, this.ability, { duration: 1.0 });
                    ApplyDamage({
                        victim: unit,
                        attacker: this.parent,
                        damage: this.parent.GetAverageTrueAttackDamage(this.parent),
                        damage_type: DamageTypes.PURE
                    });
                }
            }
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_RUN;
    }

    GetOverrideAnimationRate() {
        return 1.5;
    }
}

@registerModifier({ customNameForI18n: "modifier_flying_skull_dash" })
class ModifierFlyingSkullDash extends CustomModifier {
    particleId?: ParticleID;

    GetAttributes() {
        return ModifierAttribute.MULTIPLE;
    }

    OnCreated() {
        if (IsServer()) {
            this.particleId = ParticleManager.CreateParticle(
                "particles/econ/items/spectre/spectre_transversant_soul/spectre_transversant_spectral_dagger_path_owner.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent
            );
        }
    }

    OnDestroy() {
        if (IsServer() && this.particleId) {
            ParticleManager.DestroyParticle(this.particleId, true);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }

    GetEffectName() {
        return "particles/generic_gameplay/rune_haste.vpcf";
    }

    DeclareFunctions() {
        return [ModifierFunction.MOVESPEED_BONUS_PERCENTAGE];
    }

    GetModifierMoveSpeedBonus_Percentage() {
        return this.Value("fading_slow_pct");
    }

    GetStatusEffectName() {
        return "particles/status_fx/status_effect_terrorblade_reflection.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.ABSORIGIN_FOLLOW;
    }
}
