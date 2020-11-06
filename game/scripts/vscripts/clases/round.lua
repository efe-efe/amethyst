Round = Round or class({}, nil, GameState)

local AMETHYST_SPAWN_TIME = 10.0
local AMETHYST_RESPAWN_TIME = 15.0

local PICKUPS_TIMER = 20.0
local ROUND_TIMER = ROUND_DURATION
local DRAW_TIME = 3.0

function Round:constructor(players, callback)
    self.players = players
    self.callback = callback
    
    self.death_zone = nil
    self.winner = nil

    self.amethyst = {}
    self.pickups = {}
    self.lights = {}
    self.arrows = {}
    self.light_entities = {}

    self.ended = false
    self.time_over = false
    self.hero_died = false
    self.ended = false
    self.is_trying_to_end = false

    self.light_spawn_time = AMETHYST_SPAWN_TIME / 5
    self.time_remianing_until_end = DRAW_TIME
    self.time_remaining = ROUND_TIMER * 30

    self.amethyst_entities = Entities:FindAllByName("orb_spawn")
    self.health_entities = Entities:FindAllByName("health_orb")
    self.mana_entities = Entities:FindAllByName("mana_orb")
    self.shield_entities = Entities:FindAllByName("shield_orb")

    self.radiant_warmup_spawn = Entities:FindByName(nil, "radiant_warmup_spawn")
    self.dire_warmup_spawn = Entities:FindByName(nil, "dire_warmup_spawn")

    for i = 1, 5 do
        local temp = "orb_timer" .. tostring(i)
        self.light_entities[i] = Entities:FindAllByName(temp)
    end

    for _,entity in pairs(self.health_entities) do
        table.insert(self.pickups, {
            origin = entity:GetOrigin(),
            type = PickupTypes.HEALTH,
            timer = PICKUPS_TIMER * 30,
            entity = nil
        })
    end

    for _,entity in pairs(self.mana_entities) do
        table.insert(self.pickups, {
            origin = entity:GetOrigin(),
            type = PickupTypes.MANA,
            timer = PICKUPS_TIMER * 30,
            entity = nil,
        })
    end

    for _,entity in pairs(self.shield_entities) do
        table.insert(self.pickups, {
            origin = entity:GetOrigin(),
            type = PickupTypes.SHIELD,
            timer = PICKUPS_TIMER * 30,
            entity = nil
        })
    end
    self.amethyst = {
        index = RandomInt(1, 3),
        timer = AMETHYST_SPAWN_TIME * 30,
        initial_time = AMETHYST_SPAWN_TIME * 30,
        entity = nil,
        effect = nil
    }

    self:SpawnArrows()
end

function Round:SpawnArrows()
    local particle_cast = "particles/ui_mouseactions/range_finder_directional.vpcf"

    for _,entity in pairs(self.amethyst_entities) do
        if _ ~= self.amethyst.index then 
            local origin = entity:GetOrigin()
            local direction = (self.amethyst_entities[self.amethyst.index]:GetOrigin() - origin):Normalized()
            self.arrows[entity] = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
            ParticleManager:SetParticleControl(self.arrows[entity], 0, origin)
            ParticleManager:SetParticleControl(self.arrows[entity], 2, origin + direction * Vector(128, 128, 0))
        end
    end
end

function Round:Update()
    if self.time_remaining > 0 then
        self.time_remaining = self.time_remaining - 1

        self:UpdateGameTimer(math.floor(self.time_remaining/30))
        if self.time_remaining <= 0 then
            if ROUND_TIMER ~= -1 then
                self.time_over = true
                self:CreateDeathZone()
            end
        end
    end

    if not self.ended then
        if not self.amethyst.effect then
            self.amethyst.effect = ParticleManager:CreateParticle("particles/progress_circle/generic_progress_circle.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager:SetParticleControlForward(self.amethyst.effect, 0, Vector(0, -1, 0))	
            ParticleManager:SetParticleControl(self.amethyst.effect, 0, self.amethyst_entities[self.amethyst.index]:GetOrigin() - Vector(0, 0, 120))
            ParticleManager:SetParticleControl(self.amethyst.effect, 1, Vector(250, 0, 1))
            ParticleManager:SetParticleControl(self.amethyst.effect, 15, Vector(255, 26, 243))
            ParticleManager:SetParticleControl(self.amethyst.effect, 16, Vector(1, 0, 0))
        else
            local percentage = (self.amethyst.initial_time - self.amethyst.timer)/self.amethyst.initial_time

            if percentage <= 1.0 then
                ParticleManager:SetParticleControl(self.amethyst.effect, 1, Vector(250, percentage, 0))
            end
        end

        if not self.amethyst.entity then
            self.amethyst.timer = self.amethyst.timer - 1

            if math.fmod(self.amethyst.timer/30, self.light_spawn_time) == 0 then
                self:CreateLight() 
            end

            if self.amethyst.timer <= 0 then
                self.amethyst.entity = Amethyst(self.amethyst_entities[self.amethyst.index]:GetOrigin())
            end
        else
            if not self.amethyst.entity:Alive() then
                self.amethyst.entity = nil

                if not self.time_over then
                    local index = RandomInt(1, #self.amethyst_entities)
                    if index == self.amethyst.index then
                        index = index + 1

                        if index > #self.amethyst_entities then
                            index = 1
                        end
                    end
                    self.amethyst.index = index
                end
                
                ParticleManager:DestroyParticle(self.amethyst.effect, false)
                ParticleManager:ReleaseParticleIndex(self.amethyst.effect)

                self.amethyst.effect = nil
                self.amethyst.timer = AMETHYST_RESPAWN_TIME * 30
                self.amethyst.initial_time = AMETHYST_RESPAWN_TIME * 30
                self.light_spawn_time = AMETHYST_RESPAWN_TIME / 5

                self:CleanLights()
                self:CleanArrows()
                self:SpawnArrows()
            end
        end

        for _,pickup in ipairs(self.pickups) do
            if not pickup.entity then
                pickup.timer = pickup.timer - 1
                if pickup.timer <= 0 then
                    pickup.entity = Pickup(pickup.type, pickup.origin, nil)
                end
            else
                if not pickup.entity:Alive() then
                    pickup.timer = PICKUPS_TIMER * 30
                    pickup.entity = nil
                end
            end
        end
    else
        return
    end

    if self.is_trying_to_end then
        self.time_remianing_until_end = self.time_remianing_until_end - FrameTime()

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

    for _,player in pairs(self.players) do
        local target = nil

        if player.alliance.name == "DOTA_ALLIANCE_RADIANT" then
            target = self.radiant_warmup_spawn
        end
        if player.alliance.name == "DOTA_ALLIANCE_DIRE" then
            target = self.dire_warmup_spawn
        end

        if not player.hero:IsAlive() then
            player.hero:RespawnHero(false, false)
        end

        FindClearSpaceForUnit(player.hero, target:GetAbsOrigin(), true)
        player.hero:Reset()
    end


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
        UTIL_Remove(light)
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
        self.light_entities[#self.lights + 1][self.amethyst.index]:GetOrigin(), --vLocation
        true, --bFindClearSpace
        nil, --hNPCOwner
        nil, --hUnitOwner
        DOTA_TEAM_NOTEAM
   )
    
    local particle_cast = "particles/generic_gameplay/rune_arcane.vpcf"
    ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.lights[#self.lights])
end

function Round:CreateDeathZone()    
    CustomGameEventManager:Send_ServerToAllClients("custom_message", { text = "Death Zone has initiated!" })

    self.death_zone = CreateModifierThinker(
        nil, --hCaster
        nil, --hAbility
        "modifier_death_zone", --modifierName
        {}, --paramTable
        self.amethyst_entities[self.amethyst.index]:GetOrigin(), --vOrigin
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
        if pickup.entity then
            pickup.entity:Destroy()
        end

        self.pickups[_] = nil
    end
end

function Round:DestroyAmethyst()
    if self.amethyst.entity then
        self.amethyst.entity:Destroy(true)
        self.amethyst.entity = nil
    end 

    if self.amethyst.effect then
        ParticleManager:DestroyParticle(self.amethyst.effect, false)
        ParticleManager:ReleaseParticleIndex(self.amethyst.effect)
        self.amethyst.effect = nil
    end
end

