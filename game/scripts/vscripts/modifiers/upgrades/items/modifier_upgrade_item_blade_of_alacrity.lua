modifier_upgrade_item_blade_of_alacrity = class({})

function modifier_upgrade_item_blade_of_alacrity:RemoveOnDeath() return false end
function modifier_upgrade_item_blade_of_alacrity:IsPurgable() return false end

function modifier_upgrade_item_blade_of_alacrity:OnCreated()
    self.speed_buff_pct = 15
	self.as_speed = 50
end

function modifier_upgrade_item_blade_of_alacrity:OnRefresh()
    if IsServer() then
        self:IncrementStackCount()
    end
end

function modifier_upgrade_item_blade_of_alacrity:DeclareFunctions()
    return { 
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }
end

function modifier_upgrade_item_blade_of_alacrity:GetModifierAttackSpeedBonus_Constant()
	return self.as_speed
end

function modifier_upgrade_item_blade_of_alacrity:GetModifierMoveSpeedBonus_Percentage(params)
    return self.speed_buff_pct
end

function modifier_upgrade_item_blade_of_alacrity:GetTexture()
    return 'item_blade_of_alacrity'
end