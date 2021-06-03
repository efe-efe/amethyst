modifier_upgrade_item_mithril_hammer = class({})

function modifier_upgrade_item_mithril_hammer:RemoveOnDeath() return false end
function modifier_upgrade_item_mithril_hammer:IsPurgable() return false end

function modifier_upgrade_item_mithril_hammer:OnCreated()
    self.damage_per_stack = 4
end

function modifier_upgrade_item_mithril_hammer:DeclareFunctions()
    return { 
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    }
end

function modifier_upgrade_item_mithril_hammer:GetModifierPreAttack_BonusDamage(params)
    return self.damage_per_stack
end

function modifier_upgrade_item_mithril_hammer:GetTexture(params)
    return 'item_mithril_hammer'
end