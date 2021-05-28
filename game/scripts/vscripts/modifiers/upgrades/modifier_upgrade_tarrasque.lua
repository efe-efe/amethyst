modifier_upgrade_tarrasque = class({})

function modifier_upgrade_tarrasque:RemoveOnDeath() return false end
function modifier_upgrade_tarrasque:IsPurgable() return false end

function modifier_upgrade_tarrasque:OnCreated()
    self.extra_health = 50
    if IsServer() then
        self:SetStackCount(1)
    end
end

function modifier_upgrade_tarrasque:OnRefresh()
    if IsServer() then
        self:IncrementStackCount()
    end
end

function modifier_upgrade_tarrasque:DeclareFunctions()
    return { 
		MODIFIER_PROPERTY_HEALTH_BONUS,
    }
end

function modifier_upgrade_tarrasque:GetModifierHealthBonus()
	return self:GetStackCount() * self.extra_health
end