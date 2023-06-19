invoker_spirit_custom = class({})
LinkLuaModifier("modifier_invoker_spirit_custom", "abilities/heroes/invoker/invoker_extra/modifier_invoker_spirit_custom", LUA_MODIFIER_MOTION_NONE)

function invoker_spirit_custom:OnSpellStart()
    local caster = self:GetCaster()
    local point = ClampPosition(caster:GetAbsOrigin(), CustomAbilitiesLegacy:GetCursorPosition(self), self:GetCastRange(Vector(0,0,0), nil), nil)
    local duration = 7.0

    local spirit = CreateUnitByName(
        "npc_dota_creature_invoker_spirit_custom", 
        point, 
        true, 
        caster, 
        caster, 
        caster:GetTeam()
    )
    spirit:AddNewModifier(caster, self, "modifier_invoker_spirit_custom", { duration = duration })
end