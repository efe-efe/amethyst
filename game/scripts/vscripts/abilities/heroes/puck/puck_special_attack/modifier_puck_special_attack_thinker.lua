modifier_puck_special_attack_thinker = class({})

function modifier_puck_special_attack_thinker:OnCreated(params)
    if IsServer() then
        self.iteration = 0

        local damage_small = self:GetAbility():GetSpecialValueFor('damage_small')
        self.caster = self:GetCaster()
        self.origin = self:GetParent():GetAbsOrigin()
        self.radius = self:GetAbility():GetSpecialValueFor('radius')
        self.radius_small = self:GetAbility():GetSpecialValueFor('radius_small')
        self.silence_duration = self:GetAbility():GetSpecialValueFor('silence_duration')
        self.stun_duration_small = self:GetAbility():GetSpecialValueFor('stun_duration_small')
        self.stun_duration = self:GetAbility():GetSpecialValueFor('stun_duration')
        self.fairy_dust_duration = self:GetAbility():GetSpecialValueFor('fairy_dust_duration')
        self.fairy_dust_slow_pct = self:GetAbility():GetSpecialValueFor('fairy_dust_slow_pct')
        
        self.delay = self:GetAbility():GetSpecialValueFor('delay')
        self.delay_small = self:GetAbility():GetSpecialValueFor('delay_small')
        self.damage = self:GetAbility():GetSpecialValueFor('damage')

		self.damage_table = {
			attacker = self.caster,
			damage = damage_small,
			damage_type = DAMAGE_TYPE_PURE,
		}

        CreateTimedRadiusMarker(self.caster, self.origin, self.radius, self.delay, 0.2, RADIUS_SCOPE_PUBLIC)
        CreateTimedRadiusMarker(self.caster, self.origin, self.radius_small, self.delay_small, 0.2, RADIUS_SCOPE_PUBLIC)

        self.efx = EFX('', PATTACH_WORLDORIGIN, nil, {
            cp0 = self.origin,
            cp1 = self.origin,
            cp3 = self.origin,
        })
        self:StartIntervalThink(self.delay_small)
    end
end

function modifier_puck_special_attack_thinker:OnDestroy()
    if IsServer() then
        StopSoundOn("Hero_Puck.Dream_Coil", self:GetCaster())
        DEFX(self.efx, false)
        UTIL_Remove(self:GetParent())
    end
end

function modifier_puck_special_attack_thinker:OnIntervalThink()
    if self.iteration == 0 then
        ApplyCallbackForUnitsInArea(self.caster, self.origin, self.radius_small, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
            self.damage_table.victim = unit
            if self:GetAbility():GetLevel() >= 2 then
                unit:AddNewModifier(self.caster, self:GetAbility(), 'modifier_generic_stunned', { duration = self.stun_duration_small })
            else
                unit:AddNewModifier(self.caster, self:GetAbility(), 'modifier_generic_silence', { duration = self.silence_duration })
            end
            EmitSoundOn("Hero_Oracle.FortunesEnd.Attack", unit)
            ApplyDamage(self.damage_table)
         end)

        self:PlayEffectsExplode(self.radius_small, 0)

        self.iteration = 1
        self:StartIntervalThink(self.delay - self.delay_small)                   
    else
        self.damage_table.damage = self.damage
        ApplyCallbackForUnitsInArea(self.caster, self.origin, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
            self.damage_table.victim = unit
            if self:GetAbility():GetLevel() >= 2 then
                unit:AddNewModifier(self.caster, self:GetAbility(), 'modifier_generic_stunned', { duration = self.stun_duration })
            end
            unit:AddNewModifier(self.caster, self:GetAbility(), 'modifier_puck_fairy_dust', { duration = self.fairy_dust_duration, slow_pct = self.fairy_dust_slow_pct })
            EmitSoundOn("Hero_Oracle.FortunesEnd.Attack", unit)
            ApplyDamage(self.damage_table)
        end)

        self:PlayEffectsExplode(self.radius, 1)
        self:Destroy()
    end
end

function modifier_puck_special_attack_thinker:PlayEffectsExplode(radius, steam)
    EmitSoundOn("Hero_Puck.Dream_Coil_Snap", self:GetParent())

    EFX('particles/puck/puck_special_attack_radius.vpcf', PATTACH_WORLDORIGIN, nil, {
        cp0 = self.origin,
        cp1 = self.origin,
        cp2 = Vector(radius),
        release = true
    })

    
    EFX('particles/puck/puck_special_attack.vpcf', PATTACH_WORLDORIGIN, nil, {
        cp0 = self.origin,
        cp2 = Vector(radius,0, 0),
        cp6 = Vector(steam,0, 0),
        release = true
    })
end