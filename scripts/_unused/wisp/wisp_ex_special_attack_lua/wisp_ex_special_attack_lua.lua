wisp_ex_special_attack = class({})
LinkLuaModifier( "modifier_generic_stunned_lua", "abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_wisp_ex_special_attack_thinker", "abilities/heroes/wisp/wisp_ex_special_attack/modifier_wisp_ex_special_attack_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_wisp_guardian_essence_lua", "abilities/heroes/wisp/wisp_shared_modifiers/modifier_wisp_guardian_essence_lua/modifier_wisp_guardian_essence_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function wisp_ex_special_attack:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------

function wisp_ex_special_attack:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = caster:GetOrigin()

    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_wisp_ex_special_attack_thinker", --modifierName
        {}, --paramTable
        point, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )

    -- Put CD on the alternate version of the ability
    local alternate_version = caster:FindAbilityByName("wisp_special_attack")
	alternate_version:StartCooldown(self:GetCooldown(0))
    self:PlayEffects()
end

--------------------------------------------------------------------------------

function wisp_ex_special_attack:PlayEffects()
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