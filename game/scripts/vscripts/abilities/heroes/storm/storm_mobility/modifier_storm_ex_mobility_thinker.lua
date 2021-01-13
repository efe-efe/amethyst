modifier_storm_ex_mobility_thinker = class({})

function modifier_storm_ex_mobility_thinker:OnCreated(params)
    if IsServer() then
        self.parent = self:GetParent()
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.sleep_duration = self:GetAbility():GetSpecialValueFor("sleep_duration")
        self.origin = self.parent:GetAbsOrigin()
        self.initialized = false
		self.damage_table = {
			attacker = self:GetCaster(),
			damage = self:GetAbility():GetSpecialValueFor("ability_damage"),
			damage_type = DAMAGE_TYPE_PURE,
		}

        local delay = self:GetAbility():GetSpecialValueFor("delay")
        self:StartIntervalThink(delay)

        self.radius_marker_modifier = CreateTimedRadiusMarker(self:GetCaster(), self.origin, self.radius, delay, 0.0, RADIUS_SCOPE_PUBLIC):FindModifierByName('radius_marker_thinker')
	end
end

function modifier_storm_ex_mobility_thinker:OnIntervalThink()
    if not self.initialized then
        self.initialized = true
        CreateRadiusMarker(self:GetCaster(), self.origin, self.radius, RADIUS_SCOPE_PUBLIC, 0.1)
        self.radius_marker_modifier = CreateTimedRadiusMarker(self:GetCaster(), self.origin, self.radius, self:GetDuration(), 0.2, RADIUS_SCOPE_PUBLIC):FindModifierByName('radius_marker_thinker')
        
        self:PlayEffectsOnCreated()
        self:StartIntervalThink(0.03)
    end

    local enemies = CustomEntities:FindUnitsInRadius(
        self:GetCaster(),
        self.origin, 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )

    for _,enemy in pairs(enemies) do
        self.damage_table.victim = enemy
        ApplyDamage(self.damage_table)

        enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), 'modifier_generic_sleep', { duration = self.sleep_duration })
    end

    if #enemies > 0 then
        self:Destroy()
    end
end

function modifier_storm_ex_mobility_thinker:OnDestroy()
    if IsServer() then
        EmitSoundOn("Hero_StormSpirit.StaticRemnantExplode", self.parent)
        DEFX(self.efx)

        if self.radius_marker_modifier ~= nil then
            if not self.radius_marker_modifier:IsNull() then
                self.radius_marker_modifier:Destroy()
            end
        end

        UTIL_Remove(self.parent)
	end
end

function modifier_storm_ex_mobility_thinker:PlayEffectsOnCreated()
    EFX("particles/storm/storm_ex_mobility_strike.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = self.origin,
        cp1 = self.origin + Vector(0, 0, 1000),
        cp2 = self.origin,
        release = true
    })

    self.efx = EFX('particles/storm/storm_ex_mobility.vpcf', PATTACH_WORLDORIGIN, self:GetCaster(), {
        cp0 = self.origin,
        cp2 = Vector(RandomInt(37, 52), 1, 100),
        cp11 = self.origin,
    })
    ParticleManager:SetParticleControlEnt(self.efx, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self.origin, true)

    EmitSoundOn("Hero_StormSpirit.StaticRemnantPlant", self.parent)
end