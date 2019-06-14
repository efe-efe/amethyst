modifier_tinker_ultimate_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_tinker_ultimate_lua:IsHidden()
	return false
end

function modifier_tinker_ultimate_lua:IsDebuff()
	return true
end

function modifier_tinker_ultimate_lua:IsPurgable()
	return true
end