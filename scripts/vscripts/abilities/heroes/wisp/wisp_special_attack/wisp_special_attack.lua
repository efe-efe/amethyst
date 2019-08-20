wisp_special_attack = class({})
LinkLuaModifier( "modifier_wisp_special_attack_thinker", "abilities/heroes/wisp/wisp_special_attack/modifier_wisp_special_attack_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_fading_slow_lua", "abilities/generic/modifier_generic_fading_slow_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
function wisp_special_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("wisp_ex_special_attack")
end

--------------------------------------------------------------------------------
function wisp_special_attack:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_wisp_special_attack_thinker", --modifierName
        {}, --paramTable
        point, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )
    
    -- Put CD on the alternate version of the ability
    local ex_version = caster:FindAbilityByName("wisp_ex_special_attack")
	ex_version:StartCooldown(self:GetCooldown(0))
    self:PlayEffects()
end

--------------------------------------------------------------------------------

function wisp_special_attack:PlayEffects()
    -- Get Resources
    local particle_cast = "particles/mod_units/heroes/hero_wisp/wisp_relocate_marker_ti7_endpoint_core_flare.vpcf"

    local effect_cast = ParticleManager:CreateParticle( 
        particle_cast, 
        PATTACH_ABSORIGIN_FOLLOW, 
        self:GetCaster()
    )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    -- Get Resources
    local particle_cast2 = "particles/mod_units/heroes/hero_wisp/wisp_tether_hit.vpcf"

    local effect_cast2 = ParticleManager:CreateParticle( 
        particle_cast2, 
        PATTACH_ABSORIGIN_FOLLOW,
        self:GetCaster()
    )
    ParticleManager:ReleaseParticleIndex( effect_cast2 )
end