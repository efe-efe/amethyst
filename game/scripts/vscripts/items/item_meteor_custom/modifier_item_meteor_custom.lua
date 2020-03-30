modifier_item_meteor_custom = class({})

function modifier_item_meteor_custom:OnCreated()
    if IsServer() then
        self.damage_per_tick = self:GetAbility():GetSpecialValueFor("damage_per_tick")
        self.think_interval = self:GetAbility():GetSpecialValueFor("think_interval")

        self:StartIntervalThink( self.think_interval )
    end
end

function modifier_item_meteor_custom:OnIntervalThink()
    local damage_table = {
        victim = self:GetParent(),
        attacker = self:GetCaster(),
        damage = self.damage_per_tick,
        damage_type = DAMAGE_TYPE_PURE,
    }
    ApplyDamage( damage_table )
end

function modifier_item_meteor_custom:GetEffectName()
    return "particles/items4_fx/meteor_hammer_spell_debuff.vpcf"
end