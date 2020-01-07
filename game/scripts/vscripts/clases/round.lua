Round = Round or class({})

-- Win conditions
ROUNDS = 0
POINTS = 1 

AMETHYST_TIMER = {
    first = 10.0,
    regular = 15.0
}

local PICKUPS_TIMER = 20.0

function Round:constructor()
    self.amethyst = nil
    self.lights = {}
    self.amethyst_entities = Entities:FindAllByName("orb_spawn")
    self.health_entities = Entities:FindAllByName("health_orb")
    self.mana_entities = Entities:FindAllByName("mana_orb")
    self.shield_entities = Entities:FindAllByName("shield_orb")
    self.light_entities = {}
    self.scheduled_amethyst_index = self:GetFirstSpawn()
    self.next_amethyst_index = self:GetNextSpawn()

    for i = 1, 5 do
        local temp = "orb_timer" .. tostring(i)
        self.light_entities[i] = Entities:FindAllByName(temp)
    end

    self.pickups = {}
    self.arrows = {}
end

function Round:Start()
    self:ScheduleAmethyst(self.scheduled_amethyst_index, AMETHYST_TIMER.first)
    self:SchedulePickups()
end

function Round:SpawnArrows( index )
    local particle_cast = "particles/ui_mouseactions/range_finder_directional.vpcf"

    for _,entity in pairs(self.amethyst_entities) do
        local next_entity = self.amethyst_entities[index]
        if entity ~= next_entity then 
            local next_origin = next_entity:GetOrigin()
            local origin = entity:GetOrigin()
            local direction = (next_origin - origin):Normalized()
            local second_arrow_origin = origin + direction * Vector(128, 128, 0)
        
            self.arrows[entity] = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
            ParticleManager:SetParticleControl( self.arrows[entity], 0, origin )
            ParticleManager:SetParticleControl( self.arrows[entity], 2, second_arrow_origin )
        end
    end
end

function Round:ScheduleAmethyst(index, delay)
    local callback = function()
        self.next_amethyst_index = self:GetNextSpawn()
        self:ScheduleAmethyst( self.next_amethyst_index, AMETHYST_TIMER.regular )
    end
    
    self:CleanArrows()
    self:CleanLights()

    self.amethyst = Amethyst( self.amethyst_entities[index]:GetOrigin(), delay, callback)
    self:ScheduleLights(index, delay)
    self:SpawnArrows(index)
end

function Round:CleanLights()
    for _,light in pairs(self.lights) do
        UTIL_Remove( light )
    end
end

function Round:CleanArrows()
    for _,arrow in pairs(self.arrows) do
        ParticleManager:DestroyParticle(arrow, false)
        ParticleManager:ReleaseParticleIndex(arrow)
    end
end

function Round:ScheduleLights(index, delay)
    local counter = 0.0
    local interval = delay / 5
    
    for _,entity in pairs(self.light_entities) do
        counter = counter + interval
        self.amethyst:GetUnit():SetContextThink( "Spawn" .. entity[index]:GetEntityIndex(), function()
            self.lights[_] = CreateUnitByName(
                "npc_dota_creature_amethyst_timer", --szUnitName
                entity[index]:GetOrigin(), --vLocation
                true, --bFindClearSpace
                nil, --hNPCOwner
                nil, --hUnitOwner
                DOTA_TEAM_NOTEAM
            )
            
            local particle_cast = "particles/mod_units/units/middle_orb/rune_arcane.vpcf"
            ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.lights[_] )
        end, counter)
    end
end

function Round:SchedulePickups()
    for _,entity in pairs(self.health_entities) do
        self:SchedulePickup(_ .. "h", PickupTypes.HEALTH, entity:GetOrigin(), true)
    end

    for _,entity in pairs(self.mana_entities) do
        self:SchedulePickup(_ .. "m", PickupTypes.MANA, entity:GetOrigin(), true)
    end

    for _,entity in pairs(self.shield_entities) do
        self:SchedulePickup(_ .. "s", PickupTypes.SHIELD, entity:GetOrigin(), true)
    end
end

function Round:SchedulePickup(index, type, origin, respawn)
    local callback = nil

    if respawn then
        callback = function() self:SchedulePickup(index, type, origin, true) end
    end

    self.pickups[index] = Pickup(
        type, 
        origin, 
        PICKUPS_TIMER, 
        nil,
        callback 
    )
end

function GameMode:GetNextSpawn()
    local index = RandomInt(1, #self.amethyst_entities)

    --If spawn is the same than the actual one, pick the next spawn
    if index == self.scheduled_amethyst_index then

        index = index + 1

        -- If the spawn is higher than the possible ones, use the first one
        if index > #self.amethyst_entities then
            index = 1
        end
    end

    return index
end

function Round:GetFirstSpawn()
    if GetMapName() == "forest_map" or GetMapName() == "free_for_all" then
        return 1 
    else
        return RandomInt(1, 3)
    end
end
