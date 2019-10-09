modifier_phantom_counter_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phantom_counter_buff:IsHidden()
	return false
end

function modifier_phantom_counter_buff:IsDebuff()
	return false
end

function modifier_phantom_counter_buff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_phantom_counter_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_phantom_counter_buff:OnCreated( kv )
	self.movement_speed = self:GetAbility():GetSpecialValueFor( "movement_speed" )
	
	if IsServer() then
		ProgressBars:AddProgressBar(self:GetParent(), self:GetName(), {
			style = "Generic",
			text = "haste",
			progressBarType = "duration",
			priority = 1,
		})
	end
end

function modifier_phantom_counter_buff:GetModifierMoveSpeedBonus_Percentage()
    return self.movement_speed
end

--Graphics & Animations
function modifier_phantom_counter_buff:GetEffectName()
	return "particles/econ/items/axe/ti9_jungle_axe/ti9_jungle_axe_culling_blade_sprint.vpcf"
end

function modifier_phantom_counter_buff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_phantom_counter_buff:GetStatusEffectName()
	return "particles/status_fx/status_effect_phantom_assassin_active_blur.vpcf"
end