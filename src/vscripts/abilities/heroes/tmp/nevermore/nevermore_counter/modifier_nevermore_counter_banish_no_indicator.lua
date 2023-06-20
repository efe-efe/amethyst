modifier_nevermore_counter_banish_no_indicator = class({})

CheckState(){
    return {
        [ModifierState.COMMAND_RESTRICTED] = true,
	}
}

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Banish(modifier_nevermore_counter_banish_no_indicator)