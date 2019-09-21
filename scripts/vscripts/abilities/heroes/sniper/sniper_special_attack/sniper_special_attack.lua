sniper_special_attack = class({})
LinkLuaModifier( "modifier_sniper_shrapnel_thinker_lua", "abilities/heroes/sniper/sniper_shared_modifiers/modifier_sniper_shrapnel_thinker_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_charges_one", "abilities/generic/charges/modifier_generic_charges_one", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function sniper_special_attack:GetIntrinsicModifierName()
	return "modifier_generic_charges_one"
end

function sniper_special_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	self.radius = self:GetSpecialValueFor("radius")
	
	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.5, activity=ACT_DOTA_CAST_ABILITY_1, rate=1.5})
	caster:AddNewModifier(caster, self , "modifier_cast_point", { 
		duration = cast_point,
		movement_speed = 10,
		radius = self.radius
	})
end

function sniper_special_attack:OnCastPointEnd( point )
    local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor( "duration" )
	local delay_time = self:GetSpecialValueFor( "delay_time" )

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_sniper_shrapnel_thinker_lua",
			show_all = 1,
			radius = self.radius,
			delay_time = delay_time,
			thinker_duration = duration,
		}, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)

	-- effects
	self:PlayEffects( point )
end

--------------------------------------------------------------------------------
function sniper_special_attack:PlayEffects( point )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_sniper/sniper_shrapnel_launch.vpcf"
	local sound_cast = "Hero_Sniper.ShrapnelShoot"

	-- Get Data
	local height = 2000

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		self:GetCaster():GetOrigin(), -- unknown
		false -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 1, point + Vector( 0, 0, height ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end

