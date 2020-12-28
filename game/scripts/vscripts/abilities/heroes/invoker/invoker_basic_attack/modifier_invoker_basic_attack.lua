modifier_invoker_basic_attack = class({})

function modifier_invoker_basic_attack:OnCreated(params)
    if IsServer() then
        self:GetParent():FindAbilityByName("invoker_empty1"):SetHidden(false)
        self:GetParent():FindAbilityByName("invoker_empty2"):SetHidden(false)
        self:SetStackCount(3)
    end
end