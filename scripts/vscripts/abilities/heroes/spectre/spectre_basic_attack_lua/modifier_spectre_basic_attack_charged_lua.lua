modifier_spectre_basic_attack_charged_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_spectre_basic_attack_charged_lua:IsHidden()
	return false
end

function modifier_spectre_basic_attack_charged_lua:IsDebuff()
	return false
end

function modifier_spectre_basic_attack_charged_lua:IsPurgable()
	return false
end


--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_basic_attack_charged_lua:OnCreated( kv )
    -- load data
    self.damage_bonus = self:GetAbility():GetSpecialValueFor("damage_bonus")
end

function modifier_spectre_basic_attack_charged_lua:GetModifierPreAttack_BonusDamage()
    return self.damage_bonus
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_spectre_basic_attack_charged_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}

	return funcs
end