mars_extra = class({})
LinkLuaModifier("modifier_mars_extra_displacement", "abilities/heroes/mars/mars_extra/modifier_mars_extra_displacement", LUA_MODIFIER_MOTION_BOTH)

function mars_extra:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_4 end
function mars_extra:GetPlaybackRateOverride() 	    return 1.0 end
function mars_extra:GetCastPointSpeed() 			return 80 end
function mars_extra:GetFadeGestureOnCast()		return false end

function mars_extra:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = Clamp(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), self:GetCastRange(Vector(0,0,0), nil))
	local direction = (point - origin):Normalized()
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("ability_damage")
	local knockback_distance = self:GetSpecialValueFor("knockback_distance")
	direction.z = 0

	local enemies = caster:FindUnitsInCone(
		direction, 
		0.0, 
		origin, 
		radius, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST
	)
	
	for _,enemy in pairs(enemies) do 
		local damage_table = {
			victim = enemy,
			attacker = caster,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
		}
		ApplyDamage(damage_table)

		local m_direction = (enemy:GetAbsOrigin() - origin):Normalized()
		local left_distance = radius - (enemy:GetAbsOrigin() - origin):Length2D()

		enemy:AddNewModifier(caster, self, "modifier_mars_extra_displacement", { 
			x = m_direction.x,
			y = m_direction.y,
			r = left_distance + knockback_distance,
			speed = (left_distance + knockback_distance)/0.25,
			peak = 100,
		})
	end

    self:PlayEffectsCone(direction, radius)
end

function mars_extra:PlayEffectsCone(direction, radius)
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_mars/mars_shield_bash.vpcf"
	local sound_cast = "Hero_Mars.Shield.Cast"
	--[[if not caught then
		local sound_cast = "Hero_Mars.Shield.Cast.Small"
	end]]

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, radius, radius))
	ParticleManager:SetParticleControlForward(effect_cast, 0, direction)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	-- Create Sound
	EmitSoundOnLocationWithCaster(self:GetCaster():GetOrigin(), sound_cast, self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(mars_extra)