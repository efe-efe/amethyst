spectre_mobility_lua = class({})
LinkLuaModifier( "modifier_spectre_mobility_thinker_lua", "abilities/heroes/spectre/spectre_mobility_lua/modifier_spectre_mobility_thinker_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_mobility_lua", "abilities/heroes/spectre/spectre_mobility_lua/modifier_spectre_mobility_lua", LUA_MODIFIER_MOTION_NONE )


-- This function is used to change between abilities and ex abilities
--------------------------------------------------------------------------------
function spectre_mobility_lua:GetRelatedName()
    return "spectre_ex_mobility_lua"
end

function spectre_mobility_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function spectre_mobility_lua:OnSpellStart()
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
		"modifier_spectre_mobility_lua",
		{ duration = delay_time }
	)

    -- Effect thinker
    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_spectre_mobility_thinker_lua", --modifierName
        { }, --paramTable
        old_origin + direction, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )
end