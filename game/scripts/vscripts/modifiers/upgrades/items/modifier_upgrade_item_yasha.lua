modifier_upgrade_item_yasha = class({})

function modifier_upgrade_item_yasha:RemoveOnDeath() return false end
function modifier_upgrade_item_yasha:IsPurgable() return false end

function modifier_upgrade_item_yasha:OnCreated()
    self.speed_buff_pct = 30
	self.as_speed = 80
    self.damage = 3
end

function modifier_upgrade_item_yasha:OnRefresh()
    if IsServer() then
        self:IncrementStackCount()
    end
end

function modifier_upgrade_item_yasha:DeclareFunctions()
    return { 
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }
end

function modifier_upgrade_item_yasha:GetModifierAttackSpeedBonus_Constant()
	return self.as_speed
end

function modifier_upgrade_item_yasha:GetModifierMoveSpeedBonus_Percentage(params)
    return self.speed_buff_pct
end

function modifier_upgrade_item_yasha:GetModifierPreAttack_BonusDamage(params)
    return self.damage
end

function modifier_upgrade_item_yasha:GetTexture()
    return 'item_yasha'
end