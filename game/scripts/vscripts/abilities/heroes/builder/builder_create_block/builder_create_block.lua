builder_create_block = class({})
LinkLuaModifier( "wall_base", "abilities/heroes/builder/builder_create_block/wall_base", LUA_MODIFIER_MOTION_NONE )

function builder_create_block:OnSpellStart()
    local point = self:GetCursorPosition()

    local wall = CreateUnitByName(
        "npc_dota_creature_wall", --szUnitName
        point, --vLocation
        false, --bFindClearSpace
        nil, --hNPCOwner
        nil, --hUnitOwner
        self:GetCaster():GetTeamNumber()--DOTA_TEAM_NOTEAM
    )
    wall:Attribute_SetIntValue("barrel", 1)
    wall:SetHullRadius(180)
    wall:AddNewModifier(self:GetCaster(), self, "wall_base", {})
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	builder_create_block,
    { activity = ACT_DOTA_ATTACK, rate = 1.3 },
	{ movement_speed = 10, hide_indicator = 1, fixed_range = 1 }
)