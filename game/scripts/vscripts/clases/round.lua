Round = Round or class({})

AMETHYST_SPAWN_TIME = 10.0
AMETHYST_RESPAWN_TIME = 15.0

local PICKUPS_TIMER = 5.0 --20.0
local ROUND_TIMER = 10--30.0
local DRAW_TIME = 2.0

function Round:constructor(players, callback)
    self.players = players
    self.callback = callback
    
    self.amethyst = nil
    self.death_zone = nil
    self.winner = nil
    self.amethyst_index = nil

    self.pickups = {}
    self.lights = {}
    self.arrows = {}
    self.light_entities = {}

    self.ended = false
    self.time_over = false
    self.hero_died = false
    self.ended = false
    self.is_trying_to_end = false

    self.amethyst_timer = AMETHYST_SPAWN_TIME
    self.light_spawn_time = AMETHYST_SPAWN_TIME / 5
    self.time_remianing_until_end = DRAW_TIME
    self.time_remaining = ROUND_TIMER

    self.amethyst_entities = Entities:FindAllByName("orb_spawn")
    self.health_entities = Entities:FindAllByName("health_orb")
    self.mana_entities = Entities:FindAllByName("mana_orb")
    self.shield_entities = Entities:FindAllByName("shield_orb")

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
        table.insert(self.pickups, {
            origin = entity:GetOrigin(),
            type = PickupTypes.HEALTH,
            timer = PICKUPS_TIMER,
            entity = nil
        })
    end

    for _,entity in pairs(self.mana_entities) do
        table.insert(self.pickups, {
            origin = entity:GetOrigin(),
            type = PickupTypes.MANA,
            timer = PICKUPS_TIMER,
            entity = nil,
        })
    end

    for _,entity in pairs(self.shield_entities) do
        table.insert(self.pickups, {
            origin = entity:GetOrigin(),
            type = PickupTypes.SHIELD,
            timer = PICKUPS_TIMER,
            entity = nil
        })
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
    if self.time_remaining > 0 then
        self.time_remaining = self.time_remaining - 1
        self:UpdateGameTimer(self.time_remaining)
        if self.time_remaining <= 0 then
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

        for _,pickup in ipairs(self.pickups) do
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
    else
        return
    end

    if self.is_trying_to_end then
        self.time_remianing_until_end = self.time_remianing_until_end - 1

        if self.time_remianing_until_end <= 0 then
            local last_alive, competing_alliances = self:GetLastOrNoneAlive()  
                  
            self.winner = last_alive
            self:EndRound()
        end
    end

    if self.hero_died then
        self.hero_died = false

        if self:CheckEndConditions() then
            self.is_trying_to_end = true
        end
    end
end

function Round:EndRound()       
    self.ended = true

    self:DestroyAllPickups()
    self:DestroyDeathZone()
    self:DestroyAmethyst()
    self:CleanLights()
    self:CleanArrows()

    self:callback()
end

function Round:GetLastOrNoneAlive()
    local alliances = {}

    for _,player in pairs(self.players) do
        if player.hero and not player.hero:IsNull() and player.hero:IsAlive() then
            alliances[player.alliance.number] = player.alliance
        end
    end

    local competing_alliances = 0
    local last_alive = nil

    for alliance_number, alliance in pairs(alliances) do
        competing_alliances = competing_alliances + 1
        last_alive = alliance
    end

    return last_alive, competing_alliances
end

function Round:CheckEndConditions()
    local last_alive, competing_alliances = self:GetLastOrNoneAlive()

    return competing_alliances <= 1
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
    for _,pickup in pairs(self.pickups) do
        pickup.entity:Destroy()
        self.pickups[_] = nil
    end
end

function Round:DestroyAmethyst()
    if self.amethyst ~= nil then
        self.amethyst:Destroy()
        self.amethyst = nil
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