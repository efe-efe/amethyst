local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__New = ____lualib.__TS__New
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["11"] = 2,["12"] = 2,["13"] = 2,["14"] = 3,["15"] = 3,["16"] = 3,["17"] = 4,["18"] = 4,["19"] = 4,["20"] = 5,["21"] = 5,["22"] = 21,["23"] = 21,["24"] = 21,["25"] = 21,["26"] = 39,["27"] = 21,["28"] = 23,["29"] = 24,["30"] = 25,["31"] = 26,["32"] = 27,["33"] = 28,["34"] = 29,["35"] = 30,["36"] = 42,["37"] = 42,["38"] = 42,["39"] = 42,["40"] = 45,["41"] = 46,["42"] = 47,["43"] = 48,["44"] = 52,["45"] = 54,["46"] = 55,["47"] = 56,["48"] = 58,["49"] = 58,["50"] = 58,["51"] = 58,["52"] = 58,["53"] = 58,["54"] = 65,["55"] = 66,["57"] = 68,["59"] = 39,["60"] = 72,["61"] = 73,["62"] = 73,["63"] = 73,["64"] = 74,["65"] = 74,["66"] = 74,["67"] = 74,["68"] = 74,["69"] = 74,["70"] = 74,["71"] = 73,["72"] = 73,["73"] = 72,["74"] = 83,["75"] = 84,["76"] = 85,["77"] = 87,["78"] = 87,["79"] = 87,["80"] = 88,["81"] = 89,["82"] = 92,["83"] = 97,["84"] = 98,["85"] = 98,["86"] = 98,["87"] = 98,["88"] = 98,["89"] = 103,["90"] = 104,["91"] = 104,["92"] = 104,["93"] = 104,["94"] = 104,["95"] = 105,["96"] = 105,["98"] = 87,["99"] = 87,["101"] = 83,["102"] = 111,["103"] = 21,["104"] = 113,["105"] = 114,["107"] = 117,["108"] = 118,["109"] = 119,["111"] = 122,["112"] = 123,["113"] = 124,["115"] = 126,["116"] = 127,["117"] = 128,["119"] = 130,["122"] = 134,["123"] = 134,["124"] = 134,["125"] = 135,["126"] = 136,["127"] = 137,["128"] = 138,["130"] = 140,["133"] = 143,["134"] = 144,["135"] = 145,["139"] = 134,["140"] = 134,["144"] = 154,["145"] = 155,["146"] = 157,["147"] = 158,["148"] = 159,["151"] = 163,["152"] = 164,["153"] = 166,["154"] = 167,["157"] = 111,["158"] = 172,["159"] = 173,["160"] = 178,["161"] = 179,["163"] = 185,["164"] = 187,["165"] = 188,["166"] = 189,["167"] = 172,["168"] = 192,["169"] = 193,["170"] = 193,["171"] = 193,["172"] = 194,["173"] = 195,["174"] = 193,["175"] = 193,["176"] = 198,["177"] = 192,["178"] = 201,["179"] = 202,["180"] = 203,["181"] = 201,["182"] = 206,["183"] = 207,["184"] = 208,["185"] = 209,["187"] = 206,["188"] = 213,["189"] = 214,["190"] = 216,["191"] = 217,["192"] = 218,["193"] = 219,["194"] = 221,["195"] = 221,["196"] = 221,["197"] = 222,["198"] = 223,["199"] = 225,["200"] = 226,["202"] = 229,["203"] = 230,["205"] = 233,["206"] = 233,["207"] = 233,["208"] = 233,["209"] = 233,["210"] = 234,["212"] = 221,["213"] = 221,["214"] = 238,["215"] = 239,["216"] = 240,["217"] = 242,["218"] = 244,["219"] = 245,["220"] = 246,["221"] = 249,["222"] = 253,["226"] = 257,["228"] = 262,["229"] = 262,["230"] = 262,["231"] = 263,["232"] = 264,["233"] = 265,["234"] = 266,["235"] = 267,["237"] = 262,["238"] = 262,["239"] = 271,["240"] = 272,["241"] = 273,["242"] = 274,["244"] = 277,["245"] = 278,["246"] = 281,["247"] = 283,["248"] = 283,["249"] = 283,["250"] = 284,["251"] = 285,["252"] = 286,["253"] = 287,["255"] = 292,["256"] = 283,["257"] = 283,["258"] = 295,["259"] = 213,["260"] = 298,["261"] = 299,["262"] = 301,["263"] = 301,["264"] = 301,["265"] = 302,["266"] = 303,["267"] = 304,["268"] = 306,["269"] = 307,["273"] = 301,["274"] = 301,["275"] = 313,["276"] = 298,["277"] = 316,["278"] = 317,["279"] = 319,["280"] = 319,["281"] = 319,["282"] = 321,["283"] = 326,["284"] = 327,["285"] = 328,["286"] = 328,["287"] = 328,["288"] = 331,["289"] = 332,["292"] = 319,["293"] = 319,["294"] = 337,["295"] = 316,["296"] = 340,["297"] = 341,["298"] = 340,["299"] = 344,["300"] = 345,["301"] = 346,["302"] = 349,["303"] = 349,["304"] = 349,["305"] = 349,["306"] = 349,["307"] = 349,["308"] = 349,["309"] = 349,["310"] = 349,["311"] = 344,["312"] = 360,["313"] = 361,["314"] = 362,["315"] = 363,["318"] = 360,["319"] = 368,["320"] = 369,["321"] = 369,["322"] = 369,["323"] = 370,["324"] = 371,["326"] = 369,["327"] = 369,["328"] = 374,["329"] = 368});
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
