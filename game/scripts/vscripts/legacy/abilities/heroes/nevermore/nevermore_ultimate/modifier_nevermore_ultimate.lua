modifier_nevermore_ultimate = class({})

function modifier_nevermore_ultimate:IsDebuff()
	return true
end

function modifier_nevermore_ultimate:IsPurgable()
	return true
end

function modifier_nevermore_ultimate:OnCreated(kv)
	self.reduction_ms_pct = -self:GetAbility():GetSpecialValueFor("reduction_ms")
end

function modifier_nevermore_ultimate:OnRefresh(kv)
	self.reduction_ms_pct = -self:GetAbility():GetSpecialValueFor("reduction_ms")
end

function modifier_nevermore_ultimate:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end


function modifier_nevermore_ultimate:GetModifierMoveSpeedBonus_Percentage()
	return self.reduction_ms_pct
end