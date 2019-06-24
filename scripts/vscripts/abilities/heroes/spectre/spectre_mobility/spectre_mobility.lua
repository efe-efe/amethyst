spectre_mobility = class({})
LinkLuaModifier( "modifier_spectre_mobility_thinker", "abilities/heroes/spectre/spectre_mobility/modifier_spectre_mobility_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_mobility", "abilities/heroes/spectre/spectre_mobility/modifier_spectre_mobility", LUA_MODIFIER_MOTION_NONE )

function spectre_mobility:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function spectre_mobility:OnSpellStart()
    -- unit identifier
	local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    local delay_time = self:GetSpecialValueFor( "delay_time" )
    local old_origin = caster:GetOrigin()
    local max_range = self:GetSpecialValueFor("range")

    local direction = ( point - old_origin)
    if direction:Length2D() > max_range then
        direction = direction:Normalized() * max_range
    end

    -- Disappear spectre modifier
	caster:AddNewModifier(
		caster,
		self,
		"modifier_spectre_mobility",
		{ duration = delay_time }
	)

    -- Effect thinker
    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_spectre_mobility_thinker", --modifierName
        { }, --paramTable
        old_origin + direction, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )
    -- Put CD on the alternate version of the ability
    local ex_version = caster:FindAbilityByName("spectre_ex_mobility")
    ex_version:StartCooldown(self:GetCooldown(0))
end