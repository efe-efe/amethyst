modifier_death_zone = class({})
LinkLuaModifier("modifier_death_zone_damage", "modifiers/modifier_death_zone_damage.lua", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
--Initializer
function modifier_death_zone:OnCreated(kv)
    self.max_radius = 8000--self:GetAbility():GetSpecialValueFor("radius")
    self.radius = self.max_radius
    self.min_radius = 1
    self.initialized = false
    self.effects = {}
    self.counter = 0
    self.counter_seconds = 0
    self.reduction_ratio = 15

    if IsServer() then
        -- Start Interval
        self:StartIntervalThink(0.1)      
        self:PlayEffectsOnCreated()
    end
end

function modifier_death_zone:OnRemoved()
    if IsServer() then
        self:StopEffects()
		UTIL_Remove(self:GetParent())
	end
end

--------------------------------------------------------------------------------
--On think
function modifier_death_zone:OnIntervalThink()
    self.counter_seconds = self.counter_seconds + 1

    if self.counter_seconds == 300 then
        self.reduction_ratio = 6
    end

    if self.counter_seconds == 600 then
        self.reduction_ratio = 4
    end

    if self.counter_seconds == 900 then
        self.reduction_ratio = 0
    end

    if self.counter_seconds == 1050 then
        self.reduction_ratio = 1
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

    local new_radius = self.radius - self.reduction_ratio
    if new_radius > self.min_radius then
        self.radius = new_radius
    end

    self.counter = self.counter + 1

    
    --[[
    self:PlayEffectsAoe(self.radius, 512)
    self:PlayEffectsAoe(self.radius, 384)
    self:PlayEffectsAoe(self.radius, 256)
    self:PlayEffectsAoe(self.radius, 128)
    ]]

    self:PlayEffectsAoe(self.radius, 512)
    --self:StopEffects()
    --self:PlayEffectsOnCreated(0, self.radius, 0)
    --self:UpdateParticles()
end

function modifier_death_zone:PlayEffectsAoe(radius, z_offset)
    local particle_cast = "particles/mod_units/instant_aoe_marker.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetOrigin()  + Vector(0, 0, z_offset))
    ParticleManager:SetParticleControl(effect_cast, 2, Vector(radius, radius, radius))
    ParticleManager:SetParticleControl(effect_cast, 4, self:GetParent():GetOrigin()  + Vector(0, 0, z_offset))
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_death_zone:PlayEffectsAoeAlternate(radius, z_offset)
    local particle_cast = "particles/aoe_marker.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetOrigin()  + Vector(0, 0, z_offset))
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, 1, 1))
    ParticleManager:SetParticleControl(effect_cast, 2, Vector(255, 1, 1))
    ParticleManager:SetParticleControl(effect_cast, 3, Vector(0.1, 0, 0))
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_death_zone:UpdateParticles()
    for _,efx in pairs(self.effects) do    
        ParticleManager:SetParticleControl(efx, 1, Vector(self.radius, self.radius, self.radius))
    end
end

function modifier_death_zone:PlayEffectsOnCreated()--i, radius, z_offset
    EmitGlobalSound("MegaCreeps.Dire")
    --[[
    local particle_cast = "particles/units/heroes/hero_zeus/zeus_cloud.vpcf"
    self.effects[i] = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(self.effects[i], 0, self:GetParent():GetOrigin() + Vector(0, 0, z_offset))
    ParticleManager:SetParticleControl(self.effects[i], 1, Vector(radius, 1, 1))
    ]]
end

function modifier_death_zone:StopEffects()
    for _,efx in pairs(self.effects) do
        ParticleManager:DestroyParticle(efx, false)
        ParticleManager:ReleaseParticleIndex(efx)
    end
end
