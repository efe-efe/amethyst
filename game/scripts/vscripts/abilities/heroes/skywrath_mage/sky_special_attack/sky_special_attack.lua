sky_special_attack = class({})
LinkLuaModifier( "modifier_sky_special_attack_thinker", "abilities/heroes/skywrath_mage/sky_special_attack/modifier_sky_special_attack_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_projectile_slower_lua", "abilities/generic/modifier_generic_projectile_slower_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_projectile_special_behavior_lua", "abilities/generic/modifier_generic_projectile_special_behavior_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function sky_special_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
    self.radius =  self:GetSpecialValueFor( "radius" )

	-- Animation and pseudo cast point
	StartAnimation(caster, { 
        duration = cast_point + 0.1, 
        activity = ACT_DOTA_CAST_ABILITY_2, 
        rate = 1.2
    })
	caster:AddNewModifier(
        caster, 
        self,
        "modifier_cast_point", 
        {
            duration = cast_point,
            radius = self.radius,
            movement_speed = 10,
        }
    )
end

--------------------------------------------------------------------------------
-- Ability Start
function sky_special_attack:OnCastPointEnd( point )

	-- unit identifier
	local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor( "duration" )
    
    local bubble = CreateUnitByName( 
        "npc_dota_creature_skywrath_mage_bubble", -- szUnitName
        point, -- vLocation,
        false, -- bFindClearSpace,
        caster, -- hNPCOwner,
        nil, -- hUnitOwner,
        caster:GetTeamNumber() -- iTeamNumber
    )

    bubble:SetHullRadius(self.radius)
    bubble:Attribute_SetIntValue("dummy", 1)
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
        "modifier_sky_special_attack_thinker", --modifierName
        {duration = duration}, --paramTable
        point, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )
end
