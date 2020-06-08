axe_special_attack = class({})
LinkLuaModifier("modifier_axe_special_attack_debuff", "abilities/heroes/axe/axe_special_attack/modifier_axe_special_attack_debuff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_axe_special_attack_buff", "abilities/heroes/axe/axe_special_attack/modifier_axe_special_attack_buff", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
-- Ability Start
function axe_special_attack:OnSpellStart()

	local sound_cast = "Hero_Axe.BerserkersCall.Item.Shoutmask"
	EmitSoundOn(sound_cast, self:GetCaster())

	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	self.radius = self:GetSpecialValueFor("radius")

	-- Animation and pseudo cast point
	StartAnimation(caster, {
		duration = cast_point + 0.1, 
		activity = ACT_DOTA_OVERRIDE_ABILITY_1, 
		rate = 1.5
	})
	caster:AddNewModifier(caster, self , "modifier_cast_point_old", { 
		duration = cast_point, 
		can_walk = 0,
		no_target = 1,
		radius = self.radius,
		show_all = 1,
	})
end

--------------------------------------------------------------------------------
-- Ability Start
function axe_special_attack:OnCastPointEnd()
	-- unit identifier
	local caster = self:GetCaster()
	local point = caster:GetOrigin()

	-- load data
	local duration = self:GetSpecialValueFor("duration")
	local buff_linger = self:GetSpecialValueFor("buff_linger")
	local mana_gain = self:GetSpecialValueFor("mana_gain")/100

	-- find units caught
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		point,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- call
	for _,enemy in pairs(enemies) do

		if enemy:GetAbilityByIndex(1) ~= nil then
			enemy:AddNewModifier(
				caster, -- player source
				self, -- ability source
				"modifier_axe_special_attack_debuff", -- modifier name
				{ duration = duration } -- kv
			)
		end
	end

	-- self buff
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_axe_special_attack_buff", -- modifier name
		{ duration = duration + buff_linger } -- kv
	)

	-- play effects
	if #enemies>0 then
		local sound_cast = "Hero_Axe.Berserkers_Call"
		EmitSoundOn(sound_cast, self:GetCaster())

		-- Give Mana
		local mana_gain_final = self:GetCaster():GetMaxMana() * mana_gain
		self:GetCaster():GiveMana(mana_gain_final)    
	end
	self:PlayEffects()
end


function axe_special_attack:OnStopPseudoCastPoint()
	local sound_cast = "Hero_Axe.BerserkersCall.Item.Shoutmask"
	StopSoundOn(sound_cast, self:GetCaster())
end

--------------------------------------------------------------------------------
function axe_special_attack:PlayEffects()
	-- Create Sound 
	local sound_cast = "Hero_Axe.Berserkers_Call"
	EmitSoundOn(sound_cast, self:GetCaster())

	-- Create Particle
	local particle_cast = "particles/econ/items/axe/axe_ti9_immortal/axe_ti9_beserkers_call_owner.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_mouth",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)


	-- Create Particles
	local particle_cast_b = "particles/econ/items/axe/axe_ti9_immortal/axe_ti9_call.vpcf"
	local effect_cast_b = ParticleManager:CreateParticle(particle_cast_b, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	
	ParticleManager:SetParticleControl(effect_cast_b, 0, self:GetCaster():GetOrigin())
	ParticleManager:SetParticleControl(effect_cast_b, 2, Vector(self.radius, self.radius, self.radius))
	ParticleManager:ReleaseParticleIndex(effect_cast_b)
end