modifier_phoenix_ex_counter_mark = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phoenix_ex_counter_mark:IsDebuff()
	return true
end

function modifier_phoenix_ex_counter_mark:IsHidden()
	return false
end

function modifier_phoenix_ex_counter_mark:IsPurgable()
	return false
end
