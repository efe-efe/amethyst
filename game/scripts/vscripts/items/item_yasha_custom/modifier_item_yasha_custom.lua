modifier_item_yasha_custom = class({})

function modifier_item_yasha_custom:IsHidden() 	return 	false 	end
function modifier_item_yasha_custom:IsDebuff() 	return 	false 	end
function modifier_item_yasha_custom:IsPurgable() 	return 	true 	end

function modifier_item_yasha_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_item_yasha_custom:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("ms_pct")
end

function modifier_item_yasha_custom:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_item_yasha_custom:GetStatusLabel() return "Swiftness" end
function modifier_item_yasha_custom:GetStatusPriority() return 1 end
function modifier_item_yasha_custom:GetStatusStyle() return "Swiftness" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_item_yasha_custom)