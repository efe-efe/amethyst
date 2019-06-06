modifier_sniper_counter_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sniper_counter_lua:IsHidden()
	return false
end

function modifier_sniper_counter_lua:IsDebuff()
	return false
end

function modifier_sniper_counter_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sniper_counter_lua:OnCreated( kv )
		self.speed_buff = self:GetAbility():GetSpecialValueFor("speed_buff")
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sniper_counter_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_sniper_counter_lua:GetModifierInvisibilityLevel()
	return 2
end

function modifier_sniper_counter_lua:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_sniper_counter_lua:CheckState()
	local state = {
	[MODIFIER_STATE_INVISIBLE] = true,
	[MODIFIER_STATE_TRUESIGHT_IMMUNE] = false,
	}

	return state
end
