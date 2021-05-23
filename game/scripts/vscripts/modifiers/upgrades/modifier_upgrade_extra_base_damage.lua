modifier_upgrade_extra_base_damage = class({})

function modifier_upgrade_extra_base_damage:DeclareFunctions()
    return { 
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    }
end

function modifier_upgrade_extra_base_damage:GetModifierPreAttack_BonusDamage(params)
    return 3
end
