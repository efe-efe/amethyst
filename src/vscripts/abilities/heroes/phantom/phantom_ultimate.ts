import { registerAbility } from "../../../lib/dota_ts_adapter";
import { ModifierUpgradePhantomFastCoup } from "../../../modifiers/upgrades/modifier_favors";
import { precache, resource } from "../../../precache";
import { ProjectileBehavior } from "../../../projectiles";
import { areUnitsAllied, direction2D, getCursorPosition } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { ModifierPhantomStacks } from "./phantom_basic_attack";

const resources = precache({
    glaive: resource.fx("particles/phantom/phantom_ultimate.vpcf"),
    critImpact: resource.fx(
        "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_impact_dagger_arcana.vpcf"
    ),
    impact: resource.fx("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf"),
    cast: resource.fx("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf"),
    castPointTrail: resource.fx("particles/econ/items/monkey_king/arcana/water/mk_spring_arcana_water_channel_powertrails.vpcf"),
    castPointSwirl: resource.fx("particles/econ/items/wisp/wisp_relocate_channel_ti7.vpcf")
});

@registerAbility("phantom_ultimate")
class PhantomUltimate extends CustomAbility {
    particleId?: ParticleID;

    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_3;
    }

    GetPlaybackRateOverride() {
        return ModifierUpgradePhantomFastCoup.findOne(this.caster) ? 1.2 : 0.7;
    }

    GetCastingCrawl() {
        return 0;
    }

    GetCastPoint() {
        return ModifierUpgradePhantomFastCoup.findOne(this.caster) ? 0.3 : 1.0;
    }

    OnAbilityPhaseStart() {
        if (super.OnAbilityPhaseStart()) {
            this.PlayEffectsOnCastPoint();
            return true;
        }
        return false;
    }

    OnAbilityPhaseInterrupted() {
        super.OnAbilityPhaseInterrupted();
        this.StopEffectsOnCastPoint();
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = getCursorPosition(this.caster);
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);
        const damage = this.caster.GetAverageTrueAttackDamage(this.caster);

        const damageMultiplier = this.GetSpecialValueFor("damage_multiplier");
        const damageMultiplierPerStack = this.GetSpecialValueFor("damage_multiplier_per_stack");
        const stacks = ModifierPhantomStacks.findOne(this.caster)?.GetStackCount() ?? 0;

        this.ProjectileAttack({
            source: this.caster,
            startRadius: this.GetSpecialValueFor("start_hitbox"),
            endRadius: this.GetSpecialValueFor("end_hitbox"),
            effectName: resources.glaive.path,
            spawnOrigin: origin.__add(Vector(projectileDirection.x * 30, projectileDirection.y * 30, 96)),
            velocity: projectileDirection.__mul(projectileSpeed),
            groundOffset: 0,
            wallBehavior: ProjectileBehavior.NOTHING,
            //isSlowable: false,
            isReflectable: false,
            unitTest: (unit, projectile) => !areUnitsAllied(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                const finalDamage = damage * (damageMultiplier + stacks * damageMultiplierPerStack);

                ApplyDamage({
                    victim: unit,
                    attacker: projectile.getSource(),
                    damage: finalDamage,
                    damage_type: DamageTypes.PHYSICAL
                });

                this.PlayEffectsOnCast();
                FindClearSpaceForUnit(projectile.getSource(), unit.GetAbsOrigin(), true);
                this.PlayEffectsOnImpact(unit);
            },
            onFinish: () => {
                this.PlayEffectsOnFinish();
            }
        });

        this.caster.RemoveModifierByName(ModifierPhantomStacks.name);
        this.caster.StartGestureWithPlaybackRate(GameActivity.DOTA_ATTACK_EVENT, 3.0);
        this.StopEffectsOnCastPoint();
    }

    PlayEffectsOnFinish() {
        EmitSoundOn("Hero_PhantomAssassin.Strike.End", this.caster);
        EmitSoundOn("Hero_PhantomAssassin.Arcana_Layer", this.caster);
    }

    PlayEffectsOnImpact(target: CDOTA_BaseNPC) {
        EmitSoundOn("Hero_PhantomAssassin.Spatter", target);
        EmitSoundOn("Hero_PhantomAssassin.CoupDeGrace", target);
        let particleId = ParticleManager.CreateParticle(resources.critImpact.path, ParticleAttachment.ABSORIGIN_FOLLOW, target);
        ParticleManager.SetParticleControl(particleId, 1, target.GetAbsOrigin());
        ParticleManager.SetParticleControlForward(particleId, 1, target.GetForwardVector());
        ParticleManager.ReleaseParticleIndex(particleId);

        particleId = ParticleManager.CreateParticle(resources.impact.path, ParticleAttachment.WORLDORIGIN, undefined);
        ParticleManager.SetParticleControl(particleId, 0, this.caster.GetAbsOrigin());
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsOnCast() {
        const particleId = ParticleManager.CreateParticle(resources.cast.path, ParticleAttachment.WORLDORIGIN, undefined);
        ParticleManager.SetParticleControl(particleId, 0, this.caster.GetAbsOrigin());
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsOnCastPoint() {
        EmitGlobalSound("phantom_assassin_phass_ability_coupdegrace_03");
        const particleId = ParticleManager.CreateParticle(resources.castPointTrail.path, ParticleAttachment.ABSORIGIN_FOLLOW, this.caster);
        ParticleManager.ReleaseParticleIndex(particleId);

        this.particleId = ParticleManager.CreateParticle(resources.castPointSwirl.path, ParticleAttachment.ABSORIGIN_FOLLOW, this.caster);
        ParticleManager.SetParticleControlEnt(
            this.particleId,
            1,
            this.caster,
            ParticleAttachment.ABSORIGIN_FOLLOW,
            AttachLocation.hitloc,
            this.caster.GetAbsOrigin(),
            false
        );
    }

    StopEffectsOnCastPoint() {
        if (this.particleId) {
            ParticleManager.DestroyParticle(this.particleId, false);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }
}
