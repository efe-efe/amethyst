spectre_extra = class({})
LinkLuaModifier( "modifier_spectre_extra_thinker", "abilities/heroes/spectre/spectre_extra/modifier_spectre_extra_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
function spectre_extra:OnCastPointEnd()
    -- unit identifier
	local caster = self:GetCaster()
	local delay_time = self:GetSpecialValueFor( "delay_time" )
	local radius = self:GetSpecialValueFor( "radius" )
	local point = CalcRange(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_spectre_extra_thinker",
			show_all = 1,
			radius = radius,
			delay_time = delay_time,
		}, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
	
    self:PlayEffects()
end

--------------------------------------------------------------------------------
--Effects
function spectre_extra:PlayEffects()
	EmitSoundOn("spectre_spec_redux_firstblood_02", self:GetCaster())

    local particle_cast = "particles/units/heroes/hero_spectre/spectre_death.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	spectre_extra,
	{ activity = ACT_DOTA_GENERIC_CHANNEL_1, rate = 1.0 },
	{ movement_speed = 10 }
)