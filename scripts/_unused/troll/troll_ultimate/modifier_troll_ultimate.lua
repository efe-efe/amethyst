modifier_troll_ultimate = class({})
--------------------------------------------------------------------------------
function modifier_troll_ultimate:IsDebuff()
	return false
end

function modifier_troll_ultimate:IsHidden()
	return false
end

function modifier_troll_ultimate:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_troll_ultimate:OnCreated( kv )
	if IsServer() then
		-- references
		self.attack_speed_bonus = 200--self:GetAbility():GetSpecialValueFor("attack_speed_bonus")
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_troll_ultimate:GetModifierAttackSpeedBonus_Constant()
	return self.attack_speed_bonus
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_troll_ultimate:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

