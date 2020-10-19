modifier_death_zone = class({})
LinkLuaModifier("modifier_death_zone_damage", "modifiers/modifier_death_zone_damage.lua", LUA_MODIFIER_MOTION_NONE)

function modifier_death_zone:OnCreated(kv)
    self.min_radius = 1
    self.max_radius = 8000
    self.radius = self.max_radius
    self.counter = 0
    self.time_counter = 0

    self.reduction_rate = 15
    self.reduction_rates = {}
    self.next_millisecond = 3

    self:AddReductionRate(6, 300)
    self:AddReductionRate(4, 600)
    self:AddReductionRate(0, 900)
    self:AddReductionRate(1, 1050)

    if IsServer() then
        self:StartIntervalThink(0.03)      
        self:PlayEffectsOnCreated()
    end
end

function modifier_death_zone:OnRemoved()
    if IsServer() then
        self:StopEffects()
		UTIL_Remove(self:GetParent())
	end
end

function modifier_death_zone:OnIntervalThink()
    self.next_millisecond = self.next_millisecond - 1

    if self.next_millisecond == 0 then
        self.next_millisecond = 3
        self.time_counter = self.time_counter + 1

        for _,reduction_rate in pairs(self.reduction_rates) do
            if self.time_counter == reduction_rate.time then
                self.reduction_rate = reduction_rate.rate
            end
        end

        local all_units = FindUnitsInRadius(
            DOTA_TEAM_NOTEAM,	-- int, your team number
            self:GetParent():GetOrigin(),	-- point, center point
            nil,	-- handle, cacheUnit. (not known)
            FIND_UNITS_EVERYWHERE,	-- float, radius. or use FIND_UNITS_EVERYWHERE
            DOTA_UNIT_TARGET_TEAM_BOTH,	-- int, team filter
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
            DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED,	-- int, flag filter
            0,	-- int, order filter
            false	-- bool, can grow cache
        )

        local not_affected = FindUnitsInRadius(
            DOTA_TEAM_NOTEAM,	-- int, your team number
            self:GetParent():GetOrigin(),	-- point, center point
            nil,	-- handle, cacheUnit. (not known)
            self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
            DOTA_UNIT_TARGET_TEAM_BOTH,	-- int, team filter
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
            DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED,	-- int, flag filter
            0,	-- int, order filter
            false	-- bool, can grow cache
        )

        for _,unit in pairs(all_units) do
            local continue = true
            for _,exclude in pairs(not_affected) do
                if exclude == unit then
                    SafeDestroyModifier("modifier_death_zone_damage", unit)
                    continue = false
                    break
                end
            end

            if continue then
                if not unit:HasModifier("modifier_death_zone_damage") then
                    unit:AddNewModifier(unit, nil, "modifier_death_zone_damage", {})
                end
            end
        end
        
        if self.counter == 10 then
            for i = self.radius, self.max_radius, 200 do
                self:PlayEffectsAoe(i, 0)
            end
            self.counter = 0
        end

        local new_radius = self.radius - self.reduction_rate
        if new_radius > self.min_radius then
            self.radius = new_radius
        end

        self.counter = self.counter + 1

        self:PlayEffectsAoe(self.radius, 512)
        
        if self.radius < 1150 then
            self:PlayEffectsMeteor()
        end
    end


    if self.radius > 1150 then
        self:PlayEffectsMeteor()
    end
end

function modifier_death_zone:PlayEffectsMeteor()
    local direction = Vector(RandomFloat(-1.0, 1.0), RandomFloat(-1.0, 1.0), 0):Normalized()
    local radius = self.radius + RandomInt(300, 1000)

    local origin = self:GetParent():GetAbsOrigin() + (direction * radius)
    local particle_cast = "particles/units/heroes/hero_invoker/invoker_sun_strike.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, Vector(origin.x, origin.y, 0))
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(300, 0, 0))
end

function modifier_death_zone:PlayEffectsAoe(radius, z_offset)
    local particle_cast = "particles/aoe_marker/aoe_marker_enemy.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    
    ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetOrigin()  + Vector(0, 0, z_offset))
    ParticleManager:SetParticleControl(effect_cast, 2, Vector(radius, radius, radius))
    ParticleManager:SetParticleControl(effect_cast, 4, self:GetParent():GetOrigin()  + Vector(0, 0, z_offset))
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_death_zone:PlayEffectsOnCreated()
    EmitGlobalSound("MegaCreeps.Dire")
end

function modifier_death_zone:AddReductionRate(rate, time)
    table.insert(self.reduction_rates, {
        rate = rate, 
        time = time
    })
end
