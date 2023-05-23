local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__New = ____lualib.__TS__New
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["11"] = 2,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 3,["17"] = 4,["18"] = 4,["19"] = 4,["20"] = 5,["21"] = 5,["22"] = 21,["23"] = 21,["24"] = 21,["25"] = 21,["26"] = 39,["27"] = 21,["28"] = 23,["29"] = 24,["30"] = 25,["31"] = 26,["32"] = 27,["33"] = 28,["34"] = 29,["35"] = 30,["36"] = 42,["37"] = 42,["38"] = 42,["39"] = 42,["40"] = 43,["41"] = 44,["42"] = 45,["43"] = 46,["44"] = 47,["45"] = 49,["46"] = 50,["47"] = 51,["48"] = 53,["49"] = 53,["50"] = 53,["51"] = 53,["52"] = 53,["53"] = 53,["54"] = 60,["55"] = 61,["57"] = 63,["59"] = 39,["60"] = 67,["61"] = 68,["62"] = 68,["63"] = 68,["64"] = 69,["65"] = 69,["66"] = 69,["67"] = 69,["68"] = 69,["69"] = 69,["70"] = 69,["71"] = 68,["72"] = 68,["73"] = 67,["74"] = 78,["75"] = 79,["76"] = 80,["77"] = 82,["78"] = 82,["79"] = 82,["80"] = 83,["81"] = 84,["82"] = 85,["83"] = 86,["84"] = 87,["85"] = 87,["86"] = 87,["87"] = 87,["88"] = 87,["89"] = 88,["90"] = 89,["91"] = 89,["92"] = 89,["93"] = 89,["94"] = 89,["95"] = 90,["96"] = 90,["98"] = 82,["99"] = 82,["101"] = 78,["102"] = 96,["103"] = 21,["104"] = 98,["105"] = 99,["107"] = 102,["108"] = 103,["109"] = 104,["111"] = 107,["112"] = 108,["113"] = 109,["115"] = 111,["116"] = 112,["117"] = 113,["119"] = 115,["122"] = 119,["123"] = 119,["124"] = 119,["125"] = 120,["126"] = 121,["127"] = 122,["128"] = 123,["130"] = 125,["133"] = 128,["134"] = 129,["135"] = 130,["139"] = 119,["140"] = 119,["144"] = 139,["145"] = 140,["146"] = 142,["147"] = 143,["148"] = 144,["151"] = 148,["152"] = 149,["153"] = 151,["154"] = 152,["157"] = 96,["158"] = 157,["159"] = 158,["160"] = 159,["161"] = 160,["163"] = 162,["164"] = 163,["165"] = 164,["166"] = 165,["167"] = 157,["168"] = 168,["169"] = 169,["170"] = 169,["171"] = 169,["172"] = 170,["173"] = 171,["174"] = 169,["175"] = 169,["176"] = 174,["177"] = 168,["178"] = 177,["179"] = 178,["180"] = 179,["181"] = 177,["182"] = 182,["183"] = 183,["184"] = 184,["185"] = 185,["187"] = 182,["188"] = 189,["189"] = 190,["190"] = 192,["191"] = 193,["192"] = 194,["193"] = 195,["194"] = 197,["195"] = 197,["196"] = 197,["197"] = 198,["198"] = 199,["199"] = 201,["200"] = 202,["202"] = 205,["203"] = 206,["205"] = 209,["206"] = 209,["207"] = 209,["208"] = 209,["209"] = 209,["210"] = 210,["212"] = 197,["213"] = 197,["214"] = 214,["215"] = 215,["216"] = 216,["217"] = 218,["218"] = 220,["219"] = 221,["220"] = 222,["221"] = 225,["222"] = 228,["226"] = 232,["228"] = 237,["229"] = 237,["230"] = 237,["231"] = 238,["232"] = 239,["233"] = 240,["234"] = 241,["235"] = 242,["237"] = 237,["238"] = 237,["239"] = 246,["240"] = 247,["241"] = 248,["242"] = 249,["244"] = 252,["245"] = 253,["246"] = 256,["247"] = 258,["248"] = 258,["249"] = 258,["250"] = 259,["251"] = 260,["252"] = 261,["253"] = 262,["255"] = 264,["256"] = 258,["257"] = 258,["258"] = 267,["259"] = 189,["260"] = 270,["261"] = 271,["262"] = 273,["263"] = 273,["264"] = 273,["265"] = 274,["266"] = 275,["267"] = 276,["268"] = 278,["269"] = 279,["273"] = 273,["274"] = 273,["275"] = 285,["276"] = 270,["277"] = 288,["278"] = 289,["279"] = 291,["280"] = 291,["281"] = 291,["282"] = 292,["283"] = 293,["284"] = 294,["285"] = 294,["286"] = 294,["287"] = 294,["288"] = 296,["289"] = 297,["292"] = 291,["293"] = 291,["294"] = 302,["295"] = 288,["296"] = 305,["297"] = 306,["298"] = 305,["299"] = 309,["300"] = 310,["301"] = 311,["302"] = 314,["303"] = 314,["304"] = 314,["305"] = 314,["306"] = 314,["307"] = 314,["308"] = 314,["309"] = 314,["310"] = 314,["311"] = 309,["312"] = 325,["313"] = 326,["314"] = 327,["315"] = 328,["318"] = 325,["319"] = 333,["320"] = 334,["321"] = 334,["322"] = 334,["323"] = 335,["324"] = 336,["326"] = 334,["327"] = 334,["328"] = 339,["329"] = 333});
local ____exports = {}
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local CustomGameState = ____game_state.CustomGameState
local ____gem = require("clases.gem")
local GemWrapper = ____gem.default
local GemTypes = ____gem.GemTypes
local ____pickup = require("clases.pickup")
local Pickup = ____pickup.default
local PickupTypes = ____pickup.PickupTypes
local ____settings = require("settings")
local settings = ____settings.default
____exports.default = __TS__Class()
local Round = ____exports.default
Round.name = "Round"
__TS__ClassExtends(Round, GameState)
function Round.prototype.____constructor(self, alliances, duration)
    GameState.prototype.____constructor(self, alliances, duration)
    self.pickupWrappers = {}
    self.arrows = {}
    self.ended = false
    self.timeOver = false
    self.heroDied = false
    self.isTryingToEnd = false
    self.winner = nil
    self.timeRemianingUntilEnd = settings.DrawTime
    self.gemSpawnPoints = __TS__ArrayMap(
        Entities:FindAllByName("orb_spawn"),
        function(____, entity) return entity:GetAbsOrigin() end
    )
    self.healthEntities = Entities:FindAllByName("health_orb")
    self.manaEntities = Entities:FindAllByName("mana_orb")
    self.shieldEntities = Entities:FindAllByName("shield_orb")
    self.radiantWarmupSpawn = Entities:FindByName(nil, "radiant_warmup_spawn")
    self.direWarmupSpawn = Entities:FindByName(nil, "dire_warmup_spawn")
    self:AddPickups(self.healthEntities, PickupTypes.HEALTH)
    self:AddPickups(self.manaEntities, PickupTypes.MANA)
    self:AddPickups(self.shieldEntities, PickupTypes.SHIELD)
    self.gem = {
        index = RandomInt(0, 2),
        type = RandomInt(GemTypes.AMETHYST, GemTypes.EMERALD),
        entity = nil,
        number = 0
    }
    if RandomInt(0, 1) == 1 then
        GameRules:SetTimeOfDay(0)
    else
        GameRules:SetTimeOfDay(0.5)
    end
end
function Round.prototype.AddPickups(self, spawnEntities, ____type)
    __TS__ArrayForEach(
        spawnEntities,
        function(____, entity)
            local ____self_pickupWrappers_0 = self.pickupWrappers
            ____self_pickupWrappers_0[#____self_pickupWrappers_0 + 1] = {
                origin = entity:GetAbsOrigin(),
                type = ____type,
                timer = settings.PickupsCreationTime * 30,
                entity = nil
            }
        end
    )
end
function Round.prototype.SpawnArrows(self)
    if self.gem.entity then
        local color = self.gem.entity:GetColor()
        __TS__ArrayForEach(
            self.gemSpawnPoints,
            function(____, point, i)
                if i ~= self.gem.index then
                    local direction = self.gemSpawnPoints[self.gem.index + 1]:__sub(point):Normalized()
                    local efx = ParticleManager:CreateParticle("particles/gem_finder.vpcf", PATTACH_WORLDORIGIN, nil)
                    ParticleManager:SetParticleControl(efx, 0, point)
                    ParticleManager:SetParticleControl(
                        efx,
                        2,
                        point:__add(direction:__mul(Vector(128, 128, 0)))
                    )
                    ParticleManager:SetParticleControl(efx, 60, color)
                    ParticleManager:SetParticleControl(
                        efx,
                        61,
                        Vector(1, 0, 0)
                    )
                    local ____self_arrows_1 = self.arrows
                    ____self_arrows_1[#____self_arrows_1 + 1] = efx
                end
            end
        )
    end
end
function Round.prototype.Update(self)
    GameState.prototype.Update(self)
    if self.timeRemaining >= 0 then
        self:UpdateGameTimer(math.floor(self.timeRemaining / 30))
    end
    if self.timeRemaining == 0 and not self.timeOver and not self.infinite then
        self.timeOver = true
        self:CreateDeathZone()
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
        __TS__ArrayForEach(
            self.pickupWrappers,
            function(____, pickup)
                if pickup.timer ~= -1 then
                    if not pickup.entity then
                        if pickup.timer == 0 then
                            pickup.entity = __TS__New(Pickup, pickup.type, pickup.origin, nil)
                        else
                            pickup.timer = pickup.timer - 1
                        end
                    else
                        if not pickup.entity:Alive() then
                            pickup.timer = settings.PickupsCreationTime * 30
                            pickup.entity = nil
                        end
                    end
                end
            end
        )
    else
        return
    end
    if self.isTryingToEnd then
        self.timeRemianingUntilEnd = self.timeRemianingUntilEnd - FrameTime()
        if self.timeRemianingUntilEnd <= 0 then
            self.winner = self:GetCompetingAlliances()[1]
            self:EndRound()
        end
    end
    if self.heroDied then
        self.heroDied = false
        if self:CheckEndConditions() then
            self.isTryingToEnd = true
        end
    end
end
function Round.prototype.CreateGem(self)
    self.gem.type = RandomIntWithExeption(GemTypes.AMETHYST, GemTypes.EMERALD, self.gem.type)
    if not self.timeOver then
        self.gem.index = RandomIntWithExeption(0, #self.gemSpawnPoints - 1, self.gem.index)
    end
    local time = self.gem.number == 0 and settings.GemSpawnTime or settings.GemRespawnTime
    local origin = self.gemSpawnPoints[self.gem.index + 1]
    self.gem.number = self.gem.number + 1
    self.gem.entity = __TS__New(GemWrapper, time, origin, self.gem.type)
end
function Round.prototype.CleanArrows(self)
    __TS__ArrayForEach(
        self.arrows,
        function(____, arrow)
            ParticleManager:DestroyParticle(arrow, false)
            ParticleManager:ReleaseParticleIndex(arrow)
        end
    )
    self.arrows = {}
end
function Round.prototype.CreateGemAndArrows(self)
    self:CreateGem()
    self:SpawnArrows()
end
function Round.prototype.DestroyGem(self)
    if self.gem.entity then
        self.gem.entity:Destroy(true)
        self.gem.entity = nil
    end
end
function Round.prototype.EndRound(self)
    self.ended = true
    self:DestroyAllPickups()
    self:DestroyDeathZone()
    self:DestroyGem()
    self:CleanArrows()
    __TS__ArrayForEach(
        self:GetAllPlayers(),
        function(____, player)
            if player.alliance and player.hero then
                local target = self.radiantWarmupSpawn
                if player.alliance.name == "DOTA_ALLIANCE_DIRE" then
                    target = self.direWarmupSpawn
                end
                if not player.hero:IsAlive() then
                    player.hero:RespawnHero(false, false)
                end
                FindClearSpaceForUnit(
                    player.hero,
                    target:GetAbsOrigin(),
                    true
                )
                CustomEntitiesLegacy:Reset(player.hero)
            end
        end
    )
    local max_score = settings.RoundsDifferenceToWin
    local allinaces_with_one_point = 0
    local allinaces_with_two_points = 0
    self:DestroyAllPickups()
    if self.winner then
        local new_score = self.winner:GetScore() + 1
        self.winner:SetScore(new_score)
        if self.winner:GetScore() >= settings.RoundsToWin or self:GetHighestWinsDifference(self.winner) >= settings.RoundsDifferenceToWin then
            GameRules.Addon:EndGame(self.winner.teams[2])
            return
        end
    else
        CustomGameEventManager:Send_ServerToAllClients("custom_message", {text = "DRAW!"})
    end
    __TS__ArrayForEach(
        self.alliances,
        function(____, alliance)
            if alliance:GetScore() == 1 then
                allinaces_with_one_point = allinaces_with_one_point + 1
            elseif alliance:GetScore() > 1 then
                allinaces_with_one_point = allinaces_with_one_point + 1
                allinaces_with_two_points = allinaces_with_two_points + 1
            end
        end
    )
    if allinaces_with_two_points >= 2 then
        max_score = 5
    elseif allinaces_with_one_point >= 2 then
        max_score = 4
    end
    local tableName = "main"
    CustomNetTables:SetTableValue(tableName, "maxScore", {max_score = max_score})
    GameRules.Addon.round = nil
    __TS__ArrayForEach(
        self:GetAllPlayers(),
        function(____, player)
            local hero = player.hero
            local playerId = player:GetId()
            if hero then
                CustomEntitiesLegacy:SafeDestroyModifier(hero, "modifier_generic_provides_vision")
            end
            PlayerResource:SetCameraTarget(playerId, nil)
        end
    )
    GameRules.Addon:SetState(CustomGameState.WARMUP_IN_PROGRESS)
end
function Round.prototype.GetHighestWinsDifference(self, alliance)
    local difference = 0
    __TS__ArrayForEach(
        self.alliances,
        function(____, _alliance)
            if _alliance ~= alliance then
                if _alliance:IsActive() then
                    local _difference = alliance.wins - _alliance.wins
                    if _difference > difference then
                        difference = _difference
                    end
                end
            end
        end
    )
    return difference
end
function Round.prototype.GetCompetingAlliances(self)
    local alliances = {}
    __TS__ArrayForEach(
        self:GetAllPlayers(),
        function(____, player)
            if player.hero and not player.hero:IsNull() and player.hero:IsAlive() and player.alliance then
                local playerAlliance = player.alliance
                local alreadyAdded = #__TS__ArrayFilter(
                    alliances,
                    function(____, alliance) return alliance.name == playerAlliance.name end
                ) > 0
                if not alreadyAdded then
                    alliances[#alliances + 1] = playerAlliance
                end
            end
        end
    )
    return alliances
end
function Round.prototype.CheckEndConditions(self)
    return #self:GetCompetingAlliances() <= 1
end
function Round.prototype.CreateDeathZone(self)
    local tableName = "custom_message"
    CustomGameEventManager:Send_ServerToAllClients(tableName, {text = "Death Zone has initiated!"})
    self.death_zone = CreateModifierThinker(
        nil,
        nil,
        "modifier_death_zone",
        {},
        self.gemSpawnPoints[self.gem.index + 1],
        DOTA_TEAM_NOTEAM,
        false
    )
end
function Round.prototype.DestroyDeathZone(self)
    if self.death_zone then
        if not self.death_zone:IsNull() then
            self.death_zone:Destroy()
        end
    end
end
function Round.prototype.DestroyAllPickups(self)
    __TS__ArrayForEach(
        self.pickupWrappers,
        function(____, pickup)
            if pickup.entity then
                pickup.entity:Destroy()
            end
        end
    )
    self.pickupWrappers = {}
end
return ____exports
