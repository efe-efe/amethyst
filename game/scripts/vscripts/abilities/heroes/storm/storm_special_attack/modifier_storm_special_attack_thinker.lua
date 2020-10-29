modifier_storm_special_attack_thinker = class({})

function modifier_storm_special_attack_thinker:OnCreated(params)
    self.ability = self:GetAbility()
    self.radius = self.ability:GetSpecialValueFor("radius")
    self.duration = self.ability:GetSpecialValueFor("duration")
    self.caster = self:GetCaster()
    self.origin = self:GetParent():GetAbsOrigin()
    self.mana_gain_pct = self:GetAbility():GetSpecialValueFor("mana_gain_pct")
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

function modifier_storm_special_attack_thinker:OnIntervalThink()
    EFX("particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = self.origin,
        cp1 = self.origin + Vector(0, 0, 1000),
        cp2 = self.origin,
        release = true
    })

    
    local give_mana = false

    ApplyCallbackForUnitsInArea(self.caster, self.origin, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
        self.damage_table.victim = unit
        ApplyDamage(self.damage_table)

        unit:AddNewModifier(self.caster, self.ability, 'modifier_storm_special_attack_efx', { 
            duration = self.duration,
            originX = self.origin.x,
            originY = self.origin.y 
        })
          
        if not unit:IsObstacle() then
            give_mana = true
        end
    end)
    
    if give_mana then
        self.caster:GiveManaPercent(self.mana_gain_pct)
    end
    self:Destroy()
end