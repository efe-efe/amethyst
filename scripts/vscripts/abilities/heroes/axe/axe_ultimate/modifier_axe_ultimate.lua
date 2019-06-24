modifier_axe_ultimate = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_axe_ultimate:IsHidden()
	return false
end

function modifier_axe_ultimate:IsDebuff()
	return false
end

function modifier_axe_ultimate:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_axe_ultimate:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_axe_ultimate:OnCreated( kv )
		self.movement_speed = self:GetAbility():GetSpecialValueFor( "movement_speed" )
end

function modifier_axe_ultimate:GetModifierMoveSpeedBonus_Percentage()
    return self.movement_speed
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_axe_ultimate:GetEffectName()
	return "particles/econ/items/axe/ti9_jungle_axe/ti9_jungle_axe_culling_blade_sprint.vpcf"
end

function modifier_axe_ultimate:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end