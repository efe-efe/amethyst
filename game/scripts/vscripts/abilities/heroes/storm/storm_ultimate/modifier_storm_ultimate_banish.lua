modifier_storm_ultimate_banish = class({})

function modifier_storm_ultimate_banish:CheckState()
    return {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Banish(modifier_storm_ultimate_banish)