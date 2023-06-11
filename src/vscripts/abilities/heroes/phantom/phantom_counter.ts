import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierBanish } from "../../../modifiers/modifier_banish";
import { OnHitEvent } from "../../../modifiers/modifier_combat_events";
import { ModifierCounter } from "../../../modifiers/modifier_counter";
import { ModifierRecast } from "../../../modifiers/modifier_recast";
import { ModifierShield } from "../../../modifiers/modifier_shield";
import { clampPosition, direction2D, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";
import { ModifierPhantomStacks, PhantomBasicAttack } from "./phantom_basic_attack";

@registerAbility("phantom_counter")
class PhantomCounter extends CustomAbility {
    OnSpellStart() {
        let duration = this.GetSpecialValueFor("counter_duration");
        if (this.caster.HasModifier("modifier_upgrade_phantom_strike_instant")) {
            duration = duration / 2;
        }

        const modifier = ModifierPhantomCounter.apply(this.caster, this.caster, this, { duration: duration });
        if (modifier && this.caster.HasModifier("modifier_upgrade_phantom_strike_instant")) {
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
        const phantomCounter = this.caster.FindAbilityByName("phantom_counter");
        const duration = phantomCounter?.GetSpecialValueFor("buff_duration") ?? 0;
        const shield = phantomCounter?.GetSpecialValueFor("shield") ?? 0;
        const shieldDuration = phantomCounter?.GetSpecialValueFor("shield_duration") ?? 0;

        ModifierPhantomCounterBuff.apply(this.caster, this.caster, this, { duration: duration });
        ModifierPhantomCounterShield.apply(this.caster, this.caster, undefined, {
            duration: shieldDuration,
            damageBlock: shield
        });
        EFX(
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.caster,
            {
                cp3: origin,
                release: true
            }
        );
        EFX(
            "particles/econ/items/phantom_assassin/pa_fall20_immortal_shoulders/pa_fall20_blur_start.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.caster,
            {
                cp3: origin,
                release: true
            }
        );
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
        EFX(
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.caster,
            {
                cp3: origin,
                release: true
            }
        );
        EFX(
            "particles/econ/items/phantom_assassin/pa_fall20_immortal_shoulders/pa_fall20_blur_start.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined,
            {
                cp0: origin,
                cp3: origin,
                release: true
            }
        );
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
        const point = CustomAbilitiesLegacy.GetCursorPosition(this);
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);
        const damage = this.GetSpecialValueFor("ability_damage");
        const modifier = ModifierPhantomStacks.findOne(this.caster);
        const stacks = modifier?.GetStackCount() ?? 0;

        const phantomBasicAttack = this.caster.FindAbilityByName("phantom_basic_attack");
        const phantomExCounter = this.caster.FindAbilityByName("phantom_ex_counter");
        const durationPerStack = phantomExCounter?.GetSpecialValueFor("duration_per_stack") ?? 0;
        const sleepDuration = (phantomExCounter?.GetSpecialValueFor("sleep_duration") ?? 0) + durationPerStack * stacks;

        modifier?.Destroy();

        this.ProjectileAttack({
            source: this.caster,
            effectName: "particles/phantom/phantom_counter_recast.vpcf",
            spawnOrigin: origin.__add(Vector(projectileDirection.x * 30, projectileDirection.y * 30, 96)),
            velocity: projectileDirection.__mul(projectileSpeed),
            groundOffset: 0,
            unitTest: (unit, projectile) =>
                unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
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

                unit.AddNewModifier(this.caster, this, "modifier_generic_sleep", { duration: sleepDuration });
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(projectile.getPosition());
            }
        });
        EmitSoundOn("Hero_PhantomAssassin.Dagger.Cast", this.caster);
    }

    PlayEffectsOnFinish(position: Vector) {
        EmitSoundOnLocationWithCaster(position, "Hero_PhantomAssassin.Dagger.Target", this.caster);
        const particle_cast = "particles/phantom/phantom_special_attack_explosion.vpcf";
        const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined);
        ParticleManager.SetParticleControl(particleId, 3, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }
    // OnUpgrade(){
    // 	CustomAbilitiesLegacy:LinkUpgrades(this, "phantom_ex_counter")
    // }
}

@registerModifier({ customNameForI18n: "modifier_phantom_ex_counter_recast" })
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
            this.particleId = EFX(
                "particles/econ/items/phantom_assassin/pa_fall20_immortal_shoulders/pa_fall20_blur_ambient.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent,
                {}
            );
        }
    }

    OnDestroy() {
        super.OnDestroy();
        if (IsServer()) {
            DEFX(this.particleId, false);
            EFX(
                "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent,
                {
                    cp3: this.parent.GetAbsOrigin(),
                    release: true
                }
            );
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

@registerModifier({ customNameForI18n: "modifier_phantom_counter" })
class ModifierPhantomCounterBuff extends CustomModifier {
    OnCreated() {
        if (IsServer()) {
            if (this.parent.HasModifier("modifier_upgrade_phantom_countering_stacks")) {
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
        return "particles/units/heroes/hero_phantom_assassin/phantom_assassin_active_blur.vpcf";
    }
}

@registerModifier({ customNameForI18n: "modifier_phantom_counter_shield" })
class ModifierPhantomCounterShield extends ModifierShield {}
// if(IsClient()){ require("wrappers/modifiers") }
// Modifiers.Status(modifier_phantom_counter_shield)
// Modifiers.Shield(modifier_phantom_counter_shield)

@registerModifier({ customNameForI18n: "modifier_phantom_counter_recast" })
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

@registerModifier({ customNameForI18n: "modifier_phantom_counter_countering" })
class ModifierPhantomCounter extends ModifierCounter {
    GetBanishDuration() {
        return this.parent.HasModifier("modifier_upgrade_phantom_strike_instant")
            ? this.Value("banish_duration") / 2
            : this.Value("banish_duration");
    }

    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            const particleId = ParticleManager.CreateParticle(
                "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_omni_slash_tgt_bonus.vpcf",
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
    // 		if(this.parent.HasModifier('modifier_upgrade_phantom_act_while_countering')){
    // 			return false
    // 		}
    // 		return true
    // 	}
    // }

    OnOrder(params) {
        // if(IsServer()){
        // 	if(this.parent.HasModifier('modifier_upgrade_phantom_act_while_countering')){
        // 		return
        // 	}
        // 	if(params.unit == this.parent){
        // 		if( params.order_type == DOTA_UNIT_ORDER_STOP or
        // 			params.order_type == DOTA_UNIT_ORDER_HOLD_POSITION or
        // 			params.order_type == DOTA_UNIT_ORDER_CAST_POSITION or
        // 			params.order_type == DOTA_UNIT_ORDER_CAST_NO_TARGET
        // 		then
        // 			this.Destroy()
        // 		}
        // 	}
        // }
    }

    // GetMovementSpeedPercentage(){
    // 	if(this.parent.HasModifier('modifier_upgrade_phantom_act_while_countering')){
    // 		return 100
    // 	}
    // 	return 0
    // }

    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE, ModifierFunction.ON_ORDER];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_3;
    }

    GetOverrideAnimationRate() {
        return 0.4;
    }
}

@registerModifier({ customNameForI18n: "modifier_phantom_counter_banish" })
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
            const cursor = CustomAbilitiesLegacy.GetCursorPosition(this.ability);
            const point = clampPosition(this.parent.GetAbsOrigin(), cursor, {
                maxRange: this.ability.GetCastRange(Vector(0, 0, 0), undefined)
            });
            const phantomBasicAttack = this.parent.FindAbilityByName(PhantomBasicAttack.name);

            FindClearSpaceForUnit(this.parent, point, true);
            if (!this.parent.HasModifier("modifier_upgrade_phantom_strike_instant")) {
                this.parent.Heal(this.Value("heal"), this.ability);
            }

            if (phantomBasicAttack) {
                (phantomBasicAttack as PhantomBasicAttack).TryThrowKnives("modifier_upgrade_phantom_strike_knives");
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
        EFX(
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined,
            {
                cp0: this.parent.GetAbsOrigin(),
                cp3: this.parent.GetAbsOrigin(),
                release: true
            }
        );
    }

    PlayEffectsOnCast() {
        EmitSoundOn("Hero_PhantomAssassin.Blur.Break", this.parent);
        EFX(
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.parent,
            {
                cp3: this.parent.GetAbsOrigin(),
                release: true
            }
        );
    }

    CheckState() {
        return {
            ...super.CheckState(),
            [ModifierState.COMMAND_RESTRICTED]: true
        };
    }
}
