modifier_phoenix_mobility_movement = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phoenix_mobility_movement:IsHidden()
	return false
end

function modifier_phoenix_mobility_movement:IsDebuff()
	return false
end

function modifier_phoenix_mobility_movement:IsStunDebuff()
	return false
end

function modifier_phoenix_mobility_movement:IsPurgable()
	return false
end
