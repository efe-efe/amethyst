modifier_centaur_rage_thinker = class({})

function modifier_centaur_rage_thinker:OnCreated(params)
    if IsServer() then
        self.sound = params.sound
        self.caster = self:GetCaster()
        self.origin = self:GetParent():GetAbsOrigin()
        self.radius = self:GetAbility():GetSpecialValueFor('radius')
        self.damage_table = {
            attacker = self.caster,
            damage =self:GetAbility():GetSpecialValueFor("ability_damage"),
            damage_type = DAMAGE_TYPE_PURE,
        }

        local delay_time = 0.6

        CreateTimedRadiusMarker(self.caster, self.origin, self.radius, delay_time, 0.2, RADIUS_SCOPE_PUBLIC)
        self:StartIntervalThink(delay_time)
    end
end

function modifier_centaur_rage_thinker:OnIntervalThink()
    ApplyCallbackForUnitsInArea(self.caster, self.origin, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
        self.damage_table.victim = unit
        ApplyDamage(self.damage_table)
    end)

    if self.sound == 0 then
        EmitSoundOn("Hero_Centaur.HoofStomp", self:GetCaster())
    end
    EFX("particles/units/heroes/hero_sandking/sandking_epicenter.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = self:GetParent():GetAbsOrigin(),
        cp1 = Vector(self.radius, 0, 0),
        release = true,
    })
    self:Destroy()
end

function modifier_centaur_rage_thinker:OnDestroy()
    if IsServer() then
        UTIL_Remove(self:GetParent())
    end
end