skywrath_mage_special_attack_lua = class({})
LinkLuaModifier( "modifier_skywrath_mage_special_attack_thinker_lua", "abilities/heroes/skywrath_mage/skywrath_mage_special_attack_lua/modifier_skywrath_mage_special_attack_thinker_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_projectile_blocker_lua", "abilities/generic/modifier_generic_projectile_blocker_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

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
        point, -- vLocation,
        true, -- bFindClearSpace,
        nil, -- hNPCOwner,
        nil, -- hUnitOwner,
        caster:GetTeamNumber() -- iTeamNumber
    )

    bubble:SetHullRadius(radius - 40.0)
    bubble:AddNewModifier(
        caster,
        self,
        "modifier_generic_projectile_blocker_lua",
        { duration = duration }
    )
    
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
