modifier_upgrade_extra_speed = class({})

function modifier_upgrade_extra_speed:RemoveOnDeath() return false end
function modifier_upgrade_extra_speed:IsPurgable() return false end

function modifier_upgrade_extra_speed:OnCreated()
    self.speed_buff_pct = 10
	self.as_speed = 50
    if IsServer() then
        self:SetStackCount(1)
    end
end

function modifier_upgrade_extra_speed:OnRefresh()
    if IsServer() then
        self:IncrementStackCount()
    end
end

function modifier_upgrade_extra_speed:DeclareFunctions()
    return { 
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }
end

function modifier_upgrade_extra_speed:GetModifierAttackSpeedBonus_Constant()
	return self:GetStackCount() * self.as_speed
end

function modifier_upgrade_extra_speed:GetModifierMoveSpeedBonus_Percentage(params)
    return self:GetStackCount() * self.speed_buff_pct
end
