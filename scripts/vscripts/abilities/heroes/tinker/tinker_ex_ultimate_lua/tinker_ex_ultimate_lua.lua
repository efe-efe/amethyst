tinker_ex_ultimate_lua = class({})
LinkLuaModifier( "modifier_tinker_ex_ultimate_thinker_lua", "abilities/heroes/tinker/tinker_ex_ultimate_lua/modifier_tinker_ex_ultimate_thinker_lua", LUA_MODIFIER_MOTION_NONE )

function tinker_ex_ultimate_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function tinker_ex_ultimate_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- create thinker
	CreateModifierThinker(
		caster,
		self,
		"modifier_tinker_ex_ultimate_thinker_lua",
		{},
		point,
		caster:GetTeamNumber(),
		false
	)

	-- Play effects
	self:PlayEffects()
end

--------------------------------------------------------------------------------
function tinker_ex_ultimate_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_tinker/tinker_motm.vpcf"
	local sound_cast = "Hero_Tinker.March_of_the_Machines.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationForAllies( self:GetCaster():GetOrigin(), sound_cast, self:GetCaster() )
end