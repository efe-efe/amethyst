modifier_generic_magic_immune = class ({})

function modifier_generic_magic_immune:CheckState()
	return { [MODIFIER_STATE_MAGIC_IMMUNE] = true }
end

