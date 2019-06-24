modifier_spectre_basic_attack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_spectre_basic_attack:IsHidden()
	return true
end

function modifier_spectre_basic_attack:IsDebuff()
	return false
end

function modifier_spectre_basic_attack:IsPurgable()
	return false
end


--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_basic_attack:OnCreated( kv )
    -- load data
    self.damage_bonus = self:GetAbility():GetSpecialValueFor("damage_bonus")
end

function modifier_spectre_basic_attack:GetModifierPreAttack_BonusDamage()
    return self.damage_bonus
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_spectre_basic_attack:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}

	return funcs
end