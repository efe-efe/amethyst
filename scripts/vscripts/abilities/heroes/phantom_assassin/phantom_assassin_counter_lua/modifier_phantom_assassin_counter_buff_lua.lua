modifier_phantom_assassin_counter_buff_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phantom_assassin_counter_buff_lua:IsHidden()
	return false
end

function modifier_phantom_assassin_counter_buff_lua:IsDebuff()
	return false
end

function modifier_phantom_assassin_counter_buff_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_phantom_assassin_counter_buff_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_phantom_assassin_counter_buff_lua:OnCreated( kv )
		self.movement_speed = self:GetAbility():GetSpecialValueFor( "movement_speed" )
end

function modifier_phantom_assassin_counter_buff_lua:GetModifierMoveSpeedBonus_Percentage()
    return self.movement_speed
end

--Graphics & Animations
function modifier_phantom_assassin_counter_buff_lua:GetEffectName()
	return "particles/econ/items/axe/ti9_jungle_axe/ti9_jungle_axe_culling_blade_sprint.vpcf"
end

function modifier_phantom_assassin_counter_buff_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end