modifier_upgrade_extra_base_damage = class({})

function modifier_upgrade_extra_base_damage:RemoveOnDeath() return false end
function modifier_upgrade_extra_base_damage:IsPurgable() return false end

function modifier_upgrade_extra_base_damage:OnCreated()
    self.damage_per_stack = 3
    if IsServer() then
        self:SetStackCount(1)
    end
end

function modifier_upgrade_extra_base_damage:OnRefresh()
    if IsServer() then
        self:IncrementStackCount()
    end
end

function modifier_upgrade_extra_base_damage:DeclareFunctions()
    return { 
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    }
end

function modifier_upgrade_extra_base_damage:GetModifierPreAttack_BonusDamage(params)
    return self:GetStackCount() * self.damage_per_stack
end
