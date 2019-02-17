wisp_ultimate_lua = class({})
LinkLuaModifier( "modifier_wisp_ultimate_thinker_lua", "abilities/heroes/wisp/wisp_ultimate_lua/modifier_wisp_ultimate_thinker_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_wisp_ultimate_lua", "abilities/heroes/wisp/wisp_ultimate_lua/modifier_wisp_ultimate_lua", LUA_MODIFIER_MOTION_NONE )

function wisp_ultimate_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function wisp_ultimate_lua:OnSpellStart()
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

    -- Dissapear wisp modifier
	caster:AddNewModifier(
		caster,
		self,
		"modifier_wisp_ultimate_lua",
		{ duration = delay_time }
	)

    -- Effect thinker
    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_wisp_ultimate_thinker_lua", --modifierName
        { old_origin =  old_origin }, --paramTable
        old_origin + direction, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )
end