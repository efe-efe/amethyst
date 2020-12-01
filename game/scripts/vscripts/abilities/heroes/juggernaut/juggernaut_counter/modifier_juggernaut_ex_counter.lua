modifier_juggernaut_ex_counter = class({})

function modifier_juggernaut_ex_counter:IsHidden() 	return 	false 	end
function modifier_juggernaut_ex_counter:IsDebuff() 	return 	false 	end
function modifier_juggernaut_ex_counter:IsPurgable() 	return 	true 	end

function modifier_juggernaut_ex_counter:OnCreated(params)
    if IsServer() then
        self:SetStackCountClampPositioned(params.stacks)
    end
end

function modifier_juggernaut_ex_counter:OnRefresh(params)
    if IsServer() then
        self:SetStackCountClampPositioned(self:GetStackCount() + params.stacks)
    end
end

function modifier_juggernaut_ex_counter:SetStackCountClampPositioned(iStacks)
	local max_stacks = self:GetAbility():GetSpecialValueFor('max_stacks')
	if iStacks > max_stacks then
		self:SetStackCount(max_stacks)
		return
	end

	self:SetStackCount(iStacks)
end

function modifier_juggernaut_ex_counter:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_juggernaut_ex_counter:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("ms_pct") * self:GetStackCount()
end

function modifier_juggernaut_ex_counter:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_juggernaut_ex_counter:GetEffectName()
	return "particles/items2_fx/butterfly_buff.vpcf"
end

function modifier_juggernaut_ex_counter:GetStatusLabel() return "Swiftslash" end
function modifier_juggernaut_ex_counter:GetStatusPriority() return 1 end
function modifier_juggernaut_ex_counter:GetStatusStyle() return "Swiftness" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_juggernaut_ex_counter)