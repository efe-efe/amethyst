modifier_mars_ex_basic_attack = class({})

function modifier_mars_ex_basic_attack:OnCreated(params)
    if IsServer() then
        local think_interval = self:GetAbility():GetSpecialValueFor('think_interval')
        self.heal_per_tick = self:GetAbility():GetSpecialValueFor('heal_per_tick')
        self.efx = EFX('particles/items5_fx/essence_ring.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), {})
        self:StartIntervalThink(think_interval)
    end
end


function modifier_mars_ex_basic_attack:OnIntervalThink()
    self:GetParent():Heal(self.heal_per_tick, self:GetParent())
end


function modifier_mars_ex_basic_attack:OnDestroy()
    if IsServer() then
        DEFX(self.efx, false)
    end
end
