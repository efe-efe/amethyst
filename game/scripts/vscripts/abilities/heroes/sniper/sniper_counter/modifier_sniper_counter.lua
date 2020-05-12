modifier_sniper_counter = class({})

function modifier_sniper_counter:IsHidden() 	return 	false 	end
function modifier_sniper_counter:IsDebuff() 	return 	false 	end
function modifier_sniper_counter:IsPurgable() 	return 	true 	end

function modifier_sniper_counter:OnCreated( kv )
	self.speed_buff_pct = self:GetAbility():GetSpecialValueFor("speed_buff_pct")
end

function modifier_sniper_counter:OnDestroy( kv )
	if IsServer() then 
		self:GetAbility():StartCooldown(self:GetAbility():GetCooldown(0))
	end
end

function modifier_sniper_counter:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_sniper_counter:GetModifierInvisibilityLevel()
	return 2
end

function modifier_sniper_counter:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff_pct
end

function modifier_sniper_counter:CheckState()
	return {
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_TRUESIGHT_IMMUNE] = false,
	}
end

function modifier_sniper_counter:GetStatusLabel() return "Invisibile" end
function modifier_sniper_counter:GetStatusPriority() return 1 end
function modifier_sniper_counter:GetStatusStyle() return "Invisible" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_sniper_counter)