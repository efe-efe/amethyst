modifier_charge_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_charge_buff:IsHidden() return false
end

function modifier_charge_buff:IsDebuff() return false
end

function modifier_charge_buff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_charge_buff:OnCreated( kv )
	self.speed_buff_pct = self:GetAbility():GetSpecialValueFor( "speed_buff_pct" )
	
	if IsServer() then
		self:GetParent():AddStatusBar({
            label = "Haste", modifier = self, priority = 1, 
        }) 
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_charge_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_charge_buff:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff_pct
end

--------------------------------------------------------------------------------
--Graphics & Animations
function modifier_charge_buff:GetEffectName()
	return "particles/econ/items/spirit_breaker/spirit_breaker_iron_surge/spirit_breaker_charge_foot_glow_iron.vpcf"
end

function modifier_charge_buff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end