modifier_skywrath_mage_ultimate_lua = class({})
LinkLuaModifier( "modifier_skywrath_mage_ultimate_thinker_lua", "abilities/heroes/skywrath_mage/skywrath_mage_ultimate_lua/modifier_skywrath_mage_ultimate_thinker_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function modifier_skywrath_mage_ultimate_lua:IsDebuff()
	return false
end

function modifier_skywrath_mage_ultimate_lua:IsHidden()
	return true
end

function modifier_skywrath_mage_ultimate_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_skywrath_mage_ultimate_lua:OnCreated( kv )
    -- load data
    self.damage = self:GetAbility():GetSpecialValueFor("damage_bonus")

    self:StartIntervalThink(1.0)
end


--------------------------------------------------------------------------------
-- Interval Effects
function modifier_skywrath_mage_ultimate_lua:OnIntervalThink()
	-- unit identifier
	local caster = self:GetParent()
    local point = self:GetAbility():GetCursorPosition()
    DebugPrint(point)
    local duration = 5.0--self:GetSpecialValueFor( "duration" )

    CreateModifierThinker(
        caster, --hCaster
        self:GetAbility(), --hAbility
        "modifier_skywrath_mage_ultimate_thinker_lua", --modifierName
        {duration = duration}, --paramTable
        point, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )
end