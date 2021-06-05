modifier_sniper_mobility_displacement = class({})

function modifier_sniper_mobility_displacement:OnDestroy()
	if IsServer() then
		local caster = self:GetCaster()
		if caster == self:GetParent() then
			if self:GetCaster():HasModifier("modifier_upgrade_sniper_jump_knockback") then
				local origin = caster:GetAbsOrigin()
				local radius = 400
				local damage_table = {
					attacker = caster,
					damage = 15,
					damage_type = DAMAGE_TYPE_MAGICAL,
				}
				ApplyCallbackForUnitsInArea(caster, origin, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
					local unit_origin = unit:GetAbsOrigin()
					local direction = (unit_origin - origin):Normalized()
					local distance = 500

					unit:AddNewModifier(
						caster, -- player source
						self:GetAbility(), -- ability source
						"modifier_sniper_mobility_displacement", -- modifier name
						{
							x = direction.x,
							y = direction.y,
							r = distance,
							speed = (distance/0.35),
							peak = 200,
						}
					)
					damage_table.victim = unit
					ApplyDamage(damage_table)
				end)

				EFX("particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_ground_rings.vpcf", PATTACH_WORLDORIGIN, nil, {
					cp0 = origin,
					cp5 = origin,
					release = true,
				})
				EFX("particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_impact_refract.vpcf", PATTACH_WORLDORIGIN, nil, {
					cp0 = origin,
					cp5 = origin,
					release = true,
				})
				EFX("particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_impact_smoke.vpcf", PATTACH_WORLDORIGIN, nil, {
					cp0 = origin,
					cp3 = origin,
					release = true,
				})
				EFX("particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_impact_sparks.vpcf", PATTACH_WORLDORIGIN, nil, {
					cp0 = origin,
					cp5 = origin,
					release = true,
				})
				
				ScreenShake(origin, 100, 300, 0.45, 1000, 0, true)
				CreateRadiusMarker(caster, origin, radius, RADIUS_SCOPE_PUBLIC, 0.1)
			end
		end
	end
end


function modifier_sniper_mobility_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_sniper_mobility_displacement:GetOverrideAnimation() 		return ACT_DOTA_FLAIL end
function modifier_sniper_mobility_displacement:GetOverrideAnimationRate() 	return 1.0 end

function modifier_sniper_mobility_displacement:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_sniper_mobility_displacement)
Modifiers.Animation(modifier_sniper_mobility_displacement)