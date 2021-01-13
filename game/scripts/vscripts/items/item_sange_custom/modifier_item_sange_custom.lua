modifier_item_sange_custom = class({})

function modifier_item_sange_custom:OnCreated()
    self.think_interval = self:GetAbility():GetSpecialValueFor("think_interval")
    self.heal_per_tick = self:GetAbility():GetSpecialValueFor("heal_per_tick")
    
    if IsServer() then
        self:OnIntervalThink()
        self:StartIntervalThink(self.think_interval)
    end
end

function modifier_item_sange_custom:OnIntervalThink()
    self:GetParent():Heal(self.heal_per_tick, self:GetCaster())
end