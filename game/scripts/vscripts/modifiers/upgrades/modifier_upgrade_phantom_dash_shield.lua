modifier_upgrade_phantom_dash_shield = class({})
function modifier_upgrade_phantom_dash_shield:RemoveOnDeath() return false end
function modifier_upgrade_phantom_dash_shield:IsPurgable() return false end

function modifier_upgrade_phantom_dash_shield:OnCreated(params)
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