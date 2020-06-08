modifier_terrorblade_special_attack_thinker = class({})

function modifier_terrorblade_special_attack_thinker:OnCreated()
    if IsServer() then
        self.delay_time = self:GetAbility():GetSpecialValueFor("delay_time")
        self:StartIntervalThink(self.delay_time)
    end
end

function modifier_terrorblade_special_attack_thinker:OnIntervalThink()
    self:GetAbility():OnDelayEnds()
    self:Destroy()
end
