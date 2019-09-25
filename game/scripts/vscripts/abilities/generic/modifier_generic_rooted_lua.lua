modifier_generic_rooted_lua = class({})

--------------------------------------------------------------------------------

function modifier_generic_rooted_lua:IsDebuff()
	return true
end

function modifier_generic_rooted_lua:IsStunDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_generic_rooted_lua:CheckState()
	local state = {
	[MODIFIER_STATE_ROOTED] = true,
	}

	return state
end
--------------------------------------------------------------------------------

function modifier_generic_rooted_lua:GetEffectName()
	return "particles/econ/items/oracle/oracle_fortune_ti7/oracle_fortune_ti7_purge_root_pnt.vpcf"
end

function modifier_generic_rooted_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------
