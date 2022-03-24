--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 3,["6"] = 3,["7"] = 3,["8"] = 4,["9"] = 4,["10"] = 4,["11"] = 5,["12"] = 5,["13"] = 5,["14"] = 6,["15"] = 6,["16"] = 22,["17"] = 22,["18"] = 22,["19"] = 22,["20"] = 22,["21"] = 40,["22"] = 22,["23"] = 24,["24"] = 25,["25"] = 26,["26"] = 27,["27"] = 28,["28"] = 29,["29"] = 30,["30"] = 31,["31"] = 43,["32"] = 43,["33"] = 43,["34"] = 43,["35"] = 44,["36"] = 45,["37"] = 46,["38"] = 47,["39"] = 48,["40"] = 50,["41"] = 51,["42"] = 52,["43"] = 54,["44"] = 54,["45"] = 54,["46"] = 54,["47"] = 54,["48"] = 54,["49"] = 61,["50"] = 62,["52"] = 64,["54"] = 40,["55"] = 68,["56"] = 69,["57"] = 69,["58"] = 69,["59"] = 70,["60"] = 70,["61"] = 70,["62"] = 70,["63"] = 70,["64"] = 70,["65"] = 70,["66"] = 70,["67"] = 70,["68"] = 69,["69"] = 69,["70"] = 68,["71"] = 79,["72"] = 80,["73"] = 81,["74"] = 83,["75"] = 83,["76"] = 83,["77"] = 84,["78"] = 85,["79"] = 86,["80"] = 87,["81"] = 88,["82"] = 88,["83"] = 88,["84"] = 88,["85"] = 88,["86"] = 88,["87"] = 88,["88"] = 88,["89"] = 88,["90"] = 89,["91"] = 90,["92"] = 90,["93"] = 90,["94"] = 90,["95"] = 90,["96"] = 91,["98"] = 83,["99"] = 83,["101"] = 79,["102"] = 97,["103"] = 22,["104"] = 99,["105"] = 100,["106"] = 100,["107"] = 100,["109"] = 103,["110"] = 104,["111"] = 105,["112"] = 106,["115"] = 110,["116"] = 111,["117"] = 112,["119"] = 114,["120"] = 115,["121"] = 116,["123"] = 118,["126"] = 122,["127"] = 122,["128"] = 122,["129"] = 123,["130"] = 124,["131"] = 125,["132"] = 126,["134"] = 128,["137"] = 131,["138"] = 132,["139"] = 133,["143"] = 122,["144"] = 122,["148"] = 142,["149"] = 143,["150"] = 145,["151"] = 146,["152"] = 147,["155"] = 151,["156"] = 152,["157"] = 154,["158"] = 155,["161"] = 97,["162"] = 160,["163"] = 161,["164"] = 162,["165"] = 163,["167"] = 165,["168"] = 166,["169"] = 167,["170"] = 168,["171"] = 160,["172"] = 171,["173"] = 172,["174"] = 172,["175"] = 172,["176"] = 173,["177"] = 174,["178"] = 172,["179"] = 172,["180"] = 177,["181"] = 171,["182"] = 180,["183"] = 181,["184"] = 182,["185"] = 180,["186"] = 185,["187"] = 186,["188"] = 187,["189"] = 188,["191"] = 185,["192"] = 192,["193"] = 193,["194"] = 195,["195"] = 196,["196"] = 197,["197"] = 198,["198"] = 200,["199"] = 200,["200"] = 200,["201"] = 201,["202"] = 202,["203"] = 204,["204"] = 205,["206"] = 208,["207"] = 209,["209"] = 212,["210"] = 212,["211"] = 212,["212"] = 212,["213"] = 212,["214"] = 213,["216"] = 200,["217"] = 200,["218"] = 217,["219"] = 218,["220"] = 219,["221"] = 221,["222"] = 223,["223"] = 224,["224"] = 225,["225"] = 227,["226"] = 228,["230"] = 232,["232"] = 235,["233"] = 235,["234"] = 235,["235"] = 236,["236"] = 237,["237"] = 238,["238"] = 239,["239"] = 240,["241"] = 235,["242"] = 235,["243"] = 244,["244"] = 245,["245"] = 246,["246"] = 247,["248"] = 250,["249"] = 251,["250"] = 252,["251"] = 254,["252"] = 254,["253"] = 254,["254"] = 255,["255"] = 256,["256"] = 257,["257"] = 258,["259"] = 260,["260"] = 254,["261"] = 254,["262"] = 263,["263"] = 192,["264"] = 266,["265"] = 267,["266"] = 269,["267"] = 269,["268"] = 269,["269"] = 270,["270"] = 271,["271"] = 272,["272"] = 274,["273"] = 275,["277"] = 269,["278"] = 269,["279"] = 281,["280"] = 266,["281"] = 284,["282"] = 285,["283"] = 287,["284"] = 287,["285"] = 287,["286"] = 288,["287"] = 289,["288"] = 290,["289"] = 290,["290"] = 290,["291"] = 290,["292"] = 292,["293"] = 293,["296"] = 287,["297"] = 287,["298"] = 298,["299"] = 284,["300"] = 301,["301"] = 302,["302"] = 301,["303"] = 305,["304"] = 306,["305"] = 307,["306"] = 308,["307"] = 305,["308"] = 319,["309"] = 320,["310"] = 321,["311"] = 322,["314"] = 319,["315"] = 327,["316"] = 328,["317"] = 328,["318"] = 328,["319"] = 329,["320"] = 330,["322"] = 328,["323"] = 328,["324"] = 333,["325"] = 327,["326"] = 22,["327"] = 22});
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
____exports.default = (function()
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
                __TS__ArrayPush(
                    self.pickupWrappers,
                    {
                        origin = entity:GetAbsOrigin(),
                        type = ____type,
                        timer = settings.PickupsCreationTime * 30,
                        entity = nil
                    }
                )
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
                            point:__add(
                                direction:__mul(
                                    Vector(128, 128, 0)
                                )
                            )
                        )
                        ParticleManager:SetParticleControl(efx, 60, color)
                        ParticleManager:SetParticleControl(
                            efx,
                            61,
                            Vector(1, 0, 0)
                        )
                        __TS__ArrayPush(self.arrows, efx)
                    end
                end
            )
        end
    end
    function Round.prototype.Update(self)
        GameState.prototype.Update(self)
        if self.timeRemaining >= 0 then
            self:UpdateGameTimer(
                math.floor(self.timeRemaining / 30)
            )
        end
        if (self.timeRemaining == 0) and (not self.timeOver) then
            if self.maxDuration ~= -1 then
                self.timeOver = true
                self:CreateDeathZone()
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
        local time = ((self.gem.number == 0) and settings.GemSpawnTime) or settings.GemRespawnTime
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
            if (self.winner:GetScore() >= settings.RoundsToWin) or (self:GetHighestWinsDifference(self.winner) >= settings.RoundsDifferenceToWin) then
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
                if ((player.hero and (not player.hero:IsNull())) and player.hero:IsAlive()) and player.alliance then
                    local playerAlliance = player.alliance
                    local alreadyAdded = #__TS__ArrayFilter(
                        alliances,
                        function(____, alliance) return alliance.name == playerAlliance.name end
                    ) > 0
                    if not alreadyAdded then
                        __TS__ArrayPush(alliances, playerAlliance)
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
        self.death_zone = CreateModifierThinker(nil, nil, "modifier_death_zone", {}, self.gemSpawnPoints[self.gem.index + 1], DOTA_TEAM_NOTEAM, false)
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
    return Round
end)()
return ____exports
