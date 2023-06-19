modifier_nevermore_special_attack_thinker = class({})

function modifier_nevermore_special_attack_thinker:OnCreated(params)
    self.caster = self:GetCaster()
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    local delay_time = self:GetAbility():GetSpecialValueFor("delay_time")
    self.origin = self:GetParent():GetAbsOrigin()
    self.mana_gain_pct = self:GetAbility():GetSpecialValueFor("mana_gain_pct")
    self.damage_per_stack = self:GetAbility():GetSpecialValueFor("damage_per_stack")
    self.stacks_duration = self:GetAbility():GetSpecialValueFor("stacks_duration")
    self.damage_table = {
        attacker = self.caster,
        damage = self:GetAbility():GetSpecialValueFor("ability_damage"),
        damage_type = DAMAGE_TYPE_PURE,
    }
    
    if IsServer() then
        CreateTimedRadiusMarker(self.caster, self.origin, self.radius, self:GetDuration(), 0.2, RADIUS_SCOPE_PUBLIC)
        self:StartIntervalThink(delay_time)
    end
end

function modifier_nevermore_special_attack_thinker:OnIntervalThink()
    local give_mana = false

    ApplyCallbackForUnitsInArea(self.caster, self.origin, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
        local modifier = unit:FindModifierByName('modifier_nevermore_special_attack_stacks') 
        local stacks = 0

        if modifier then
            stacks = modifier:GetStackCount()
        end

        self.damage_table.victim = unit
        self.damage_table.damage = self.damage_table.damage + (self.damage_per_stack * stacks)
        ApplyDamage(self.damage_table)

        unit:AddNewModifier(self.caster, self:GetAbility(), 'modifier_nevermore_special_attack_stacks', { duration = self.stacks_duration })

        if not CustomEntitiesLegacy:IsObstacle(unit) then
            give_mana = true
        end
    end)

    if give_mana then
        CustomEntitiesLegacy:GiveManaAndEnergyPercent(self.caster, self.mana_gain_pct, true)
    end

    EmitSoundOnLocationWithCaster(self.origin, "Hero_Nevermore.Shadowraze", self.caster)

    EFX('particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf', PATTACH_WORLDORIGIN, nil, {
        cp0 = self.origin,
        cp1 = Vector(self.radius, 1, 1),
        release = true
    })

    self:Destroy()
end