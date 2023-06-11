import { registerAbility } from "../../../lib/dota_ts_adapter";
import { clampPosition, direction2D, giveManaAndEnergyPercent, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { ModifierPhantomStacks } from "./phantom_basic_attack";

@registerAbility("phantom_second_attack")
class PhantomSecondAttack extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_ATTACK_EVENT;
    }

    GetPlaybackRateOverride() {
        return 0.8;
    }

    GetCastingCrawl() {
        return 80;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const castRange = this.GetCastRange(Vector(0, 0, 0), undefined);
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const point = clampPosition(origin, cursor, { maxRange: castRange, minRange: castRange });
        const damage = this.caster.GetAverageTrueAttackDamage(this.caster);

        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        //TODO: @Refactor Handle the extra radius
        const meeleExtraRadius = 0; //CustomEntitiesLegacy:GetMeeleExtraRadius(this.caster)
        const radius = this.GetSpecialValueFor("radius") + meeleExtraRadius;
        const damagePerStack = this.GetSpecialValueFor("damage_per_stack");
        const direction = direction2D(origin, point);
        const stacks = ModifierPhantomStacks.findOne(this.caster)?.GetStackCount() ?? 0;
        const finalDamage = damage + stacks * damagePerStack;

        const units = this.MeeleAttack({
            direction,
            origin,
            radius,
            // bShakeOnHeroes = true,
            effect: target => {
                ApplyDamage({
                    victim: target,
                    attacker: this.caster,
                    damage: finalDamage,
                    damage_type: DamageTypes.PHYSICAL
                });
                if (stacks == 3) {
                    // const modifier = this.caster.FindModifierByName("modifier_phantom_mobility_charges")
                    // if modifier then
                    // 	if this.GetLevel() >= 2 then
                    // 		modifier:RefreshCharges()
                    // 	else
                    // 		modifier:AddCharge()
                    // 	}
                    // }
                    EmitSoundOn("DOTA_Item.MagicWand.Activate", this.caster);
                }

                if (!isObstacle(target) && !isGem(target)) {
                    giveManaAndEnergyPercent(this.caster, manaGainPct, true);
                }
                this.PlayEffectsOnImpact(target, stacks);
            }
        });

        this.PlayEffectsOnFinish(direction, radius);
        this.caster.RemoveModifierByName(ModifierPhantomStacks.name);
        EmitSoundOn("Hero_PhantomAssassin.Attack", this.caster);
        // 	if #units > 0 then
        // 		if this.caster.HasModifier("modifier_upgrade_phantom_critical_recast") then
        // 			this.caster.AddNewModifier(this.caster, self, "modifier_phantom_second_attack_recast", { duration = 3.0 })
        // 		}
        // 	}
    }

    PlayEffectsOnImpact(target: CDOTA_BaseNPC, stacks: number) {
        EmitSoundOn("Hero_PhantomAssassin.Arcana_Layer", target);
        const offset = 100;
        const origin = this.caster.GetAbsOrigin();
        const direction = direction2D(origin, target.GetAbsOrigin());
        const finalPosition = origin.__add(Vector(direction.x * offset, direction.y * offset, 0));
        let particle_cast = "";

        if (stacks == 3) {
            particle_cast =
                "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop.vpcf";
            EmitSoundOn("Hero_PhantomAssassin.Spatter", target);
        } else {
            particle_cast =
                "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop_r.vpcf";
        }
        const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.POINT, this.caster);
        ParticleManager.SetParticleControl(particleId, 1, finalPosition);
        ParticleManager.SetParticleControlForward(particleId, 1, direction2D(finalPosition, origin));
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsOnFinish(direction: Vector, radius: number) {
        const origin = this.caster.GetAbsOrigin();
        const efx = EFX("particles/juggernaut/juggernaut_second_attack_parent.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: origin,
            cp0f: direction,
            cp3: Vector(radius, 0, 0)
        });
        ParticleManager.SetParticleControl(efx, 60, Vector(255, 0, 255));
        ParticleManager.SetParticleControl(efx, 61, Vector(1, 0, 0));
        ParticleManager.ReleaseParticleIndex(efx);
    }

    // function phantom_second_attack:OnUpgrade()
    // 	CustomAbilitiesLegacy:LinkUpgrades(self, "phantom_second_attack_recast")
    // }
}

@registerAbility("phantom_second_attack_recast")
class PhantomSecondAttackRecast extends CustomAbility {
    // function phantom_second_attack_recast:OnUpgrade()
    // 	CustomAbilitiesLegacy:LinkUpgrades(self, "phantom_second_attack")
    // }
    // function phantom_second_attack_recast:OnSpellStart()
    // 	const origin = this.caster.GetAbsOrigin()
    // 	const radius = this.GetSpecialValueFor("radius") + CustomEntitiesLegacy:GetMeeleExtraRadius(this.caster)
    // 	const point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(self), this.GetCastRange(Vector(0,0,0), undefined), undefined)
    // 	const extra_damage = this.GetSpecialValueFor("extra_damage")
    //     EmitSoundOn("Hero_PhantomAssassin.Blur", this.caster)
    // 	EFX("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
    //         cp0 = origin,
    //         cp3 = origin,
    //         release = true,
    //     })
    //     FindClearSpaceForUnit(this.caster, point, true)
    //     EmitSoundOn("Hero_PhantomAssassin.Blur.Break", this.caster)
    //     EFX("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, self.parent, {
    //         cp3 = this.caster.GetAbsOrigin(),
    //         release = true,
    //     })
    // 	const damage_table = {
    // 		attacker = this.caster,
    // 		damage = this.caster.GetAverageTrueAttackDamage(this.caster) + extra_damage,
    // 		damage_type = DAMAGE_TYPE_PHYSICAL,
    // 	}
    // 	ApplyCallbackForUnitsInArea(this.caster, this.caster.GetAbsOrigin(), radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
    // 		damage_table.victim = unit
    // 		ApplyDamage(damage_table)
    // 		this.PlayEffectsOnImpact(unit)
    // 		EmitSoundOn("Hero_PhantomAssassin.Spatter", unit)
    // 		EmitSoundOn("Hero_PhantomAssassin.Attack", this.caster)
    // 	})
    // 	CreateRadiusMarker(this.caster, point, radius, RADIUS_SCOPE_PUBLIC, 0.1)
    // 	this.caster.StartGestureWithPlaybackRate(ACT_DOTA_ATTACK_EVENT, 1.5)
    // }
}

// phantom_second_attack_recast.PlayEffectsOnImpact = phantom_second_attack.PlayEffectsOnImpact

// if IsClient() then require("wrappers/abilities") }
// modifier_phantom_second_attack_recast = class({})

// function modifier_phantom_second_attack_recast:IsHidden()
//     return true
// }

// function modifier_phantom_second_attack_recast:GetRecastAbility()
//     if IsServer() then
//         return this.GetParent():FindAbilityByName("phantom_second_attack_recast")
//     }
// }

// function modifier_phantom_second_attack_recast:GetRecastCharges()
// 	return 1
// }

// function modifier_phantom_second_attack_recast:GetRecastKey()
// 	return "M2"
// }

// if IsClient() then require("wrappers/modifiers") }
// Modifiers.Recast(modifier_phantom_second_attack_recast)
