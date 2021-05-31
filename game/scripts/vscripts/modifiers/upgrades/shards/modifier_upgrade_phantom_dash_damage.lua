modifier_upgrade_phantom_dash_damage = class({})
function modifier_upgrade_phantom_dash_damage:RemoveOnDeath() return false end
function modifier_upgrade_phantom_dash_damage:IsPurgable() return false end

function modifier_upgrade_phantom_dash_damage:OnCreated(params)
    self.range_bonus = 25
    if IsServer() then
        self.damage = 5
        self:SetStackCount(1)
    end
end

function modifier_upgrade_phantom_dash_damage:OnRefresh()
    if IsServer() then
        self:IncrementStackCount()
    end
end

function modifier_upgrade_phantom_dash_damage:GetDamage()
    if IsServer() then
        return self:GetStackCount() * self.damage
    end
end

function modifier_upgrade_phantom_dash_damage:DeclareFunctions()
    return { 
        MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
    }
end

function modifier_upgrade_phantom_dash_damage:GetModifierCastRangeBonusStacking(params)
    return self:GetStackCount() * self.range_bonus
end

