modifier_skywrath_mage_second_attack_reducer_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_skywrath_mage_second_attack_reducer_lua:IsHidden()
	return false
end

function modifier_skywrath_mage_second_attack_reducer_lua:IsDebuff()
	return false
end

function modifier_skywrath_mage_second_attack_reducer_lua:IsPurgable()
	return true
end

function modifier_skywrath_mage_second_attack_reducer_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--Graphics
function modifier_skywrath_mage_second_attack_reducer_lua:GetTexture()
	return "skywrath_mage_second_attack_stack_lua"
end