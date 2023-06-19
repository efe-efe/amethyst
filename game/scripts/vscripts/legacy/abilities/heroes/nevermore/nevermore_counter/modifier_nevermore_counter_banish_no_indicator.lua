modifier_nevermore_counter_banish_no_indicator = class({})

function modifier_nevermore_counter_banish_no_indicator:CheckState()
    return {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Banish(modifier_nevermore_counter_banish_no_indicator)