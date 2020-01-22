spectre_extra = class({})
LinkLuaModifier( "modifier_spectre_extra_thinker", "abilities/heroes/spectre/spectre_extra/modifier_spectre_extra_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_extra", "abilities/heroes/spectre/spectre_extra/modifier_spectre_extra", LUA_MODIFIER_MOTION_NONE )

function spectre_extra:HasPriority()
    return true
end

--------------------------------------------------------------------------------
function spectre_extra:OnCastPointEnd()
    -- unit identifier
	local caster = self:GetCaster()
	local delay_time = self:GetSpecialValueFor( "delay_time" )
	local radius = self:GetSpecialValueFor( "radius" )
	local point = CalcPoint(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)


    caster:AddNewModifier(
        caster,
        self,
        "modifier_spectre_extra",
        { duration = delay_time }
    )

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
    -- Get Resources
    EmitSoundOn( "Hero_Spectre.Reality", self:GetCaster() )

    local particle_cast = "particles/units/heroes/hero_spectre/spectre_death.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	spectre_extra,
	{ activity = ACT_DOTA_ATTACK, rate = 1.0 },
	{ movement_speed = 10 }
)