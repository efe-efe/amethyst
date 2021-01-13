modifier_spectre_ex_special_attack_thinker = class({})

function modifier_spectre_ex_special_attack_thinker:OnCreated(params)
    if IsServer() then
        self.caster = self:GetCaster()
        self.origin = self:GetParent():GetAbsOrigin()
        self.radius = self:GetAbility():GetSpecialValueFor('radius')
        self.banish_duration = self:GetAbility():GetSpecialValueFor('banish_duration')
        local delay_time = self:GetAbility():GetSpecialValueFor('delay_time')
        CreateTimedRadiusMarker(self.caster, self.origin, self.radius, delay_time, 0.2, RADIUS_SCOPE_PUBLIC)
        self:StartIntervalThink(delay_time)

        
        self.efx = ParticleManager:CreateParticle("particles/spectre/spectre_illusion_warp_ground.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(self.efx, 0, self:GetParent():GetAbsOrigin())
        ParticleManager:SetParticleControl(self.efx, 1, self:GetParent():GetAbsOrigin())
        ParticleManager:SetParticleControl(self.efx, 2, self:GetParent():GetAbsOrigin())
        ParticleManager:SetParticleControl(self.efx, 3, Vector(self.radius, 0, 0))
    end
end

function modifier_spectre_ex_special_attack_thinker:OnIntervalThink()
    
    EmitSoundOn("Hero_Spectre.HauntCast", self:GetParent())
    local spectre_ex_basic_attack_recast = self.caster:FindAbilityByName('spectre_ex_special_attack_recast')
    spectre_ex_basic_attack_recast:ClearTargets()

    local enemies = ApplyCallbackForUnitsInArea(self.caster, self.origin, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
        unit:AddNewModifier(self.caster, self:GetAbility(), 'modifier_spectre_ex_special_attack_banish', { duration = self.banish_duration })
        spectre_ex_basic_attack_recast:AddTarget(unit)
        local efx = ParticleManager:CreateParticle("particles/units/heroes/hero_spectre/spectre_death.vpcf", PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(efx, 0, unit:GetAbsOrigin())
		ParticleManager:SetParticleControl(efx, 3, unit:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(efx)
    end)

    if #enemies > 0 then
        self.caster:AddNewModifier(self.caster, self:GetAbility(), 'modifier_spectre_ex_special_attack_recast', { duration = self.banish_duration })
    end

    self:Destroy()
end

function modifier_spectre_ex_special_attack_thinker:OnDestroy()
    if IsServer() then
        UTIL_Remove(self:GetParent())
        ParticleManager:DestroyParticle(self.efx, false)
        ParticleManager:ReleaseParticleIndex(self.efx)   

        EFX('particles/spectre/spectre_illusion_warp_radius.vpcf', PATTACH_WORLDORIGIN, nil, {
            cp0 = self.origin,
            cp1 = self.origin,
            cp2 = Vector(self.radius),
            release = true
        })
    end
end