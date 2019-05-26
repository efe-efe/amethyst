modifier_phantom_assassin_mobility_lua = class({})

--------------------------------------------------------------------------------
function modifier_phantom_assassin_mobility_lua:IsDebuff()
	return false
end

function modifier_phantom_assassin_mobility_lua:IsHidden()
	return false
end

function modifier_phantom_assassin_mobility_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_phantom_assassin_mobility_lua:OnCreated( kv )
	if IsServer() then
		-- references
		self.attack_speed_bonus = self:GetAbility():GetSpecialValueFor("attack_speed_bonus")
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_phantom_assassin_mobility_lua:GetModifierAttackSpeedBonus_Constant()
	return self.attack_speed_bonus
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_phantom_assassin_mobility_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

