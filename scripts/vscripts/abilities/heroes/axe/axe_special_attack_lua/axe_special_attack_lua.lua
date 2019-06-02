axe_special_attack_lua = class({})
LinkLuaModifier( "modifier_axe_special_attack_debuff_lua", "abilities/heroes/axe/axe_special_attack_lua/modifier_axe_special_attack_debuff_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_special_attack_buff_lua", "abilities/heroes/axe/axe_special_attack_lua/modifier_axe_special_attack_buff_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Phase Start
function axe_special_attack_lua:OnAbilityPhaseInterrupted()
	-- stop effects 
	local sound_cast = "Hero_Axe.BerserkersCall.Item.Shoutmask"
	StopSoundOn( sound_cast, self:GetCaster() )
end
function axe_special_attack_lua:OnAbilityPhaseStart()
	-- play effects 
	local sound_cast = "Hero_Axe.BerserkersCall.Item.Shoutmask"
	EmitSoundOn( sound_cast, self:GetCaster() )

	return true -- if success
end

--------------------------------------------------------------------------------
-- Ability Start
function axe_special_attack_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = caster:GetOrigin()

	-- load data
	local radius = 300--self:GetSpecialValueFor("radius")
	local duration = 2.5--self:GetSpecialValueFor("duration")

	-- find units caught
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		point,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- call
	for _,enemy in pairs(enemies) do
		enemy:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_axe_special_attack_debuff_lua", -- modifier name
			{ duration = duration } -- kv
		)
	end

	-- self buff
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_axe_special_attack_buff_lua", -- modifier name
		{ duration = 3.0 } -- kv
	)

	-- play effects
	if #enemies>0 then
		local sound_cast = "Hero_Axe.Berserkers_Call"
		EmitSoundOn( sound_cast, self:GetCaster() )
	end
	self:PlayEffects()
end

--------------------------------------------------------------------------------
function axe_special_attack_lua:PlayEffects()
	-- Create Sound 
	local sound_cast = "Hero_Axe.Berserkers_Call"
	EmitSoundOn( sound_cast, self:GetCaster() )

	-- Create Particle
	local particle_cast = "particles/units/heroes/hero_axe/axe_beserkers_call_owner.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_mouth",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end