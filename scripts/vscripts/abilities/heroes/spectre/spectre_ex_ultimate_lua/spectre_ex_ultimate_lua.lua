spectre_ex_ultimate_lua = class({})
LinkLuaModifier( "modifier_spectre_ex_ultimate_thinker_lua", "abilities/heroes/spectre/spectre_ex_ultimate_lua/modifier_spectre_ex_ultimate_thinker_lua", LUA_MODIFIER_MOTION_NONE )

function spectre_ex_ultimate_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

-- This function is used to change between abilities and ex abilities
--------------------------------------------------------------------------------
function spectre_ex_ultimate_lua:GetRelatedName()
    return "spectre_ultimate_lua"
end

--------------------------------------------------------------------------------
-- Ability Start
function spectre_ex_ultimate_lua:OnSpellStart()
    -- unit identifier
	local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    local old_origin = caster:GetOrigin()
    local max_range = self:GetSpecialValueFor("range")

    local direction = ( point - old_origin)
    if direction:Length2D() > max_range then
        direction = direction:Normalized() * max_range
    end

    self:PlayEffects()

    -- Effect thinker
    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_spectre_ex_ultimate_thinker_lua", --modifierName
        {}, --paramTable
        old_origin + direction, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )

end

--------------------------------------------------------------------------------
--Effects

--Jump
function spectre_ex_ultimate_lua:PlayEffects()
    -- Get Resources
    local sound_cast = "Hero_Spectre.Haunt"
    
    -- particles 1
    local particle_cast = "particles/units/heroes/hero_spectre/spectre_death.vpcf"
    local effect_cast = ParticleManager:CreateParticle( 
            particle_cast, 
            PATTACH_WORLDORIGIN, 
            nil 
        )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end