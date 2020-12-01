mars_second_attack = class({})
mars_ex_second_attack = class({})
LinkLuaModifier("modifier_mars_second_attack_displacement", "abilities/heroes/mars/mars_second_attack/modifier_mars_second_attack_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_mars_ex_second_attack_displacement", "abilities/heroes/mars/mars_second_attack/modifier_mars_ex_second_attack_displacement", LUA_MODIFIER_MOTION_BOTH)

function mars_second_attack:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_4 end
function mars_second_attack:GetPlaybackRateOverride() 	    return 1.0 end
function mars_second_attack:GetCastPointSpeed() 			return 80 end
function mars_second_attack:GetFadeGestureOnCast()		return false end

function mars_second_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = ClampPosition(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), self:GetCastRange(Vector(0,0,0), nil))
	local direction = (point - origin):Normalized()
	local radius = self:GetSpecialValueFor("radius")
	local multiplier = self:GetSpecialValueFor("multiplier")
	local damage = caster:GetAverageTrueAttackDamage(caster) * multiplier

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

		enemy:AddNewModifier(caster, self, "modifier_mars_second_attack_displacement", { 
			x = direction.x,
			y = direction.y,
			r = knockback_distance,
			speed = (knockback_distance)/0.25,
			peak = 100,
		})
	end

    self:PlayEffectsCone(direction, radius, nil, 'particles/units/heroes/hero_mars/mars_shield_bash.vpcf')
end

function mars_second_attack:PlayEffectsCone(direction, radius, color, particle_cast)
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, radius, radius))

	if color then
		ParticleManager:SetParticleControl(effect_cast, 60, color)
		ParticleManager:SetParticleControl(effect_cast, 61, Vector(1, 0, 0))
	end

	ParticleManager:SetParticleControlForward(effect_cast, 0, direction)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOnLocationWithCaster(self:GetCaster():GetOrigin(), "Hero_Mars.Shield.Cast", self:GetCaster())
end

mars_ex_second_attack.GetCastAnimationCustom = mars_second_attack.GetCastAnimationCustom
mars_ex_second_attack.GetPlaybackRateOverride = mars_second_attack.GetPlaybackRateOverride
mars_ex_second_attack.GetCastPointSpeed = mars_second_attack.GetCastPointSpeed
mars_ex_second_attack.GetFadeGestureOnCast = mars_second_attack.GetFadeGestureOnCast
mars_ex_second_attack.PlayEffectsCone = mars_second_attack.PlayEffectsCone

function mars_ex_second_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = ClampPosition(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), self:GetCastRange(Vector(0,0,0), nil))
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

		enemy:AddNewModifier(caster, self, "modifier_mars_ex_second_attack_displacement", { 
			x = m_direction.x,
			y = m_direction.y,
			r = left_distance + knockback_distance,
			speed = (left_distance + knockback_distance)/0.25,
			peak = 100,
		})
	end

    self:PlayEffectsCone(direction, radius, Vector(244, 49, 255), 'particles/econ/items/mars/mars_fall20_immortal_shield/mars_fall20_immortal_shield_bash.vpcf')
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(mars_second_attack)
Abilities.Castpoint(mars_ex_second_attack)
Abilities.Tie(mars_second_attack, 'mars_ex_second_attack')
Abilities.Tie(mars_ex_second_attack, 'mars_second_attack')