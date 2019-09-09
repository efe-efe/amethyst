tinker_ex_second_attack = class({})
LinkLuaModifier( "modifier_tinker_ex_second_attack_thinker", "abilities/heroes/tinker/tinker_ex_second_attack/modifier_tinker_ex_second_attack_thinker", LUA_MODIFIER_MOTION_NONE )

function tinker_ex_second_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("tinker_second_attack")
end

--------------------------------------------------------------------------------
-- Ability Start
function tinker_ex_second_attack:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=cast_point + 0.1, activity=ACT_DOTA_CAST_ABILITY_3, rate=1.0})
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { 
		duration = cast_point, 
		movement_speed = 10,
		radius = self:GetSpecialValueFor("radius"),
		fixed_range = 1,
	})
end


--------------------------------------------------------------------------------
-- Ability Start
function tinker_ex_second_attack:OnEndPseudoCastPoint( point )
	-- unit identifier
	local caster = self:GetCaster()

	-- create thinker
	CreateModifierThinker(
		caster,
		self,
		"modifier_tinker_ex_second_attack_thinker",
		{},
		point,
		caster:GetTeamNumber(),
		false
	)

	-- Play effects
	self:PlayEffects()

	-- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("tinker_second_attack")
	alternate_version:StartCooldown(self:GetCooldown(0))
end

--------------------------------------------------------------------------------
function tinker_ex_second_attack:PlayEffects()
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