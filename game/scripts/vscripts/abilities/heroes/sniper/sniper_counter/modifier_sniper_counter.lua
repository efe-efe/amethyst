modifier_sniper_counter = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sniper_counter:IsHidden()
	return false
end

function modifier_sniper_counter:IsDebuff()
	return false
end

function modifier_sniper_counter:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sniper_counter:OnCreated( kv )
	self.speed_buff = self:GetAbility():GetSpecialValueFor("speed_buff")
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sniper_counter:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_sniper_counter:GetModifierInvisibilityLevel()
	return 2
end

function modifier_sniper_counter:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_sniper_counter:CheckState()
	local state = {
	[MODIFIER_STATE_INVISIBLE] = true,
	[MODIFIER_STATE_TRUESIGHT_IMMUNE] = false,
	}

	return state
end
