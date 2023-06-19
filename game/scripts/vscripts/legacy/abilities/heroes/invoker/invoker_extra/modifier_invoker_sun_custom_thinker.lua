modifier_invoker_sun_custom_thinker = class({})

function modifier_invoker_sun_custom_thinker:OnCreated(params)
    self.caster = self:GetCaster()
    self.origin = self:GetParent():GetAbsOrigin()
    self.radius = self:GetAbility():GetSpecialValueFor("radius")

    if IsServer() then
        self.damage_table = {
            attacker = self.caster,
            damage = self:GetAbility():GetSpecialValueFor("ability_damage"),
            damage_type = DAMAGE_TYPE_PURE,
        }

        local delay_time = self:GetAbility():GetSpecialValueFor('delay_time')
        CreateTimedRadiusMarker(self.caster, self.origin, self.radius, delay_time, 0.2, RADIUS_SCOPE_PUBLIC)
        self:StartIntervalThink(delay_time)
        AddFOWViewer(self.caster:GetTeamNumber(), self.origin, self.radius, delay_time +  0.2, true)

        self.efx = EFX("particles/units/heroes/hero_invoker/invoker_sun_strike_team.vpcf", PATTACH_WORLDORIGIN, self.caster, {
            cp0 = self.origin,
            cp1 = Vector(self.radius, 0, 0)
        })
        EmitSoundOn("Hero_Invoker.SunStrike.Charge", self:GetParent())
    end
end

function modifier_invoker_sun_custom_thinker:OnDestroy()
    if IsServer() then
        UTIL_Remove(self:GetParent())
    end
end

function modifier_invoker_sun_custom_thinker:OnIntervalThink()
    ApplyCallbackForUnitsInArea(self.caster, self.origin, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
        self.damage_table.victim = unit
        ApplyDamage(self.damage_table)
    end)
    
    EFX("particles/units/heroes/hero_invoker/invoker_sun_strike.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = Vector(self.origin.x, self.origin.y, 0),
        cp1 = Vector(self.radius, 0, 0),
        release = true,
    })

    ParticleManager:DestroyParticle(self.efx, true)
    ParticleManager:ReleaseParticleIndex(self.efx)
    
    StopSoundOn("Hero_Invoker.SunStrike.Charge", self:GetParent())
    EmitSoundOn("Hero_Invoker.SunStrike.Ignite", self:GetParent())
    self:Destroy()
end