import { areUnitsAllied } from "../../../util";
import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierFadingSlow } from "../../../modifiers/modifier_fading_slow";
import {
    attackWithBaseDamage,
    clampPosition,
    direction2D,
    getCursorPosition,
    giveManaAndEnergyPercent,
    isGem,
    isObstacle,
    meeleEFX,
    replenishEFX
} from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";
import { precache, resource } from "../../../precache";
import { defineAbility } from "../../framework/ability_definition";

const resources = precache({
    dagger: resource.fx("particles/phantom/phantom_special_attack.vpcf"),
    daggerImpact: resource.fx("particles/phantom/phantom_special_attack_explosion.vpcf"),
    attackImpact: resource.fx("particles/phantom/phantom_basic_attack.vpcf"),
    charged: resource.fx("particles/econ/items/antimage/antimage_weapon_godeater/antimage_godeater_bracer_ambient.vpcf"),
    invisPoof: resource.fx("particles/econ/events/ti5/blink_dagger_end_sparkles_end_lvl2_ti5.vpcf"),
    bleed: resource.fx("particles/econ/items/bloodseeker/bloodseeker_ti7/bloodseeker_ti7_thirst_owner.vpcf"),
    bleedRibbon: resource.fx("particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodbath_eztzhok_ribbon.vpcf"),
    bleedSplash: resource.fx("particles/econ/items/dazzle/dazzle_darkclaw/dazzle_darkclaw_poison_touch_blood.vpcf"),
    yellowSparks: resource.fx("particles/econ/courier/courier_axolotl_ambient/courier_axolotl_ambient_lvl4_trail_steam.vpcf")
});

@registerAbility("phantom_basic_attack")
export class PhantomBasicAttack extends CustomAbility {
    GetCastPoint() {
        if (IsServer()) {
            return this.caster.GetAttackAnimationPoint();
        }
        return 0;
    }

    GetCooldown(level: number) {
        if (IsServer()) {
            const attacksPerSecond = this.caster.GetAttacksPerSecond();
            const attackSpeed = 1 / attacksPerSecond;
            return super.GetCooldown(level) + attackSpeed;
        }
        return 0;
    }

    GetAnimation() {
        return GameActivity.DOTA_SPAWN;
    }

    GetPlaybackRateOverride() {
        return 1.7;
    }

    GetCastingCrawl() {
        return this.GetSpecialValueFor("cast_point_speed_pct");
    }

    GetFadeGestureOnCast() {
        return false;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        //TODO: @Refactor Refactor the cursor
        const cursor = getCursorPosition(this.caster);
        const castRange = this.GetCastRange(Vector(0, 0, 0), undefined);
        const point = clampPosition(origin, cursor, {
            maxRange: castRange,
            minRange: castRange
        });
        //TODO: @Refactor Handle the extra radius
        const meeleExtraRadius = 0; //CustomEntitiesLegacy:GetMeeleExtraRadius(caster)

        const radius = this.GetSpecialValueFor("radius") + meeleExtraRadius;
        const cooldownReduction = this.GetSpecialValueFor("cooldown_reduction");
        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        const direction = direction2D(origin, point);

        meeleEFX(this.caster, direction, radius, Vector(43, 100, 125));

        this.MeeleAttack({
            direction,
            origin,
            radius,
            maxTargets: 1,
            attackType: "basic",
            effect: (target: CDOTA_BaseNPC) => {
                attackWithBaseDamage({ source: this.caster, target: target, ability: this });

                if (!isObstacle(target)) {
                    if (!isGem(target)) {
                        giveManaAndEnergyPercent(this.caster, manaGainPct, true);
                    }

                    ModifierPhantomStacks.apply(this.caster, this.caster, this, {});
                    this.ReduceCooldown("phantom_second_attack", cooldownReduction);
                }
                this.PlayEffectsOnImpact(target);
            }
        });

        this.PlayEffectsOnCast();
    }

    ReduceCooldown(abilityName: string, cooldownReduction: number) {
        const ability = this.caster.FindAbilityByName(abilityName);

        if (ability) {
            const abilityCooldown = ability.GetCooldownTimeRemaining();
            const newCooldown = abilityCooldown - cooldownReduction;

            if (newCooldown < 0) {
                ability.EndCooldown();
            } else {
                ability.EndCooldown();
                ability.StartCooldown(newCooldown);
            }
        }
    }

    PlayEffectsOnImpact(target: CDOTA_BaseNPC) {
        EFX(resources.attackImpact.path, ParticleAttachment.ABSORIGIN, target, {
            release: true
        });
        EmitSoundOn("Hero_PhantomAssassin.Attack", target);
    }

    PlayEffectsOnCast() {
        EmitSoundOn("Hero_PhantomAssassin.PreAttack", this.caster);
    }
}

@registerModifier("modifier_phantom_strike_stack")
export class ModifierPhantomStacks extends CustomModifier<PhantomBasicAttack> {
    particleIds: ParticleID[] = [];

    IsHidden() {
        return false;
    }

    IsDebuff() {
        return false;
    }

    IsPurgable() {
        return true;
    }

    OnCreated() {
        if (IsServer()) {
            this.SetStackCount(1);
        }
    }

    OnRefresh() {
        const maxStacks = this.Value("max_stacks");

        if (IsServer() && this.GetStackCount() < maxStacks) {
            this.IncrementStackCount();

            if (this.GetStackCount() == maxStacks) {
                this.PlayEffectsCharged();
            }
        }
    }

    OnDestroy() {
        if (IsServer()) {
            this.StopEffects();
        }
    }

    GetTexture() {
        return "phantom_basic_attack";
    }

    PlayEffectsCharged() {
        replenishEFX(this.parent);
        const origin = this.parent.GetAbsOrigin();

        for (let i = 0; i < 5; i++) {
            const particleId = ParticleManager.CreateParticle(resources.charged.path, ParticleAttachment.CUSTOMORIGIN, this.caster);
            ParticleManager.SetParticleControlEnt(
                particleId,
                0,
                this.caster,
                ParticleAttachment.POINT_FOLLOW,
                "attach_attack1",
                origin,
                true
            );
            ParticleManager.SetParticleControlEnt(
                particleId,
                1,
                this.caster,
                ParticleAttachment.POINT_FOLLOW,
                "attach_attack1",
                origin,
                true
            );
            this.particleIds.push(particleId);
        }
    }

    StopEffects() {
        for (const particleId of this.particleIds) {
            ParticleManager.DestroyParticle(particleId, false);
            ParticleManager.ReleaseParticleIndex(particleId);
        }
    }
}

@registerAbility("phantom_ex_basic_attack")
export class PhantomExBasicAttack extends CustomAbility {
    OnSpellStart() {
        const duration = this.GetSpecialValueFor("duration");
        ModifierPhantomExBasicAttack.apply(this.caster, this.caster, this, { duration: duration });
        this.PlayEffects();
    }

    PlayEffects() {
        EmitSoundOn("Hero_PhantomAssassin.Blur", this.caster);
        const particleId = ParticleManager.CreateParticle(resources.invisPoof.path, ParticleAttachment.POINT, this.caster);
        ParticleManager.SetParticleControl(particleId, 3, this.caster.GetOrigin());
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    // function phantom_ex_basic_attack:OnUpgrade()
    // 	CustomAbilitiesLegacy:LinkUpgrades(this, "phantom_basic_attack_related")
    // }
}

@registerAbility("phantom_basic_attack_related")
class PhantomBasicAttackRelated extends CustomAbility {
    GetCastPoint() {
        if (IsServer()) {
            return this.caster.GetAttackAnimationPoint();
        }

        return 0;
    }

    GetCooldown(level: number) {
        if (IsServer()) {
            const attacksPerSecond = this.caster.GetAttacksPerSecond();
            const attackSpeed = 1 / attacksPerSecond;
            return super.GetCooldown(level) + attackSpeed;
        }

        return 0;
    }

    GetAnimation() {
        return GameActivity.DOTA_TELEPORT_END;
    }

    GetPlaybackRateOverride() {
        return 2.0;
    }

    GetCastingCrawl() {
        return 80;
    }

    GetFadeGestureOnCast() {
        return false;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = getCursorPosition(this.caster);
        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);

        const phantomBasicAttack = PhantomBasicAttack.findOne(this.caster);
        const phantomExBasicAttack = PhantomExBasicAttack.findOne(this.caster);

        const bleedDuration = phantomExBasicAttack?.GetSpecialValueFor("bleed_duration") ?? 0;
        const fadingSlowPct = phantomExBasicAttack?.GetSpecialValueFor("fading_slow_pct") ?? 0;
        const fadingSlowDuration = phantomExBasicAttack?.GetSpecialValueFor("fading_slow_duration") ?? 0;
        const level = phantomExBasicAttack?.GetLevel() ?? 0;

        this.ProjectileAttack({
            source: this.caster,
            attackType: "basic",
            effectName: resources.dagger.path,
            spawnOrigin: origin.__add(Vector(projectileDirection.x * 30, projectileDirection.y * 30, 96)),
            velocity: projectileDirection.__mul(projectileSpeed),
            groundOffset: 0,
            unitTest: (unit, projectile) => !areUnitsAllied(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                attackWithBaseDamage({
                    source: projectile.getSource(),
                    target: unit,
                    ability: this
                });

                if (projectile.getSource() == this.caster) {
                    if (!isObstacle(unit)) {
                        if (!isGem(unit)) {
                            giveManaAndEnergyPercent(projectile.getSource(), manaGainPct, true);
                        }

                        if (phantomBasicAttack) {
                            ModifierPhantomStacks.apply(this.caster, this.caster, phantomBasicAttack as PhantomBasicAttack, {});
                        }
                    }
                }

                ModifierFadingSlow.apply(unit, this.caster, undefined, {
                    duration: fadingSlowDuration,
                    maxSlowPct: fadingSlowPct
                });

                if (level >= 2 && phantomExBasicAttack) {
                    ModifierPhantomBleed.apply(unit, projectile.getSource(), phantomExBasicAttack as PhantomExBasicAttack, {
                        duration: bleedDuration
                    });
                }
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(projectile.getPosition());
            }
        });

        EmitSoundOn("Hero_PhantomAssassin.Dagger.Cast", this.caster);
    }

    PlayEffectsOnFinish(position: Vector) {
        EmitSoundOnLocationWithCaster(position, "Hero_PhantomAssassin.Dagger.Target", this.caster);
        const particleId = ParticleManager.CreateParticle(resources.daggerImpact.path, ParticleAttachment.WORLDORIGIN, undefined);
        ParticleManager.SetParticleControl(particleId, 3, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    // OnUpgrade(){
    // 	CustomAbilitiesLegacy:LinkUpgrades(this, "phantom_ex_basic_attack")
    // }
}

@registerModifier("modifier_phantom_ex_basic_attack")
class ModifierPhantomExBasicAttack extends CustomModifier {
    particleId!: ParticleID;

    IsHidden() {
        return false;
    }

    IsDebuff() {
        return false;
    }

    IsStunDebuff() {
        return false;
    }

    IsPurgable() {
        return true;
    }

    OnCreated() {
        if (IsServer()) {
            this.parent.SwapAbilities(PhantomBasicAttack.name, PhantomBasicAttackRelated.name, false, true);
            this.PlayEffectsOnCast();
        }
    }

    OnDestroy() {
        if (IsServer()) {
            this.parent.SwapAbilities(PhantomBasicAttack.name, PhantomBasicAttackRelated.name, true, false);
            const origin = this.parent.GetAbsOrigin();
            const particleId = ParticleManager.CreateParticle(resources.invisPoof.path, ParticleAttachment.CUSTOMORIGIN, this.parent);
            ParticleManager.SetParticleControlEnt(
                particleId,
                0,
                this.parent,
                ParticleAttachment.POINT_FOLLOW,
                AttachLocation.hitloc,
                origin,
                true
            );
            ParticleManager.SetParticleControlEnt(
                particleId,
                1,
                this.parent,
                ParticleAttachment.POINT_FOLLOW,
                AttachLocation.hitloc,
                origin,
                true
            );
            this.StopEffects();
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.PREATTACK_BONUS_DAMAGE];
    }

    GetModifierPreAttack_BonusDamage() {
        return -1;
    }

    PlayEffectsOnCast() {
        const origin = this.parent.GetAbsOrigin();
        this.particleId = ParticleManager.CreateParticle(resources.yellowSparks.path, ParticleAttachment.CUSTOMORIGIN, this.parent);
        ParticleManager.SetParticleControlEnt(
            this.particleId,
            0,
            this.parent,
            ParticleAttachment.POINT_FOLLOW,
            AttachLocation.hitloc,
            origin,
            true
        );
    }

    StopEffects() {
        ParticleManager.DestroyParticle(this.particleId, false);
        ParticleManager.ReleaseParticleIndex(this.particleId);
    }
}

@registerModifier("modifier_phantom_bleed")
export class ModifierPhantomBleed extends CustomModifier<PhantomExBasicAttack> {
    particleId!: ParticleID;
    bleedDamagePerStack = 1;
    maxStacks = 3;

    OnCreated() {
        if (IsServer()) {
            this.SetStackCount(1);
            this.OnIntervalThink();
            this.StartIntervalThink(1);
            this.particleId = EFX(resources.bleed.path, ParticleAttachment.ABSORIGIN_FOLLOW, this.parent, {});
        }
    }

    OnRefresh() {
        if (IsServer()) {
            if (this.GetStackCount() < this.maxStacks) {
                this.IncrementStackCount();
            }
        }
    }

    OnDestroy() {
        if (IsServer()) {
            ParticleManager.DestroyParticle(this.particleId, false);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }

    OnIntervalThink() {
        ApplyDamage({
            damage: this.bleedDamagePerStack * this.GetStackCount(),
            victim: this.parent,
            attacker: this.caster,
            damage_type: DamageTypes.PURE,
            ability: this.ability
        });
        EFX(resources.bleedRibbon.path, ParticleAttachment.ABSORIGIN_FOLLOW, this.parent, {
            release: true
        });
        EFX(resources.bleedSplash.path, ParticleAttachment.ABSORIGIN_FOLLOW, this.parent, {
            cp3: this.parent.GetAbsOrigin(),
            release: true
        });
        EmitSoundOn("Hero_PhantomAssassin.Attack", this.parent);
        EmitSoundOn("Hero_PhantomAssassin.Dagger.Target", this.parent);
        EmitSoundOn("Hero_PhantomAssassin.Spatter", this.parent);
    }
}

defineAbility(PhantomBasicAttack, {
    category: "basic",
    linkedAbility: {
        name: PhantomExBasicAttack.name,
        shareCooldown: false
    }
});

defineAbility(PhantomExBasicAttack, {
    category: "basic",
    linkedAbility: {
        name: PhantomBasicAttack.name,
        shareCooldown: false
    }
});

defineAbility(PhantomBasicAttackRelated, {
    category: "basic"
});
