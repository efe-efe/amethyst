import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { Translate } from "../../../modifiers/modifier_casting";
import { clampPosition, direction2D, giveManaAndEnergy, giveManaAndEnergyPercent, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";
import { JuggernautBasicAttack, ModifierJuggernautStacks } from "./juggernaut_basic_attack";

@registerAbility("juggernaut_second_attack")
class JuggernautSecondAttack extends CustomAbility {
    particleId!: ParticleID;

    OnAbilityPhaseStart() {
        super.OnAbilityPhaseStart();
        this.particleId = EFX(
            "particles/econ/items/windrunner/windranger_arcana/windranger_arcana_javelin_tgt_v2.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.caster,
            {}
        );
        return true;
    }

    OnAbilityPhaseInterrupted() {
        super.OnAbilityPhaseInterrupted();
        DEFX(this.particleId, true);
    }

    GetAnimation() {
        const stacks = this.caster.FindModifierByName("modifier_juggernaut_basic_attack_stacks")?.GetStackCount() ?? 0;
        return stacks >= 4 ? GameActivity.DOTA_ATTACK : GameActivity.DOTA_ATTACK_EVENT;
    }

    GetPlaybackRateOverride() {
        return 1.5;
    }

    GetCastingCrawl() {
        return 40;
    }

    GetAnimationTranslate() {
        return Translate.ti8;
    }

    OnUnitImpact(target: CDOTA_BaseNPC, damage: number) {
        ApplyDamage({
            victim: target,
            attacker: this.caster,
            damage: damage,
            damage_type: DamageTypes.PHYSICAL
        });

        this.PlayEffectsOnImpact(target);
    }

    OnSpellStart() {
        const randomNumber = RandomInt(0, 4);
        if (randomNumber > 0) {
            EmitSoundOn(`juggernaut_jug_attack_0${randomNumber}`, this.caster);
        }

        const origin = this.caster.GetOrigin();
        const castRange = this.GetCastRange(Vector(0, 0, 0), undefined);
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const point = clampPosition(origin, cursor, { maxRange: castRange, minRange: castRange });
        const damage = this.caster.GetAverageTrueAttackDamage(this.caster);
        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        //TODO: @Refactor Handle the extra radius
        const meeleExtraRadius = 0; //CustomEntitiesLegacy:GetMeeleExtraRadius(caster)
        const radius = this.GetSpecialValueFor("radius") + meeleExtraRadius;

        const duration = this.GetSpecialValueFor("duration");
        const shieldPerStack = this.GetSpecialValueFor("shield_per_stack");
        const juggernautExSecondAttack = this.caster.FindAbilityByName("juggernaut_ex_second_attack");

        const damageMultiplier = this.GetSpecialValueFor("damage_multiplier");
        const damageMultiplierPerStack = this.GetSpecialValueFor("damage_multiplier_per_stack");

        const direction = direction2D(origin, point);
        const stacks = ModifierJuggernautStacks.findOne(this.caster)?.GetStackCount() ?? 0;

        const finalDamage = damage * damageMultiplier * ((stacks + 1) * damageMultiplierPerStack);

        const units: CDOTA_BaseNPC[] = [];

        if (stacks == 4) {
            const aoeRadius = radius * 1.15;
            units.push(
                ...this.AoeAttack({
                    origin,
                    radius: aoeRadius,
                    triggerCounters: true,
                    effect: target => {
                        this.OnUnitImpact(target, finalDamage);
                    }
                })
            );

            ModifierJuggernautSpin.apply(this.caster, this.caster, undefined, { duration: 0.3 });
            this.PlayEffectsAoe(aoeRadius);
        } else {
            units.push(
                ...this.MeeleAttack({
                    direction,
                    origin,
                    radius,
                    effect: target => {
                        this.OnUnitImpact(target, finalDamage);
                    }
                })
            );

            this.PlayEffectsOnFinish(direction, radius);
        }

        const giveMana = units.filter(unit => !isGem(unit) && !isObstacle(unit)).length > 0;
        const shieldProviders = units.filter(unit => !isObstacle(unit) /* && !isCountering(unit) */).length;

        if (giveMana) {
            giveManaAndEnergyPercent(this.caster, manaGainPct, true);
        }

        if (this.GetLevel() >= 2 && stacks > 0 && shieldProviders > 0) {
            const final_shield = stacks * shieldPerStack * shieldProviders;
            this.caster.AddNewModifier(this.caster, this, "modifier_juggernaut_second_attack", {
                damage_block: final_shield,
                duration: duration
            });
        }

        //     if(#units > 0){
        //         if(this.caster.HasModifier("modifier_upgrade_juggernaut_blade_dance_recast")){
        //             this.caster.AddNewModifier(this.caster, this, "modifier_juggernaut_second_attack_recast", {
        //                 duration = 1.0 + ((stacks) * 1.0),
        //                 charges = 3,
        //             })
        //         }
        //     }

        this.caster.RemoveModifierByName(ModifierJuggernautStacks.name);
        //     LinkAbilityCooldowns(this.caster, 'juggernaut_ex_second_attack')
    }

    PlayEffectsOnImpact(target: CDOTA_BaseNPC) {
        EFX("particles/units/heroes/hero_bounty_hunter/bounty_hunter_jinda_slow.vpcf", ParticleAttachment.ABSORIGIN, target, {
            release: true
        });

        EmitSoundOn("Hero_Juggernaut.BladeDance.Arcana", target);
        EmitSoundOn("Hero_Juggernaut.BladeDance.Layer", target);
        EmitSoundOn("Hero_Juggernaut.Attack", target);
    }

    PlayEffectsOnFinish(direction: Vector, radius: number) {
        const caster = this.caster;
        const origin = this.caster.GetOrigin();

        EmitSoundOnLocationWithCaster(origin, "Hero_Juggernaut.BladeDance", caster);
        EFX("particles/juggernaut/juggernaut_second_attack_parent.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: origin,
            cp0f: direction,
            cp3: Vector(radius, 0, 0),
            release: true
        });
    }

    PlayEffectsAoe(radius: number) {
        EmitSoundOn("juggernaut_jugsc_arc_ability_bladefury_12", this.caster);

        const particleId = ParticleManager.CreateParticle(
            "particles/econ/items/axe/axe_helm_shoutmask/axe_beserkers_call_owner_shoutmask.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 2, Vector(radius, 1, 1));
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerModifier({ customNameForI18n: "modifier_juggernaut_spin_animation" })
export class ModifierJuggernautSpin extends CustomModifier<undefined> {
    particleId!: ParticleID;

    IsHidden() {
        return true;
    }

    OnCreated() {
        if (IsServer()) {
            EmitSoundOn("Hero_Juggernaut.BladeFuryStart", this.parent);

            this.particleId = ParticleManager.CreateParticle(
                "particles/units/heroes/hero_juggernaut/juggernaut_blade_fury.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent
            );
            ParticleManager.SetParticleControl(this.particleId, 5, Vector(200, 1, 1));
            ParticleManager.SetParticleControl(this.particleId, 2, this.parent.GetOrigin());
        }
    }

    OnDestroy() {
        if (IsServer()) {
            StopSoundOn("Hero_Juggernaut.BladeFuryStart", this.parent);
            EmitSoundOn("Hero_Juggernaut.BladeFuryStop", this.parent);
            ParticleManager.DestroyParticle(this.particleId, false);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_OVERRIDE_ABILITY_1;
    }

    GetOverrideAnimationRate() {
        return 1.5;
    }
}

@registerAbility("juggernaut_ex_second_attack")
class JuggernautExSecondAttack extends CustomAbility {
    particleId!: ParticleID;

    GetAnimation() {
        return GameActivity.DOTA_OVERRIDE_ABILITY_1;
    }

    GetPlaybackRateOverride() {
        return 0.5;
    }

    GetAnimationTranslate() {
        return Translate.odachi;
    }

    GetCastingCrawl() {
        return 10;
    }

    OnAbilityPhaseStart() {
        if (super.OnAbilityPhaseStart()) {
            ModifierJuggernautSpin.apply(this.caster, this.caster, undefined, { duration: 0.3 });
            EmitSoundOn("juggernaut_jugg_ability_bladefury_12", this.caster);

            EFX("particles/juggernaut/juggernaut_ex_second_attack_casting_owner.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
                release: true
            });
            this.particleId = EFX(
                "particles/juggernaut/juggernaut_ex_second_attack_casting.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.caster,
                {}
            );
            return true;
        }
        return false;
    }

    OnAbilityPhaseInterrupted() {
        super.OnAbilityPhaseInterrupted();
        DEFX(this.particleId, true);
    }

    OnSpellStart() {
        DEFX(this.particleId, true);
        const origin = this.caster.GetOrigin();
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const castRange = this.GetCastRange(Vector(0, 0, 0), undefined);
        const point = clampPosition(origin, cursor, { maxRange: castRange, minRange: castRange });
        const abilityDamage = this.GetSpecialValueFor("ability_damage");
        const duration = this.GetSpecialValueFor("duration");
        const duration_per_stack = this.GetSpecialValueFor("duration_per_stack");
        const radius = this.GetSpecialValueFor("radius");
        const swiftnessDuration = this.GetSpecialValueFor("swiftness_duration");
        const swiftnessPct = this.GetSpecialValueFor("swiftness_pct");
        const juggernautBasicAttack = this.caster.FindAbilityByName("juggernaut_basic_attack") as JuggernautBasicAttack;
        const direction = direction2D(origin, point);

        const stacks = this.caster.FindModifierByName("modifier_juggernaut_basic_attack_stacks")?.GetStackCount() ?? 0;
        const finalDebuffDuration = duration + stacks * duration_per_stack;

        const units = this.MeeleAttack({
            direction,
            origin,
            radius,
            effect: target => {
                ApplyDamage({
                    victim: target,
                    attacker: this.caster,
                    damage: abilityDamage,
                    damage_type: DamageTypes.PHYSICAL
                });

                target.AddNewModifier(this.caster, this, "modifier_generic_sleep", { duration: finalDebuffDuration });
                this.PlayEffectsOnImpact(target);
            },
            baseSound: "DOTA_Item.SkullBasher"
        });

        const giveMana = units.filter(unit => !isGem(unit) && !isObstacle(unit)).length > 0;
        this.caster.RemoveModifierByName(ModifierJuggernautStacks.name);

        if (this.GetLevel() >= 2 && giveMana) {
            giveManaAndEnergy(this.caster, this.GetManaCost(this.GetLevel()), true);

            for (let i = 0; i < 3; i++) {
                ModifierJuggernautStacks.apply(this.caster, this.caster, juggernautBasicAttack, {});
            }

            this.caster.AddNewModifier(this.caster, this, "modifier_juggernaut_swiftness", {
                duration: swiftnessDuration,
                swiftness_pct: swiftnessPct
            });
        }

        this.PlayEffectsOnFinish(point, radius);
        // LinkAbilityCooldowns(this.caster, "juggernaut_second_attack");
    }

    PlayEffectsOnImpact(target: CDOTA_BaseNPC) {
        const particle_cast = "particles/econ/items/troll_warlord/troll_warlord_ti7_axe/troll_ti7_axe_bash_explosion.vpcf";
        const effect_cast = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN_FOLLOW, target);
        ParticleManager.SetParticleControl(effect_cast, 1, target.GetAbsOrigin());
        ParticleManager.ReleaseParticleIndex(effect_cast);
    }

    PlayEffectsOnFinish(position: Vector, radius: number) {
        const offset = 40;
        const origin = this.caster.GetAbsOrigin();
        const direction = position.__sub(origin).Normalized();
        const finalPosition = origin.__add(Vector(direction.x * offset, direction.y * offset, 0));

        let particleId = ParticleManager.CreateParticle(
            "particles/juggernaut/juggernaut_ex_second_attack.vpcf",
            ParticleAttachment.WORLDORIGIN,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 0, origin);
        ParticleManager.SetParticleControl(particleId, 1, Vector(radius, radius, radius));
        ParticleManager.SetParticleControlForward(particleId, 0, direction);
        ParticleManager.ReleaseParticleIndex(particleId);

        particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_spirit_breaker/spirit_breaker_greater_bash.vpcf",
            ParticleAttachment.POINT,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 0, finalPosition);
        ParticleManager.SetParticleControlForward(particleId, 0, direction);
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

// function juggernaut_second_attack:OnUpgrade()
// 	CustomAbilitiesLegacy:LinkUpgrades(this, "juggernaut_second_attack_recast")
// }
// function juggernaut_second_attack_recast:OnUpgrade()
// 	CustomAbilitiesLegacy:LinkUpgrades(this, "juggernaut_second_attack")
// }

// function juggernaut_second_attack_recast:OnSpellStart()
// 	const caster = this.caster
// 	const origin = this.caster.GetAbsOrigin()
// 	const min_range = this.GetSpecialValueFor("min_range")
// 	const point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(this), this.GetCastRange(Vector(0,0,0), undefined), min_range)
// 	const damage = this.caster.GetAverageTrueAttackDamage(this.caster) * 1.5

// 	FindClearSpaceForUnit(this.caster, point, true)

// 	const valid_targets = 0
// 	const new_origin = this.caster.GetAbsOrigin()
// 	const enemies = CustomEntitiesLegacy:FindUnitsInLine(
// 	   	caster,
// 		new_origin,
// 		origin,
// 		100,
// 		DOTA_UNIT_TARGET_TEAM_ENEMY,
// 		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
// 		DOTA_UNIT_TARGET_FLAG_NONE
// 	)

// 	const damage_table = {
// 	   attacker = caster,
// 	   damage = damage,
// 	   damage_type = DAMAGE_TYPE_PHYSICAL,
// 	}

// 	for _,enemy in pairs(enemies) do
// 		CustomEntitiesLegacy:SingleAttack(this.caster, {
// 			target = enemy,
// 			Callback = function(target)
// 				damage_table.victim = target
// 				ApplyDamage(damage_table)
// 				this.PlayEffectsOnTarget(target)
// 			}
// 		})
// 	}

// 	if(#enemies == 0){
// 		this.caster.RemoveModifierByName("modifier_juggernaut_second_attack_recast")
// 	}

// 	this.PlayEffectsOnSlash(origin, new_origin)
// }

// function juggernaut_second_attack_recast:PlayEffectsOnTarget(target)
// 	EmitSoundOn("Hero_Juggernaut.BladeDance.Arcana", target)
// 	EmitSoundOn("Hero_Juggernaut.BladeDance.Layer", target)
// 	EmitSoundOn("Hero_Juggernaut.Attack", target)
// }

// function juggernaut_second_attack_recast:PlayEffectsOnSlash(vOrigin, vNewOrigin)
// 	EFX("particles/juggernaut/juggernaut_counter_recast.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
// 	   cp0 = vOrigin,
// 	   cp1 = vNewOrigin,
// 	   release = true
// 	})
//  }
