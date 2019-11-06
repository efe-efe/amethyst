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
    wall:Attribute_SetIntValue("wall", 1)
    wall:SetHullRadius(180)
    wall:AddNewModifier(self:GetCaster(), self, "wall_base", {})
end