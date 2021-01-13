modifier_juggernaut_ultimate_banish = class({})

function modifier_juggernaut_ultimate_banish:CheckState()
    return {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
    }
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Banish(modifier_juggernaut_ultimate_banish)
