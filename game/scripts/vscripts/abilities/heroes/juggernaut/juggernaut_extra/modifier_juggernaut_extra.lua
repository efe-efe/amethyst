modifier_juggernaut_extra = class({})

function modifier_juggernaut_extra:OnCreated(params)
    self.heal_per_second = self:GetAbility():GetSpecialValueFor("heal_per_second")

    if IsServer() then
        self:OnIntervalThink()
        self:StartIntervalThink(1.0)
    end
end

function modifier_juggernaut_extra:OnIntervalThink()	
    self:GetParent():Heal(self.heal_per_second, self:GetCaster())
end