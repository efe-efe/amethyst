import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierDisplacement } from "../../../modifiers/modifier_displacement";
import { ModifierInvencible } from "../../../modifiers/modifier_invencible";
import { clampPosition, getCursorPosition } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { SniperBasicAttack } from "./sniper_basic_attack";
import { ModifierSniperSpecialAttackThinker } from "./sniper_special_attack";

@registerAbility("sniper_mobility")
class SniperMobility extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_1;
    }

    GetPlaybackRateOverride() {
        return 2.0;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const minRange = this.GetSpecialValueFor("min_range");
        const cursor = getCursorPosition(this.caster);
        const point = clampPosition(origin, cursor, { maxRange: this.GetCastRange(Vector(0, 0, 0), undefined), minRange });
        // const shrapnel = this.caster.FindAbilityByName(SniperBasicAttack.name);
        const direction = point.__sub(origin).Normalized();
        const distance = point.__sub(origin).Length2D();

        ModifierSniperMobility.apply(this.caster, this.caster, this, {
            x: direction.x,
            y: direction.y,
            distance: distance,
            speed: distance / 0.5,
            peak: 400
        });

        ModifierInvencible.apply(this.caster, this.caster, this, {
            duration: 0.5
        });

        ModifierSniperSpecialAttackThinker.createThinker(this.caster, this, origin, {
            duration: this.GetSpecialValueFor("duration"),
            delayTime: this.GetSpecialValueFor("delay_time"),
            radius: this.GetSpecialValueFor("radius")
        });

        if (this.GetLevel() == 2) {
            // this.caster.FindAbilityByName("sniper_second_attack").EndCooldown()
            // this.caster.FindAbilityByName("sniper_ex_second_attack").EndCooldown()
        }
        this.PlayEffectsOnCast();
    }

    PlayEffectsOnCast() {
        EmitSoundOn("Hero_Techies.LandMine.Detonate", this.caster);
        const particleId = ParticleManager.CreateParticle(
            "particles/econ/courier/courier_cluckles/courier_cluckles_ambient_rocket_explosion.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(particleId, 0, this.caster.GetOrigin());
        ParticleManager.SetParticleControl(particleId, 3, this.caster.GetOrigin());
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerModifier("modifier_sniper_mobility_displacement")
class ModifierSniperMobility extends ModifierDisplacement {
    // function modifier_sniper_mobility_displacement:OnDestroy()
    // 	if IsServer() then
    // 		local caster = self:GetCaster()
    // 		if caster == self:GetParent() then
    // 			if self:GetCaster():HasModifier("modifier_upgrade_sniper_jump_knockback") then
    // 				local origin = caster:GetAbsOrigin()
    // 				local radius = 400
    // 				local damage_table = {
    // 					attacker = caster,
    // 					damage = 15,
    // 					damage_type = DAMAGE_TYPE_MAGICAL,
    // 				}
    // 				ApplyCallbackForUnitsInArea(caster, origin, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
    // 					local unit_origin = unit:GetAbsOrigin()
    // 					local direction = (unit_origin - origin):Normalized()
    // 					local distance = 500
    // 					unit:AddNewModifier(
    // 						caster, -- player source
    // 						self:GetAbility(), -- ability source
    // 						"modifier_sniper_mobility_displacement", -- modifier name
    // 						{
    // 							x = direction.x,
    // 							y = direction.y,
    // 							r = distance,
    // 							speed = (distance/0.35),
    // 							peak = 200,
    // 						}
    // 					)
    // 					damage_table.victim = unit
    // 					ApplyDamage(damage_table)
    // 				})
    // 				EFX("particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_ground_rings.vpcf", PATTACH_WORLDORIGIN, nil, {
    // 					cp0 = origin,
    // 					cp5 = origin,
    // 					release = true,
    // 				})
    // 				EFX("particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_impact_refract.vpcf", PATTACH_WORLDORIGIN, nil, {
    // 					cp0 = origin,
    // 					cp5 = origin,
    // 					release = true,
    // 				})
    // 				EFX("particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_impact_smoke.vpcf", PATTACH_WORLDORIGIN, nil, {
    // 					cp0 = origin,
    // 					cp3 = origin,
    // 					release = true,
    // 				})
    // 				EFX("particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_impact_sparks.vpcf", PATTACH_WORLDORIGIN, nil, {
    // 					cp0 = origin,
    // 					cp5 = origin,
    // 					release = true,
    // 				})
    // 				ScreenShake(origin, 100, 300, 0.45, 1000, 0, true)
    // 				CreateRadiusMarker(caster, origin, radius, RADIUS_SCOPE_PUBLIC, 0.1)
    // 			}
    // 		}
    // 	}
    // }
    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_FLAIL;
    }

    GetOverrideAnimationRate() {
        return 1.0;
    }

    CheckState() {
        return {
            ...super.CheckState(),
            [ModifierState.NO_UNIT_COLLISION]: true
        };
    }
}
