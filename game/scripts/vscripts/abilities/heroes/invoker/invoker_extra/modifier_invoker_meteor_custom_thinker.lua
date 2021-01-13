modifier_invoker_meteor_custom_thinker = class({})

function modifier_invoker_meteor_custom_thinker:OnCreated(params)
    if IsServer() then
        self.caster = self:GetCaster()
        self.origin = self:GetParent():GetAbsOrigin()
        self.radius = 150--self:GetAbility():GetSpecialValueFor('radius')
        
        self.damage_table = {
            attacker = self.caster,
            damage = 3,
            damage_type = DAMAGE_TYPE_PURE,
        }

        CreateTimedRadiusMarker(self.caster, self.origin, self.radius, self:GetDuration(), 0.2, RADIUS_SCOPE_PUBLIC)
        self:StartIntervalThink(0.5)

        self.efx = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_chaos_meteor_fire_trail.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(self.efx, 0, self:GetParent():GetAbsOrigin())
        ParticleManager:SetParticleControl(self.efx, 3, self:GetParent():GetAbsOrigin())
    end
end

function modifier_invoker_meteor_custom_thinker:OnIntervalThink()
    ApplyCallbackForUnitsInArea(self.caster, self.origin, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
        self.damage_table.victim = unit
        ApplyDamage(self.damage_table)
    end)
end

function modifier_invoker_meteor_custom_thinker:OnDestroy()
    if IsServer() then
        UTIL_Remove(self:GetParent())
        ParticleManager:DestroyParticle(self.efx, false)
        ParticleManager:ReleaseParticleIndex(self.efx)   
    end
end