modifier_mana_on_attack = class ({})

function modifier_mana_on_attack:OnCreated( kv )
    --Initializers
    self.ability = self:GetAbility()
    self.mana_gain = self.ability:GetSpecialValueFor("mana_gain")
    self.mana_gain_pct = self.ability:GetSpecialValueFor("mana_gain_pct")
end

-- Not done on "OnProjectileHit" because on that moment we dont know if the attack misses or not
function modifier_mana_on_attack:GetModifierProcAttack_Feedback(kv)
    local mana = self.mana_gain == 0 and self.mana_gain_pct or self.mana_gain
    self:GetCaster():GiveManaPercent(mana)
end

--- Misc 
function modifier_mana_on_attack:IsHidden()
    return true
end

function modifier_mana_on_attack:DestroyOnExpire()
    return false
end

function modifier_mana_on_attack:IsPurgable()
    return false
end

function modifier_mana_on_attack:RemoveOnDeath()
    return false
end

function modifier_mana_on_attack:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
    }
    return funcs
end

