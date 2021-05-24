modifier_upgrade_extra_movement_speed = class({})

function modifier_upgrade_extra_movement_speed:RemoveOnDeath() return false end
function modifier_upgrade_extra_movement_speed:IsPurgable() return false end

function modifier_upgrade_extra_movement_speed:OnCreated()
    self.speed_buff_pct = 20
    if IsServer() then
        self:SetStackCount(1)
    end
end

function modifier_upgrade_extra_movement_speed:OnRefresh()
    if IsServer() then
        self:IncrementStackCount()
    end
end

function modifier_upgrade_extra_movement_speed:DeclareFunctions()
    return { 
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end

function modifier_upgrade_extra_movement_speed:GetModifierMoveSpeedBonus_Percentage(params)
    return self:GetStackCount() * self.speed_buff_pct
end
