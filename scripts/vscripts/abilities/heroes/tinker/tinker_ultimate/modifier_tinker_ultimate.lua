modifier_tinker_ultimate = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_tinker_ultimate:IsHidden()
	return false
end

function modifier_tinker_ultimate:IsDebuff()
	return true
end

function modifier_tinker_ultimate:IsPurgable()
	return true
end