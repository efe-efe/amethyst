modifier_phantom_counter = class({})

function modifier_phantom_counter:OnCreated(kv)
	self.as_speed = self:GetAbility():GetSpecialValueFor("as_speed")
end

function modifier_phantom_counter:GetModifierAttackSpeedBonus_Constant()
	return self.as_speed
end

function modifier_phantom_counter:DeclareFunctions()
	return { MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT }
end

function modifier_phantom_counter:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_phantom_counter:GetStatusEffectName()
	return "particles/mod_units/heroes/hero_phantom_assassin/phantom_assassin_active_blur.vpcf"
end

function modifier_phantom_counter:GetStatusLabel() return "Attack speed" end
function modifier_phantom_counter:GetStatusPriority() return 2 end
function modifier_phantom_counter:GetStatusStyle() return "BladeFury" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_phantom_counter)
