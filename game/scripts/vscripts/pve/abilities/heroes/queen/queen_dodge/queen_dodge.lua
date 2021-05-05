queen_dodge = class({})
LinkLuaModifier("modifier_queen_dodge", "pve/abilities/heroes/queen/queen_dodge/modifier_queen_dodge", LUA_MODIFIER_MOTION_NONE)

function queen_dodge:GetCastPointSpeed() 			return 0 end

function queen_dodge:OnSpellStart()
    local caster = self:GetCaster()
    local jumps = 4
    
    caster:AddNewModifier(
        caster, 
        self, 
        "modifier_queen_dodge", 
        { jumps = jumps }
    ) 
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(queen_dodge)