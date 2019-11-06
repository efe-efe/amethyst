modifier_phantom_counter = class({})

--------------------------------------------------------------------------------
-- Initializations
function modifier_phantom_counter:OnCreated( kv )
	self.as_speed = self:GetAbility():GetSpecialValueFor("as_speed")

	if IsServer() then
		self:GetParent():AddStatusBar({
            label = "Attack speed", modifier = self, priority = 2, 
		}) 
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_phantom_counter:GetModifierAttackSpeedBonus_Constant()
	return self.as_speed
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_phantom_counter:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end



function modifier_phantom_counter:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_phantom_counter:GetStatusEffectName()
	return "particles/mod_units/heroes/hero_phantom_assassin/phantom_assassin_active_blur.vpcf"
end
