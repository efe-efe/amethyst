modifier_generic_provides_vision = class({})

--------------------------------------------------------------------------------

function modifier_generic_provides_vision:IsDebuff()
	return false
end

function modifier_generic_provides_vision:IsHidden()
	return true
end

function modifier_generic_provides_vision:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
function modifier_generic_provides_vision:CheckState()
	local state = {
	    [MODIFIER_STATE_PROVIDES_VISION] = true,
	}

	return state
end
