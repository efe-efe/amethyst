modifier_axe_ultimate_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_axe_ultimate_lua:IsHidden()
	return false
end

function modifier_axe_ultimate_lua:IsDebuff()
	return false
end

function modifier_axe_ultimate_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_axe_ultimate_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_axe_ultimate_lua:OnCreated( kv )
		self.movement_speed = self:GetAbility():GetSpecialValueFor( "movement_speed" )
end

function modifier_axe_ultimate_lua:GetModifierMoveSpeedBonus_Percentage()
    return self.movement_speed
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_axe_ultimate_lua:GetEffectName()
	return "particles/units/heroes/hero_axe/axe_cullingblade_sprint.vpcf"
end

function modifier_axe_ultimate_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end