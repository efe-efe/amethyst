Round = Round or class({}, nil, GameState)

local PICKUPS_TIMER = PICKUPS_CREATION_TIME
local ROUND_TIMER = ROUND_DURATION
local DRAW_TIME = 3.0

function Round:constructor(alliances)
    getbase(Round).constructor(self, alliances)
    self.death_zone = nil
    self.winner = nil

    self.pickups = {}
    self.arrows = {}

    self.ended = false
    self.time_over = false
    self.hero_died = false
    self.ended = false
    self.is_trying_to_end = false

    self.time_remianing_until_end = DRAW_TIME
    self.time_remaining = ROUND_TIMER * 30

    self.gem_spawn_entities = Entities:FindAllByName("orb_spawn")
    self.health_entities = Entities:FindAllByName("health_orb")
    self.mana_entities = Entities:FindAllByName("mana_orb")
    self.shield_entities = Entities:FindAllByName("shield_orb")

    self.radiant_warmup_spawn = Entities:FindByName(nil, "radiant_warmup_spawn")
    self.dire_warmup_spawn = Entities:FindByName(nil, "dire_warmup_spawn")

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

    self.gem = {
        index = RandomInt(1, 3),
        type = RandomInt(GemTypes.AMETHYST, GemTypes.EMERALD),
        entity = nil,
        number = 0,
    }

    if RandomInt(0, 1) == 1 then
        GameRules:SetTimeOfDay(0.0)
    else
        GameRules:SetTimeOfDay(0.5)
    end
end

function Round:SpawnArrows()
    local color = self.gem.entity:GetColor()

    for _,entity in pairs(self.gem_spawn_entities) do
        if _ ~= self.gem.index then 
            local origin = entity:GetAbsOrigin()
            local direction = (self.gem_spawn_entities[self.gem.index]:GetOrigin() - origin):Normalized()
            self.arrows[entity] = ParticleManager:CreateParticle("particles/gem_finder.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager:SetParticleControl(self.arrows[entity], 0, origin)
            ParticleManager:SetParticleControl(self.arrows[entity], 2, origin + direction * Vector(128, 128, 0))
            ParticleManager:SetParticleControl(self.arrows[entity], 60, color)
            ParticleManager:SetParticleControl(self.arrows[entity], 61, Vector(1, 0, 0))
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
        if not self.gem.entity then
            self:CreateGemAndArrows()
        else
            if not self.gem.entity:Alive() then
                self.gem.entity = nil
                self:CleanArrows()
            else
                self.gem.entity:Update()
            end
        end

        for _,pickup in ipairs(self.pickups) do
            if pickup.timer ~= -1 then
                if not pickup.entity then
                    if pickup.timer == 0 then
                        pickup.entity = Pickup(pickup.type, pickup.origin, nil)
                    else
                        pickup.timer = pickup.timer - 1
                    end
                else
                    if not pickup.entity:Alive() then
                        pickup.timer = PICKUPS_TIMER * 30
                        pickup.entity = nil
                    end
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

function Round:CreateGem()
    self.gem.type = RandomIntWithExeption(GemTypes.AMETHYST, GemTypes.EMERALD, self.gem.type)
    if not self.time_over then
        self.gem.index = RandomIntWithExeption(1, #self.gem_spawn_entities, self.gem.index)
    end
    local time = self.gem.number == 0 and GEM_SPAWN_TIME or GEM_RESPAWN_TIME
    local origin = self.gem_spawn_entities[self.gem.index]:GetAbsOrigin()
    self.gem.number = self.gem.number + 1
    self.gem.entity = GemGenerator(time, origin, self.gem.type)
end

function Round:CreateGemAndArrows()
    self:CreateGem()
    self:SpawnArrows()
end

function Round:EndRound()       
    self.ended = true

    self:DestroyAllPickups()
    self:DestroyDeathZone()
    self:DestroyGem()
    self:CleanArrows()

    for _,player in pairs(self:GetAllPlayers()) do
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
        CustomEntities:Reset(player.hero)
    end

    local max_score = ROUNDS_DIFFERENCE_TO_WIN
    local allinaces_with_one_point = 0
    local allinaces_with_two_points = 0

    self:DestroyAllPickups() -- Remove death orbs

    if self.winner then
        local new_score = self.winner:GetScore() + 1
        self.winner:SetScore(new_score)

        if  self.winner:GetScore() >= ROUNDS_TO_WIN or self:GetHighestWinsDifference(self.winner) >= ROUNDS_DIFFERENCE_TO_WIN then
            GameRules.GameMode:EndGame(self.winner.teams[1]) 
            return
        end
    else
        CustomGameEventManager:Send_ServerToAllClients("custom_message", { text = "DRAW!" })
    end

    for _,alliance in pairs(self.alliances) do
        if alliance:GetScore() == 1 then
            allinaces_with_one_point = allinaces_with_one_point + 1
        elseif alliance:GetScore() > 1 then
            allinaces_with_one_point = allinaces_with_one_point + 1
            allinaces_with_two_points = allinaces_with_two_points + 1
        end
    end

    if allinaces_with_two_points >= 2 then
        max_score = 5
    elseif allinaces_with_one_point >= 2 then
        max_score = 4
    end
    
    CustomNetTables:SetTableValue("main", "maxScore", { max_score = max_score })

    GameRules.GameMode.round = nil

    for _,player in pairs(self:GetAllPlayers()) do
        local hero = player.hero
        local playerId = player:GetId()
        CustomEntities:SafeDestroyModifier(hero, "modifier_generic_provides_vision")
        PlayerResource:SetCameraTarget(playerId, nil)
    end

    GameRules.GameMode.round = nil
    GameRules.GameMode.warmup = Warmup(self.alliances)
    GameRules.GameMode:SetState(CustomGameState.WARMUP_IN_PROGRESS)
end

function Round:GetHighestWinsDifference(alliance)
    local difference = 0

    for _,m_alliance in pairs(self.alliances) do
        if m_alliance ~= alliance then
            if next(m_alliance.players) ~= nil then
                local m_difference = alliance.wins - m_alliance.wins

                if m_difference > difference then
                    difference = m_difference 
                end
            end
        end
    end 

    return difference
end
    
function Round:GetLastOrNoneAlive()
    local alliances = {}

    for _,player in pairs(self:GetAllPlayers()) do
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

function Round:CleanArrows()
    for _,arrow in pairs(self.arrows) do
        ParticleManager:DestroyParticle(arrow, false)
        ParticleManager:ReleaseParticleIndex(arrow)
    end
end

function Round:CreateDeathZone()    
    CustomGameEventManager:Send_ServerToAllClients("custom_message", { text = "Death Zone has initiated!" })

    self.death_zone = CreateModifierThinker(
        nil, --hCaster
        nil, --hAbility
        "modifier_death_zone", --modifierName
        {}, --paramTable
        self.gem_spawn_entities[self.gem.index]:GetOrigin(), --vOrigin
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

function Round:DestroyGem()
    if self.gem.entity then
        self.gem.entity:Destroy(true)
        self.gem.entity = nil
    end 
end