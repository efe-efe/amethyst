modifier_invoker_walk_custom = class({})

function modifier_invoker_walk_custom:IsHidden() 	return 	false 	end
function modifier_invoker_walk_custom:IsDebuff() 	return 	false 	end
function modifier_invoker_walk_custom:IsPurgable() 	return 	true 	end

function modifier_invoker_walk_custom:OnCreated(kv)
	self.speed_buff_pct = self:GetAbility():GetSpecialValueFor("speed_buff_pct")
end

function modifier_invoker_walk_custom:OnDestroy(kv)
	if IsServer() then 
		self:GetAbility():StartCooldown(self:GetAbility():GetCooldown(0))
	end
end

function modifier_invoker_walk_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_invoker_walk_custom:GetModifierInvisibilityLevel()
	return 2
end

function modifier_invoker_walk_custom:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff_pct
end

function modifier_invoker_walk_custom:CheckState()
	return {
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_TRUESIGHT_IMMUNE] = false,
	}
end

function modifier_invoker_walk_custom:GetStatusLabel() return "Ghost Walk" end
function modifier_invoker_walk_custom:GetStatusPriority() return 1 end
function modifier_invoker_walk_custom:GetStatusStyle() return "GhostWalk" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_invoker_walk_custom)