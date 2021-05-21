modifier_generic_phased = class({})

function modifier_generic_phased:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end