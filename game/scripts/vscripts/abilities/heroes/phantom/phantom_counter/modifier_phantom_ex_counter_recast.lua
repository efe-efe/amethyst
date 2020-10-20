modifier_phantom_ex_counter_recast = class({})

function modifier_phantom_ex_counter_recast:IsHidden() 	return 	false 	end
function modifier_phantom_ex_counter_recast:IsDebuff() 	return 	false 	end
function modifier_phantom_ex_counter_recast:IsPurgable() 	return 	true 	end

function modifier_phantom_ex_counter_recast:OnCreated(kv)
	self.speed_buff_pct = self:GetAbility():GetSpecialValueFor("speed_buff_pct")
end

function modifier_phantom_ex_counter_recast:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_phantom_ex_counter_recast:GetModifierInvisibilityLevel()
	return 2
end

function modifier_phantom_ex_counter_recast:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff_pct
end

function modifier_phantom_ex_counter_recast:CheckState()
	return {
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_TRUESIGHT_IMMUNE] = false,
	}
end

function modifier_phantom_ex_counter_recast:GetRecastAbility()
    if IsServer() then
        return self:GetParent():FindAbilityByName("phantom_ex_counter_recast") 
    end
end

function modifier_phantom_ex_counter_recast:GetRecastCharges()
	return 1
end

function modifier_phantom_ex_counter_recast:GetRecastKey()
	return "2"
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast(modifier_phantom_ex_counter_recast)
