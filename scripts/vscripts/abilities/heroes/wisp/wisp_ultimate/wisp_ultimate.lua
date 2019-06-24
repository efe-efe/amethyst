wisp_ultimate = class({})
LinkLuaModifier( "modifier_wisp_ultimate_thinker", "abilities/heroes/wisp/wisp_ultimate/modifier_wisp_ultimate_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_wisp_ultimate", "abilities/heroes/wisp/wisp_ultimate/modifier_wisp_ultimate", LUA_MODIFIER_MOTION_NONE )

function wisp_ultimate:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function wisp_ultimate:OnSpellStart()
    -- unit identifier
	local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    local delay_time = self:GetSpecialValueFor( "delay_time" )
    local old_origin = caster:GetOrigin()
    local max_range = self:GetSpecialValueFor("range")
    local linked_unit = SafeGetModifierCaster( "modifier_wisp_basic_attack_link", caster )

    local direction = ( point - old_origin)
    if direction:Length2D() > max_range then
        direction = direction:Normalized() * max_range
    end

    -- Dissapear wisp modifier
	caster:AddNewModifier(
		caster,
		self,
		"modifier_wisp_ultimate",
		{ duration = delay_time }
	)

    if linked_unit ~= nil then
        linked_unit:AddNewModifier(
            caster,
            self,
            "modifier_wisp_ultimate",
            { duration = delay_time }
        )
    end
    
    -- Effect thinker
    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_wisp_ultimate_thinker", --modifierName
        { }, --paramTable
        old_origin + direction, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )

    self:PlayEffects()
end

function wisp_ultimate:PlayEffects()
    EmitGlobalSound("wisp_death")
end