invoker_orb = class({})

function invoker_orb:OnAbilityPhaseStart()
    local charges = self:GetCurrentCharges()

    if charges <= 0 then
        return false
    end
    return true
end

function invoker_orb:OnSpellStart()
    self:DecrementCharges()
end

function invoker_orb:GetCurrentCharges()
    return self:GetCaster():FindModifierByName("modifier_invoker_basic_attack"):GetStackCount()
end

function invoker_orb:DecrementCharges()
    return self:GetCaster():FindModifierByName("modifier_invoker_basic_attack"):DecrementStackCount()
end