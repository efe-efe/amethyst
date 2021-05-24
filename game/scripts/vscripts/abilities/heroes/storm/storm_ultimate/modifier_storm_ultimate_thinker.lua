modifier_storm_ultimate_thinker = class({})

function modifier_storm_ultimate_thinker:OnCreated(params)
    self.ability = self:GetAbility()
    self.radius = self.ability:GetSpecialValueFor("radius")
    self.duration = self.ability:GetSpecialValueFor("duration")
    self.caster = self:GetCaster()
    self.origin = self:GetParent():GetAbsOrigin()
    self.knockback_distance = 500
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

function modifier_storm_ultimate_thinker:OnDestroy()
    if IsServer() then
        UTIL_Remove(self:GetParent())
    end
end

function modifier_storm_ultimate_thinker:OnIntervalThink()
    EFX("particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = self.origin,
        cp1 = self.origin + Vector(0, 0, 1000),
        cp2 = self.origin,
        release = true
    })
    EFX("particles/storm/storm_ultimate_impact.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = self.origin,
        cp3 = self.origin,
        release = true
    })

    EmitSoundOn("Hero_Zuus.GodsWrath.Target", self.caster)
    
    FindClearSpaceForUnit(self.caster, self.origin, true)    
    ScreenShake(self.origin, 100, 300, 0.45, 1000, 0, true)
    
    ApplyCallbackForUnitsInArea(self.caster, self.origin, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
        self.damage_table.victim = unit
        ApplyDamage(self.damage_table)

        if self.caster:HasModifier("modifier_upgrade_storm_unleashed_knockback") then
            local direction = (unit:GetAbsOrigin() - self.origin):Normalized()
            unit:AddNewModifier(self.caster, self.ability, "modifier_storm_ultimate_displacement", { 
                x = direction.x,
                y = direction.y,
                r = self.knockback_distance,
                speed = (self.knockback_distance)/0.35,
                peak = 50,
            })
        end
    end)

    self.caster:AddNewModifier(self.caster, self.ability, 'modifier_storm_ultimate', { duration = self.duration })
    self:Destroy()
end