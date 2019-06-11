modifier_tinker_ultimate_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_tinker_ultimate_lua:IsHidden()
	return false
end

function modifier_tinker_ultimate_lua:IsDebuff()
	return false
end

function modifier_tinker_ultimate_lua:IsPurgable()
	return false
end


function modifier_tinker_ultimate_lua:OnCreated()
	self.speed_buff = self:GetAbility():GetSpecialValueFor("speed_buff")
end


function modifier_tinker_ultimate_lua:OnDestroy()
	if IsServer() then
		self:GetParent():SwapAbilities( 
			"tinker_special_attack_lua",
			"tinker_ultimate_special_attack_lua",
			true,
			false
		)
	end
end


--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_tinker_ultimate_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_tinker_ultimate_lua:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff
end

-- Graphics & Animations
function modifier_tinker_ultimate_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_repel.vpcf"
end


