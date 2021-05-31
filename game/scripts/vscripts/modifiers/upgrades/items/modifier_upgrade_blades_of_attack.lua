modifier_upgrade_blades_of_attack = class({})

function modifier_upgrade_blades_of_attack:RemoveOnDeath() return false end
function modifier_upgrade_blades_of_attack:IsPurgable() return false end

function modifier_upgrade_blades_of_attack:OnCreated()
    self.damage_per_stack = 2
end

function modifier_upgrade_blades_of_attack:DeclareFunctions()
    return { 
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    }
end

function modifier_upgrade_blades_of_attack:GetModifierPreAttack_BonusDamage(params)
    return self.damage_per_stack
end

function modifier_upgrade_blades_of_attack:GetTexture(params)
    return 'item_blades_of_attack'
end