modifier_upgrade_item_belt_of_strength = class({})

function modifier_upgrade_item_belt_of_strength:RemoveOnDeath() return false end
function modifier_upgrade_item_belt_of_strength:IsPurgable() return false end

function modifier_upgrade_item_belt_of_strength:OnCreated()
    self.extra_health = 50
end

function modifier_upgrade_item_belt_of_strength:DeclareFunctions()
    return { 
		MODIFIER_PROPERTY_HEALTH_BONUS,
    }
end

function modifier_upgrade_item_belt_of_strength:GetModifierHealthBonus()
	return self:GetStackCount() * self.extra_health
end

function modifier_upgrade_item_belt_of_strength:GetTexture()
	return "item_belt_of_strength"
end
