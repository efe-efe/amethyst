modifier_death_zone = class({})
LinkLuaModifier("modifier_death_zone_damage", "modifiers/modifier_death_zone_damage.lua", LUA_MODIFIER_MOTION_NONE)

function modifier_death_zone:OnCreated(kv)
    self.min_radius = 1
    self.max_radius = 8000
    self.radius = self.max_radius
    self.counter = 0
    self.time_counter = 0
    self.parent = self:GetParent()
    self.origin = self.parent:GetAbsOrigin()

    self.reduction_rate = 30
    self.reduction_rates = {}

    self:AddReductionRate(20, 100)
    self:AddReductionRate(15, 200)
    self:AddReductionRate(10, 250)
    self:AddReductionRate(8, 300)
    self:AddReductionRate(6, 350)
    self:AddReductionRate(3, 400)
    self:AddReductionRate(2, 450)
    self:AddReductionRate(0, 550)
    self:AddReductionRate(1, 700)

    if IsServer() then
        self:StartIntervalThink(0.1)      
        self:PlayEffectsOnCreated()
    end
end

function modifier_death_zone:OnRemoved()
    if IsServer() then
        self:StopEffects()
		UTIL_Remove(self.parent)
	end
end

function modifier_death_zone:OnIntervalThink()
    self.time_counter = self.time_counter + 1

    for _,reduction_rate in ipairs(self.reduction_rates) do
        if self.time_counter == reduction_rate.start_time then
            self.reduction_rate = reduction_rate.radius_reduciton
        end
    end

    local all_units = FindUnitsInRadius(
        DOTA_TEAM_NOTEAM,	-- int, your team number
        self.origin,	-- point, center point
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
        self.origin,	-- point, center point
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
                unit:RemoveModifierByName("modifier_death_zone_damage")
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
    self:PlayEffectsMeteor()
end

function modifier_death_zone:PlayEffectsMeteor()
    local direction = Vector(RandomFloat(-1.0, 1.0), RandomFloat(-1.0, 1.0), 0):Normalized()
    local radius = self.radius + RandomInt(300, 1000)
    local origin = self.origin + (direction * radius)

    EFX("particles/units/heroes/hero_invoker/invoker_sun_strike.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = Vector(origin.x, origin.y, 0),
        cp1 = Vector(300, 0, 0),
    })
end

function modifier_death_zone:PlayEffectsAoe(iRadius, iZOffset)
    local origin = self.origin + Vector(0, 0, iZOffset)
    EFX("particles/aoe_marker/aoe_marker_enemy.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = origin,
        cp2 = Vector(iRadius, 0, 0),
        cp4 = origin,
        release = true,
    })
end

function modifier_death_zone:PlayEffectsOnCreated()
    EmitGlobalSound("MegaCreeps.Dire")
end

function modifier_death_zone:AddReductionRate(iRadiusReduction, fStartTime)
    table.insert(self.reduction_rates, {
        radius_reduciton = iRadiusReduction, 
        start_time = fStartTime
    })
end
