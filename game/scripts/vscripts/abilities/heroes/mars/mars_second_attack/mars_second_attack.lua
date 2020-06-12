mars_second_attack = class({})
LinkLuaModifier("modifier_mars_second_attack_displacement", "abilities/heroes/mars/mars_second_attack/modifier_mars_second_attack_displacement", LUA_MODIFIER_MOTION_BOTH)

function mars_second_attack:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_4 end
function mars_second_attack:GetPlaybackRateOverride() 	    return 1.0 end
function mars_second_attack:GetCastPointSpeed() 			return 80 end
function mars_second_attack:GetFadeGestureOnCast()		return false end

function mars_second_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = Clamp(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), self:GetCastRange(Vector(0,0,0), nil))
	local direction = (point - origin):Normalized()
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("ability_damage")
	local knockback_distance = self:GetSpecialValueFor("knockback_distance")
	direction.z = 0

	local enemies = caster:FindUnitsInLine(
		point, 
		origin + direction * 50, 
		100, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_NONE
	)
	
	for _,enemy in pairs(enemies) do 
		local damage_table = {
			victim = enemy,
			attacker = caster,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
		}
		ApplyDamage(damage_table)

		enemy:AddNewModifier(caster, self, "modifier_mars_second_attack_displacement", { 
			x = direction.x,
			y = direction.y,
			r = knockback_distance,
			speed = (knockback_distance)/0.25,
			peak = 100,
		})
	end

    self:PlayEffectsCone(point, direction)
end

function mars_second_attack:PlayEffectsCone(point, direction)
	--[[if not caught then
		local sound_cast = "Hero_Mars.Shield.Cast.Small"
	end]]

	-- Create Particle
	local effect_cast =  ParticleManager:CreateParticle("particles/units/heroes/hero_mars/mars_shield_of_mars.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 0, point)
	ParticleManager:SetParticleControlForward(effect_cast, 0, direction)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	local effect_cast =  ParticleManager:CreateParticle("particles/mars/mars_second_attack_light.vpcf", PATTACH_CUSTOMORIGIN, self:GetCaster())
	ParticleManager:SetParticleControlEnt(
        effect_cast, 
        0, 
        self:GetCaster(), 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        self:GetCaster():GetAbsOrigin(), 
        true 
   )
	ParticleManager:SetParticleControl(effect_cast, 1, point + Vector(direction.x * 100, direction.y * 100, 128))
	ParticleManager:ReleaseParticleIndex(effect_cast)

	

	-- Create Sound
	EmitSoundOnLocationWithCaster(self:GetCaster():GetOrigin(), "Hero_Mars.Shield.Cast", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(mars_second_attack)