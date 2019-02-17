modifier_wisp_basic_attack_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_wisp_basic_attack_lua:IsHidden()
	return false
end

function modifier_wisp_basic_attack_lua:IsDebuff()
	return true
end

function modifier_wisp_basic_attack_lua:IsPurgable()
	return false
end


--------------------------------------------------------------------------------
-- Initializations
function modifier_wisp_basic_attack_lua:OnCreated( kv )
    -- load data
    self.damage_bonus = self:GetAbility():GetSpecialValueFor("damage_bonus")
end

function modifier_wisp_basic_attack_lua:GetModifierPreAttack_BonusDamage()
    return self.damage_bonus
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_wisp_basic_attack_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}

	return funcs
end