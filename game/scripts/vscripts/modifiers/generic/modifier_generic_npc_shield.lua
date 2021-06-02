modifier_generic_npc_shield = class({})

function modifier_generic_npc_shield:GetTexture()
    return "modifier_shield"
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Shield(modifier_generic_npc_shield)