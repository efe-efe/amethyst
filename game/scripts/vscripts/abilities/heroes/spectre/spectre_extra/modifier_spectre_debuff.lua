modifier_spectre_debuff = class({})

function modifier_spectre_debuff:OnCreated(params)
    local think_interval = self:GetAbility():GetSpecialValueFor("think_interval")
    self.damage_per_second = self:GetAbility():GetSpecialValueFor("damage_per_second")

    if IsServer() then
        self.damage_done = 0
        self.damage_table = {
            victim = self:GetParent(),
            attacker = self:GetCaster(),
            damage = self.damage_per_second,
            damage_type = DAMAGE_TYPE_PURE,
        }

        self:StartIntervalThink(think_interval)
    end
end

function modifier_spectre_debuff:OnIntervalThink()
    if CustomEntities:ProvidesMana(self:GetParent()) then
        self.damage_done = self.damage_done + self.damage_per_second
    end
    ApplyDamage(self.damage_table)
    self:PlayEffects()
end

function modifier_spectre_debuff:PlayEffects()
    EmitSoundOn("Hero_Spectre.Desolate", self:GetCaster())
    EmitSoundOn("Hero_Spectre.Attack", self:GetParent())

    EFX('particles/spectre/spectre_extra_impact.vpcf', PATTACH_ABSORIGIN, self:GetParent(), {
        release = true
    })
end

function modifier_spectre_debuff:OnDestroy()
    if IsServer() then
        self:GetCaster():Heal(self.damage_done, self:GetCaster())
        self:GetCaster():FindAbilityByName('spectre_extra_recast'):AddDamage(self.damage_done)
    end
end