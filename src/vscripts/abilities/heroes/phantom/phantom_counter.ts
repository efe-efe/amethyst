import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierBanish } from "../../../modifiers/modifier_banish";
import { OnHitEvent } from "../../../modifiers/modifier_combat_events";
import { ModifierCounter } from "../../../modifiers/modifier_counter";
import {
    ModifierUpgradePhantomActCounter,
    ModifierUpgradePhantomCounterStacks,
    ModifierUpgradeSniperStrikeInstant
} from "../../../modifiers/upgrades/modifier_favors";
import { ModifierRecast } from "../../../modifiers/modifier_recast";
import { ModifierShield } from "../../../modifiers/modifier_shield";
import { ModifierSleep } from "../../../modifiers/modifier_sleep";
import { areUnitsAllied, clampPosition, direction2D, getCursorPosition, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";
import { ModifierPhantomStacks, PhantomBasicAttack } from "./phantom_basic_attack";
import { ModifierUpgradePhantomStrikeKnives } from "../../../modifiers/upgrades/shards/modifier_upgrade_phantom_strike_knives";
import { precache, resource } from "../../../precache";

const resources = precache({
    sparksStart: resource.fx(
        "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf"
    ),
    sparksEnd: resource.fx("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf"),
    blurStart: resource.fx("particles/econ/items/phantom_assassin/pa_fall20_immortal_shoulders/pa_fall20_blur_start.vpcf"),
    blurStatus: resource.fx("particles/units/heroes/hero_phantom_assassin/phantom_assassin_active_blur.vpcf"),
    explosion: resource.fx("particles/phantom/phantom_special_attack_explosion.vpcf"),
    invisible: resource.fx("particles/econ/items/phantom_assassin/pa_fall20_immortal_shoulders/pa_fall20_blur_ambient.vpcf"),
    dagger: resource.fx("particles/phantom/phantom_counter_recast.vpcf"),
    counterActivate: resource.fx("particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_omni_slash_tgt_bonus.vpcf")
});

@registerAbility("phantom_counter")
class PhantomCounter extends CustomAbility {
    OnSpellStart() {
        let duration = this.GetSpecialValueFor("counter_duration");
        if (ModifierUpgradeSniperStrikeInstant.findOne(this.caster)) {
            duration = duration / 2;
        }

        const modifier = ModifierPhantomCounter.apply(this.caster, this.caster, this, { duration: duration });
        if (modifier && ModifierUpgradeSniperStrikeInstant.findOne(this.caster)) {
            modifier.OnHit({
                triggerCounters: true,
                attackCategory: "single",
                source: this.caster
            });
        }
        // 	LinkAbilityCooldowns(this.caster, 'phantom_ex_counter', {
        // 		["0"] = {
        // 			ability = 'phantom_ex_counter',
        // 			level = 2,
        // 		}
        // 	})
    }
    // OnUpgrade(){
    // 	CustomAbilitiesLegacy:LinkUpgrades(this, "phantom_counter_recast")
    // }
}

@registerAbility("phantom_counter_recast")
class PhantomCounterRecast extends CustomAbility {
    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const phantomCounter = PhantomCounter.findOne(this.caster);
        const duration = phantomCounter?.GetSpecialValueFor("buff_duration") ?? 0;
        const shield = phantomCounter?.GetSpecialValueFor("shield") ?? 0;
        const shieldDuration = phantomCounter?.GetSpecialValueFor("shield_duration") ?? 0;

        ModifierPhantomCounterBuff.apply(this.caster, this.caster, this, { duration: duration });
        ModifierPhantomCounterShield.apply(this.caster, this.caster, undefined, {
            duration: shieldDuration,
            damageBlock: shield
        });
        EFX(resources.sparksEnd.path, ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
            cp3: origin,
            release: true
        });
        EFX(resources.blurStart.path, ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
            cp3: origin,
            release: true
        });
        EmitSoundOn("Hero_Sven.GodsStrength.Attack", this.caster);
        EmitSoundOn("Hero_Abaddon.AphoticShield.Cast", this.caster);
    }
    // OnUpgrade(){
    // 	CustomAbilitiesLegacy:LinkUpgrades(this, "phantom_counter")
    // }
}

@registerAbility("phantom_ex_counter")
class PhantomExCounter extends CustomAbility {
    OnSpellStart() {
        const duration = this.GetSpecialValueFor("duration");

        ModifierPhantomExCounterRecast.apply(this.caster, this.caster, this, {
            abilityLeft: PhantomExCounter.name,
            abilityRight: PhantomExCounterRecast.name,
            duration: duration
        });
        this.PlayEffectsOnCast();
        // LinkAbilityCooldowns(this.caster, 'phantom_counter', {
        // 	["0"] = {
        // 		ability = this,
        // 		level = 2,
        // 	}
        // })
    }
    PlayEffectsOnCast() {
        const origin = this.caster.GetAbsOrigin();
        EmitSoundOn("Hero_PhantomAssassin.Blur.Break", this.caster);
        EFX(resources.sparksEnd.path, ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
            cp3: origin,
            release: true
        });
        EFX(resources.blurStart.path, ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: origin,
            cp3: origin,
            release: true
        });
    }
    // OnUpgrade(){
    // 	CustomAbilitiesLegacy:LinkUpgrades(this, "phantom_ex_counter_recast")
    // }
}

@registerAbility("phantom_ex_counter_recast")
class PhantomExCounterRecast extends CustomAbility {
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
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);
        const damage = this.GetSpecialValueFor("ability_damage");
        const modifier = ModifierPhantomStacks.findOne(this.caster);
        const stacks = modifier?.GetStackCount() ?? 0;

        const phantomBasicAttack = PhantomBasicAttack.findOne(this.caster);
        const phantomExCounter = PhantomExCounter.findOne(this.caster);
        const durationPerStack = phantomExCounter?.GetSpecialValueFor("duration_per_stack") ?? 0;
        const sleepDuration = (phantomExCounter?.GetSpecialValueFor("sleep_duration") ?? 0) + durationPerStack * stacks;

        modifier?.Destroy();

        this.ProjectileAttack({
            source: this.caster,
            effectName: resources.dagger.path,
            spawnOrigin: origin.__add(Vector(projectileDirection.x * 30, projectileDirection.y * 30, 96)),
            velocity: projectileDirection.__mul(projectileSpeed),
            groundOffset: 0,
            unitTest: (unit, projectile) => !areUnitsAllied(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                ApplyDamage({
                    victim: unit,
                    attacker: this.caster,
                    damage: damage,
                    damage_type: DamageTypes.PHYSICAL
                });

                if (projectile.getSource() == this.caster) {
                    if (!isObstacle(unit) && phantomBasicAttack) {
                        ModifierPhantomStacks.apply(this.caster, this.caster, phantomBasicAttack as PhantomBasicAttack, {});
                    }
                }

                ModifierSleep.apply(unit, this.caster, undefined, { duration: sleepDuration });
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(projectile.getPosition());
            }
        });
        EmitSoundOn("Hero_PhantomAssassin.Dagger.Cast", this.caster);
    }

    PlayEffectsOnFinish(position: Vector) {
        EmitSoundOnLocationWithCaster(position, "Hero_PhantomAssassin.Dagger.Target", this.caster);
        const particleId = ParticleManager.CreateParticle(resources.explosion.path, ParticleAttachment.WORLDORIGIN, undefined);
        ParticleManager.SetParticleControl(particleId, 3, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }
    // OnUpgrade(){
    // 	CustomAbilitiesLegacy:LinkUpgrades(this, "phantom_ex_counter")
    // }
}

@registerModifier("modifier_phantom_ex_counter_recast")
class ModifierPhantomExCounterRecast extends ModifierRecast {
    particleId!: ParticleID;

    IsHidden() {
        return false;
    }

    IsDebuff() {
        return false;
    }

    IsPurgable() {
        return true;
    }

    OnCreated(params: { abilityLeft: string; abilityRight: string; duration: number }) {
        super.OnCreated(params);
        if (IsServer()) {
            this.particleId = EFX(resources.invisible.path, ParticleAttachment.ABSORIGIN_FOLLOW, this.parent, {});
        }
    }

    OnDestroy() {
        super.OnDestroy();
        if (IsServer()) {
            DEFX(this.particleId, false);
            EFX(resources.sparksEnd.path, ParticleAttachment.ABSORIGIN_FOLLOW, this.parent, {
                cp3: this.parent.GetAbsOrigin(),
                release: true
            });
        }
    }

    DeclareFunctions() {
        return [...super.DeclareFunctions(), ModifierFunction.INVISIBILITY_LEVEL, ModifierFunction.MOVESPEED_BONUS_PERCENTAGE];
    }

    GetModifierInvisibilityLevel() {
        return 2;
    }

    GetModifierMoveSpeedBonus_Percentage() {
        return this.Value("speed_buff_pct");
    }

    CheckState() {
        return {
            [ModifierState.INVISIBLE]: true,
            [ModifierState.TRUESIGHT_IMMUNE]: false
        };
    }
}

@registerModifier("modifier_phantom_counter")
class ModifierPhantomCounterBuff extends CustomModifier {
    OnCreated() {
        if (IsServer()) {
            if (ModifierUpgradePhantomCounterStacks.findOne(this.parent)) {
                const modifier = ModifierPhantomStacks.findOne(this.parent);
                const stacks = modifier?.GetStackCount() ?? 0;
                modifier?.Destroy();

                this.SetStackCount((stacks / 2) * this.parent.GetAverageTrueAttackDamage(this.parent));
            }
        }
    }

    GetModifierAttackSpeedBonus_Constant() {
        return this.Value("as_speed");
    }

    DeclareFunctions() {
        return [ModifierFunction.ATTACKSPEED_BONUS_CONSTANT, ModifierFunction.PREATTACK_BONUS_DAMAGE];
    }

    GetModifierPreAttack_BonusDamage() {
        return this.GetStackCount();
    }

    GetEffectAttachType() {
        return ParticleAttachment.ABSORIGIN_FOLLOW;
    }

    GetStatusEffectName() {
        return resources.blurStatus.path;
    }
}

@registerModifier("modifier_phantom_counter_shield")
class ModifierPhantomCounterShield extends ModifierShield {}
// if(IsClient()){ require("wrappers/modifiers") }
// Modifiers.Status(modifier_phantom_counter_shield)
// Modifiers.Shield(modifier_phantom_counter_shield)

@registerModifier("modifier_phantom_counter_recast")
class ModifierPhantomCounterRecast extends ModifierRecast {
    IsHidden() {
        return false;
    }

    IsDebuff() {
        return false;
    }

    IsPurgable() {
        return true;
    }
}

@registerModifier("modifier_phantom_counter_countering")
class ModifierPhantomCounter extends ModifierCounter {
    GetBanishDuration() {
        return ModifierUpgradeSniperStrikeInstant.findOne(this.parent) ? this.Value("banish_duration") / 2 : this.Value("banish_duration");
    }

    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            const particleId = ParticleManager.CreateParticle(
                resources.counterActivate.path,
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.caster
            );
            ParticleManager.ReleaseParticleIndex(particleId);
        }
    }

    OnHit(event: OnHitEvent) {
        if (IsServer()) {
            if (!event.triggerCounters) {
                return true;
            }

            ModifierPhantomCounterBanish.apply(this.parent, this.parent, this.ability, { duration: this.GetBanishDuration() });
            this.Destroy();

            //@Refactor check on this... Idk why i manually destroy it
            if (event.attackCategory == "projectile") {
                const projectile = event.projectile;
                if (projectile.getIsDestructible()) {
                    projectile.scheduleDestroy();
                }
            }
            return false;
        }

        return true;
    }

    AfterHit() {
        if (IsServer()) {
            this.Destroy();
        }
    }

    // DeactivateAbilities(){
    // 	if(IsServer()){
    // 		if(ModifierUpgradePhantomActCounter.findOne(this.parent)){
    // 			return false
    // 		}
    // 		return true
    // 	}
    // }

    OnOrder(event: ModifierUnitEvent) {
        if (IsServer() && event.unit == this.parent) {
            if (ModifierUpgradePhantomActCounter.findOne(this.parent)) {
                return;
            }

            if (
                event.order_type == UnitOrder.STOP ||
                event.order_type == UnitOrder.HOLD_POSITION ||
                event.order_type == UnitOrder.CAST_POSITION ||
                event.order_type == UnitOrder.CAST_NO_TARGET
            ) {
                this.Destroy();
            }
        }
    }

    GetMovementSpeedPercentage() {
        if (IsServer() && ModifierUpgradePhantomActCounter.findOne(this.parent)) {
            return 100;
        }
        return 0;
    }

    DeclareFunctions() {
        return [
            ...super.DeclareFunctions(),
            ModifierFunction.OVERRIDE_ANIMATION,
            ModifierFunction.OVERRIDE_ANIMATION_RATE,
            ModifierFunction.ON_ORDER
        ];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_3;
    }

    GetOverrideAnimationRate() {
        return 0.4;
    }
}

@registerModifier("modifier_phantom_counter_banish")
class ModifierPhantomCounterBanish extends ModifierBanish {
    OnCreated() {
        super.OnCreated();
        if (IsServer()) {
            this.PlayEffectsOnCreated();
        }
    }

    OnDestroy() {
        super.OnDestroy();
        if (IsServer()) {
            const cursor = getCursorPosition(this.caster);
            const point = clampPosition(this.parent.GetAbsOrigin(), cursor, {
                maxRange: this.ability.GetCastRange(Vector(0, 0, 0), undefined)
            });
            const phantomBasicAttack = PhantomBasicAttack.findOne(this.parent);

            FindClearSpaceForUnit(this.parent, point, true);
            if (!ModifierUpgradeSniperStrikeInstant.findOne(this.parent)) {
                this.parent.Heal(this.Value("heal"), this.ability);
            }

            if (phantomBasicAttack) {
                // phantomBasicAttack.TryThrowKnives(ModifierUpgradePhantomStrikeKnives.name);
            }

            if (this.ability.GetLevel() >= 2) {
                ModifierPhantomCounterRecast.apply(this.parent, this.parent, this.ability, {
                    abilityLeft: PhantomCounter.name,
                    abilityRight: PhantomCounterRecast.name,
                    duration: this.Value("buff_duration")
                });
            }
            ModifierPhantomCounterBuff.apply(this.parent, this.parent, this.ability, { duration: this.Value("buff_duration") });
            this.PlayEffectsOnCast();
        }
    }

    PlayEffectsOnCreated() {
        EmitSoundOn("Hero_PhantomAssassin.Blur", this.parent);
        EFX(resources.sparksStart.path, ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: this.parent.GetAbsOrigin(),
            cp3: this.parent.GetAbsOrigin(),
            release: true
        });
    }

    PlayEffectsOnCast() {
        EmitSoundOn("Hero_PhantomAssassin.Blur.Break", this.parent);
        EFX(resources.sparksEnd.path, ParticleAttachment.ABSORIGIN_FOLLOW, this.parent, {
            cp3: this.parent.GetAbsOrigin(),
            release: true
        });
    }

    CheckState() {
        return {
            ...super.CheckState(),
            [ModifierState.COMMAND_RESTRICTED]: true
        };
    }
}
