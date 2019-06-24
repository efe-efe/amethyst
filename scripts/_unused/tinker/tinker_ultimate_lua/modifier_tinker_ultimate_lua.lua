modifier_tinker_ultimate = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_tinker_ultimate:IsHidden()
	return false
end

function modifier_tinker_ultimate:IsDebuff()
	return false
end

function modifier_tinker_ultimate:IsPurgable()
	return false
end


function modifier_tinker_ultimate:OnCreated()
	self.speed_buff = self:GetAbility():GetSpecialValueFor("speed_buff")
end


function modifier_tinker_ultimate:OnDestroy()
	if IsServer() then
		self:GetParent():SwapAbilities( 
			"tinker_special_attack",
			"tinker_ultimate_special_attack_lua",
			true,
			false
		)
	end
end


--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_tinker_ultimate:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_tinker_ultimate:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff
end

-- Graphics & Animations
function modifier_tinker_ultimate:GetStatusEffectName()
	return "particles/status_fx/status_effect_repel.vpcf"
end


