skywrath_mage_special_attack_lua = class({})
LinkLuaModifier( "modifier_skywrath_mage_special_attack_thinker_lua", "abilities/heroes/skywrath_mage/skywrath_mage_special_attack_lua/modifier_skywrath_mage_special_attack_thinker_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_projectile_slower_lua", "abilities/generic/modifier_generic_projectile_slower_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_projectile_special_behavior_lua", "abilities/generic/modifier_generic_projectile_special_behavior_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Set the aoe indicator
function skywrath_mage_special_attack_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function skywrath_mage_special_attack_lua:OnSpellStart()

	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local duration = self:GetSpecialValueFor( "duration" )
	local radius =  self:GetSpecialValueFor( "radius" )
    
    local bubble = CreateUnitByName( 
        "npc_dota_creature_skywrath_mage_bubble", -- szUnitName
        Vector(point.x, point.y, 0), -- vLocation,
        false, -- bFindClearSpace,
        caster, -- hNPCOwner,
        nil, -- hUnitOwner,
        caster:GetTeamNumber() -- iTeamNumber
    )

    bubble:SetHullRadius(radius)
    bubble:AddNewModifier(
        caster,
        self,
        "modifier_generic_projectile_special_behavior_lua",
        { duration = duration }
    )
    bubble:AddNewModifier(
        caster,
        self,
        "modifier_generic_projectile_slower_lua",
        { duration = duration }
    )
    --bubble:SetSize(Vector(point.x, point.y, 0), Vector(point.x, point.y, 0))	

    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_skywrath_mage_special_attack_thinker_lua", --modifierName
        {duration = duration}, --paramTable
        point, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )
end
