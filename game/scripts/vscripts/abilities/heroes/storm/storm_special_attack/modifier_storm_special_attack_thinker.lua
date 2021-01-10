modifier_storm_special_attack_thinker = class({})

function modifier_storm_special_attack_thinker:OnCreated(params)
    self.ability = self:GetAbility()
    self.radius = self.ability:GetSpecialValueFor("radius")
    self.duration = self.ability:GetSpecialValueFor("duration")
    self.caster = self:GetCaster()
    self.origin = self:GetParent():GetAbsOrigin()
    self.mana_gain_pct = self:GetAbility():GetSpecialValueFor("mana_gain_pct")
    self.energy_gain_pct = self:GetAbility():GetLevelSpecialValueFor("mana_gain_pct", 0)
    self.damage_table = {
        attacker = self.caster,
        damage = self.ability:GetSpecialValueFor("ability_damage"),
        damage_type = DAMAGE_TYPE_PURE,
    }

    if IsServer() then
        local delay_time = self.ability:GetSpecialValueFor('delay_time')
        CreateTimedRadiusMarker(self.caster, self.origin, self.radius, delay_time, 0.2, RADIUS_SCOPE_PUBLIC)
        self:StartIntervalThink(delay_time)
    end
end

function modifier_storm_special_attack_thinker:OnDestroy()
    if IsServer() then
        UTIL_Remove(self:GetParent())
    end
end

function modifier_storm_special_attack_thinker:OnIntervalThink()
    EFX("particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = self.origin,
        cp1 = self.origin + Vector(0, 0, 1000),
        cp2 = self.origin,
        release = true
    })

    local give_mana = true

    ApplyCallbackForUnitsInArea(self.caster, self.origin, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
        self.damage_table.victim = unit
        ApplyDamage(self.damage_table)

        unit:AddNewModifier(self.caster, self.ability, 'modifier_storm_special_attack_efx', { 
            duration = self.duration,
            originX = self.origin.x,
            originY = self.origin.y 
        })

        unit:AddNewModifier(self.caster, self.ability, "modifier_generic_stunned", { duration = 0.1 })
          
        if CustomEntities:ProvidesMana(unit) then
            if self:GetAbility():GetLevel() >= 2 then
                unit:ReduceMana(self.mana_gain_pct)
                self:GiveMana()
            else
                if give_mana then
                    self:GiveMana()
                    give_mana = false
                end
            end
        end
    end)
    
    self:Destroy()
end

function modifier_storm_special_attack_thinker:GiveMana()
    CustomEntities:GiveManaPercent(self.caster, self.mana_gain_pct, true)
    CustomEntities:GiveEnergyPercent(self.caster, self.energy_gain_pct, true)
    if self.caster:HasModifier('modifier_storm_ultimate') then
        local extra_mana_pct = self.mana_gain_pct * (self.caster:FindModifierByName('modifier_storm_ultimate'):GetManaMultiplier() - 1)
        CustomEntities:GiveManaPercent(self.caster, extra_mana_pct, true, true)
    end
end