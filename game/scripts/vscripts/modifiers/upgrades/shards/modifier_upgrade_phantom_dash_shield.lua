modifier_upgrade_phantom_dash_shield = class({})
function modifier_upgrade_phantom_dash_shield:RemoveOnDeath() return false end
function modifier_upgrade_phantom_dash_shield:IsPurgable() return false end

function modifier_upgrade_phantom_dash_shield:OnCreated(params)
    self.range_bonus = 25
    if IsServer() then
        self.damage_block = 10
        self:SetStackCount(1)
    end
end

function modifier_upgrade_phantom_dash_shield:OnRefresh()
    if IsServer() then
        self:IncrementStackCount()
    end
end

function modifier_upgrade_phantom_dash_shield:GetDamageBlock(params)
    if IsServer() then
        return self:GetStackCount() * self.damage_block
    end
end

function modifier_upgrade_phantom_dash_shield:DeclareFunctions()
    return { 
        MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
    }
end

function modifier_upgrade_phantom_dash_shield:GetModifierCastRangeBonusStacking(params)
    return self:GetStackCount() * self.range_bonus
end

