modifier_upgrade_item_boots_of_elves = class({})

function modifier_upgrade_item_boots_of_elves:RemoveOnDeath() return false end
function modifier_upgrade_item_boots_of_elves:IsPurgable() return false end

function modifier_upgrade_item_boots_of_elves:OnCreated()
    self.damage = 1
	self.as_speed = 25
end

function modifier_upgrade_item_boots_of_elves:DeclareFunctions()
    return { 
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }
end

function modifier_upgrade_item_boots_of_elves:GetModifierAttackSpeedBonus_Constant()
	return self.as_speed
end

function modifier_upgrade_item_boots_of_elves:GetModifierPreAttack_BonusDamage(params)
    return self.damage
end

function modifier_upgrade_item_boots_of_elves:GetTexture(params)
    return 'item_boots_of_elves'
end