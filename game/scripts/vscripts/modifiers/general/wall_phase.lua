wall_phase = class({})

--------------------------------------------------------------------------------
-- Classifications
function wall_phase:IsHidden()
	return false
end

function wall_phase:IsDebuff()
	return false
end

function wall_phase:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Status Effects
function wall_phase:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end