sniper_special_attack = class({})
LinkLuaModifier( "modifier_sniper_shrapnel_thinker_lua", "abilities/heroes/sniper/sniper_shared_modifiers/modifier_sniper_shrapnel_thinker_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_charges_one", "abilities/generic/charges/modifier_generic_charges_one", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function sniper_special_attack:GetIntrinsicModifierName()
	return "modifier_generic_charges_one"
end

function sniper_special_attack:OnSpellStart()
	-- Initialize bariables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	local radius = self:GetSpecialValueFor("radius")
	
	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.5, activity=ACT_DOTA_CAST_ABILITY_1, rate=1.5})
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { 
		duration = cast_point,
		movement_speed = 10,
		radius = radius
	})
end

function sniper_special_attack:OnEndPseudoCastPoint( pos )
    local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor( "duration" )

    -- Effect thinker
    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_sniper_shrapnel_thinker_lua", --modifierName
        { duration = duration }, --paramTable
        pos, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )

	-- effects
	self:PlayEffects( pos )
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

