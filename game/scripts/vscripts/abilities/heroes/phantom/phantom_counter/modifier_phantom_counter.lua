modifier_phantom_counter = class({})

function modifier_phantom_counter:OnCreated(kv)
	if IsServer() then
		if self:GetParent():HasModifier("modifier_upgrade_phantom_countering_stacks") then
			local stacks = CustomEntitiesLegacy:SafeGetModifierStacks(self:GetParent(), "modifier_phantom_strike_stack")
			CustomEntitiesLegacy:SafeDestroyModifier(self:GetParent(), "modifier_phantom_strike_stack")
			self:SetStackCount((stacks/2) * self:GetParent():GetAverageTrueAttackDamage(self:GetParent()))
		end
	end

	self.as_speed = self:GetAbility():GetSpecialValueFor("as_speed")
end

function modifier_phantom_counter:GetModifierAttackSpeedBonus_Constant()
	return self.as_speed
end

function modifier_phantom_counter:DeclareFunctions()
	return { 
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}
end

function modifier_phantom_counter:GetModifierPreAttack_BonusDamage(params)
    return self:GetStackCount()
end

function modifier_phantom_counter:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_phantom_counter:GetStatusEffectName()
	return "particles/units/heroes/hero_phantom_assassin/phantom_assassin_active_blur.vpcf"
end

function modifier_phantom_counter:GetStatusLabel() return "Attack speed" end
function modifier_phantom_counter:GetStatusPriority() return 2 end
function modifier_phantom_counter:GetStatusStyle() return "BladeFury" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_phantom_counter)