sniper_special_attack_lua = class({})
LinkLuaModifier( "modifier_sniper_shrapnel_thinker_lua", "abilities/heroes/sniper/sniper_shared_modifiers/modifier_sniper_shrapnel_thinker_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_special_attack_charges_lua", "abilities/heroes/sniper/sniper_special_attack_lua/modifier_sniper_special_attack_charges_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function sniper_special_attack_lua:GetIntrinsicModifierName()
	return "modifier_sniper_special_attack_charges_lua"
end
--------------------------------------------------------------------------------
-- Set the aoe indicator
function sniper_special_attack_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

function sniper_special_attack_lua:OnSpellStart()
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor( "duration" )

    -- Effect thinker
    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_sniper_shrapnel_thinker_lua", --modifierName
        { duration = duration }, --paramTable
        point, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )

	-- effects
	self:PlayEffects( point )
end

--------------------------------------------------------------------------------
function sniper_special_attack_lua:PlayEffects( point )
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

