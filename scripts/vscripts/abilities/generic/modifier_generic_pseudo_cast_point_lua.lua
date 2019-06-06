modifier_generic_pseudo_cast_point_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_pseudo_cast_point_lua:IsHidden()
	return true
end

function modifier_generic_pseudo_cast_point_lua:IsDebuff()
	return true
end

function modifier_generic_pseudo_cast_point_lua:IsStunDebuff()
	return false
end

function modifier_generic_pseudo_cast_point_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Modifier State
function modifier_generic_pseudo_cast_point_lua:CheckState()
	local state = {
		[MODIFIER_STATE_SILENCED] = true,
	}

	return state
end