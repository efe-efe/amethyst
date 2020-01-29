Round = Round or class({})

-- Win conditions
ROUNDS = 0
POINTS = 1 

AMETHYST_SPAWN_TIME = 10.0
AMETHYST_RESPAWN_TIME = 15.0

local PICKUPS_TIMER = 5.0 --20.0
local ROUND_TIMER = 30.0

function Round:constructor(players)
    self.amethyst = nil
    self.death_zone = nil
    self.pickups = {}
    self.lights = {}
    self.arrows = {}
    self.players = players
    self.ended = false
    self.time_over = false
    self.hero_died = false
    self.amethyst_timer = AMETHYST_SPAWN_TIME
    self.light_spawn_time = AMETHYST_SPAWN_TIME / 5
    
    self.amethyst_index = nil

    self.amethyst_entities = Entities:FindAllByName("orb_spawn")
    self.health_entities = Entities:FindAllByName("health_orb")
    self.mana_entities = Entities:FindAllByName("mana_orb")
    self.shield_entities = Entities:FindAllByName("shield_orb")
    self.light_entities = {}

    if GetMapName() == "forest_map" or GetMapName() == "free_for_all" then
        self.amethyst_index = 1
    else
        self.amethyst_index = RandomInt(1, 3)
    end

    for i = 1, 5 do
        local temp = "orb_timer" .. tostring(i)
        self.light_entities[i] = Entities:FindAllByName(temp)
    end

    for _,entity in pairs(self.health_entities) do
        self.pickups[entity:GetEntityIndex()] = {
            origin = entity:GetOrigin(),
            type = PickupTypes.HEALTH,
            timer = PICKUPS_TIMER,
            entity = nil
        }
    end

    for _,entity in pairs(self.mana_entities) do
        self.pickups[entity:GetEntityIndex()] = {
            origin = entity:GetOrigin(),
            type = PickupTypes.MANA,
            timer = PICKUPS_TIMER,
            entity = nil,
        }
    end

    for _,entity in pairs(self.shield_entities) do
        self.pickups[entity:GetEntityIndex()] = {
            origin = entity:GetOrigin(),
            type = PickupTypes.SHIELD,
            timer = PICKUPS_TIMER,
            entity = nil
        }
    end

    self:SpawnArrows()
end

function Round:SpawnArrows()
    local particle_cast = "particles/ui_mouseactions/range_finder_directional.vpcf"

    for _,entity in pairs(self.amethyst_entities) do
        if _ ~= self.amethyst_index then 
            local origin = entity:GetOrigin()
            local direction = (self.amethyst_entities[self.amethyst_index]:GetOrigin() - origin):Normalized()
            self.arrows[entity] = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
            ParticleManager:SetParticleControl( self.arrows[entity], 0, origin )
            ParticleManager:SetParticleControl( self.arrows[entity], 2, origin + direction * Vector(128, 128, 0) )
        end
    end
end

function Round:Update()
    if ROUND_TIMER > 0 then
        ROUND_TIMER = ROUND_TIMER - 1
        self:UpdateGameTimer(ROUND_TIMER)
        if ROUND_TIMER <= 0 then
            self.time_over = true
            self:CreateDeathZone()
        end
    end

    if not self.ended then
        if not self.amethyst then
            self.amethyst_timer = self.amethyst_timer - 1

            if math.fmod(self.amethyst_timer, self.light_spawn_time) == 0 then
                self:CreateLight() 
            end

            if self.amethyst_timer == 0 then
                self.amethyst = Amethyst(self.amethyst_entities[self.amethyst_index]:GetOrigin())
            end
        else
            if not self.amethyst:Alive() then
                self.amethyst = nil

                if not self.time_over then
                    local index = RandomInt(1, #self.amethyst_entities)
                    if index == self.amethyst_index then
                        index = index + 1

                        if index > #self.amethyst_entities then
                            index = 1
                        end
                    end
                    self.amethyst_index = index
                end

                self.amethyst_timer = AMETHYST_RESPAWN_TIME
                self.light_spawn_time = AMETHYST_RESPAWN_TIME / 5

                self:CleanLights()
                self:CleanArrows()
                self:SpawnArrows()
            end
        end

        for _,pickup in pairs(self.pickups) do
            if not pickup.entity then
                self.pickups[_].timer = pickup.timer - 1
                if self.pickups[_].timer == 0 then
                    self.pickups[_].entity = Pickup(pickup.type, pickup.origin, nil)
                end
            else
                if not pickup.entity:Alive() then
                    self.pickups[_].timer = PICKUPS_TIMER
                    self.pickups[_].entity = nil
                end
            end
        end

        if self.hero_died then
            self.hero_died = false

            if self:CheckEndConditions() then
                
            end
        end
    end
end

function Round:CheckEndConditions() 
    
end

function Round:CleanLights()
    for _,light in pairs(self.lights) do
        UTIL_Remove( light )
    end
    self.lights = {}
end

function Round:CleanArrows()
    for _,arrow in pairs(self.arrows) do
        ParticleManager:DestroyParticle(arrow, false)
        ParticleManager:ReleaseParticleIndex(arrow)
    end
end

function Round:CreateLight()
    self.lights[#self.lights + 1] =CreateUnitByName(
        "npc_dota_creature_amethyst_timer", --szUnitName
        self.light_entities[#self.lights + 1][self.amethyst_index]:GetOrigin(), --vLocation
        true, --bFindClearSpace
        nil, --hNPCOwner
        nil, --hUnitOwner
        DOTA_TEAM_NOTEAM
    )
    
    local particle_cast = "particles/mod_units/units/middle_orb/rune_arcane.vpcf"
    ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.lights[#self.lights] )
end

function Round:CreateDeathZone()    
    CustomGameEventManager:Send_ServerToAllClients( "death_zone_initiated", {} )

    self.death_zone = CreateModifierThinker(
        nil, --hCaster
        nil, --hAbility
        "modifier_death_zone", --modifierName
        {}, --paramTable
        self.amethyst_entities[self.amethyst_index]:GetOrigin(), --vOrigin
        DOTA_TEAM_NOTEAM, --nTeamNumber
        false --bPhantomBlocker
    )
end

function Round:DestroyDeathZone()
    if self.death_zone ~= nil then
        if not self.death_zone:IsNull() then
            self.death_zone:Destroy()
        end
    end
end

function Round:DestroyAllPickups()
    for _,orb in pairs(self.pickups) do
        UTIL_Remove( orb.item ) -- otherwise it pollutes the player inventory
        if orb.drop ~= nil and not orb.drop:IsNull() then
            UTIL_Remove( orb.drop )
        end
    end
end

function Round:UpdateGameTimer( time )
    local minutes = math.floor(time / 60)
    local seconds = time - (minutes * 60)
    local m10 = math.floor(minutes / 10)
    local m01 = minutes - (m10 * 10)
    local s10 = math.floor(seconds / 10)
    local s01 = seconds - (s10 * 10)
    local broadcast_gametimer = 
        {
            timer_minute_10 = m10,
            timer_minute_01 = m01,
            timer_second_10 = s10,
            timer_second_01 = s01,
        }
  
    CustomGameEventManager:Send_ServerToAllClients( "countdown", broadcast_gametimer )
end