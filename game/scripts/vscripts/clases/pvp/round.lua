--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 2,["8"] = 3,["9"] = 3,["10"] = 3,["11"] = 4,["12"] = 4,["13"] = 4,["14"] = 5,["15"] = 5,["16"] = 21,["17"] = 21,["18"] = 21,["19"] = 21,["20"] = 21,["21"] = 39,["22"] = 21,["23"] = 23,["24"] = 24,["25"] = 25,["26"] = 26,["27"] = 27,["28"] = 28,["29"] = 29,["30"] = 30,["31"] = 42,["32"] = 42,["33"] = 42,["34"] = 42,["35"] = 45,["36"] = 46,["37"] = 47,["38"] = 48,["39"] = 52,["40"] = 54,["41"] = 55,["42"] = 56,["43"] = 58,["44"] = 58,["45"] = 58,["46"] = 58,["47"] = 58,["48"] = 58,["49"] = 65,["50"] = 66,["52"] = 68,["54"] = 39,["55"] = 72,["56"] = 73,["57"] = 73,["58"] = 73,["59"] = 74,["60"] = 74,["61"] = 74,["62"] = 74,["63"] = 74,["64"] = 74,["65"] = 74,["66"] = 74,["67"] = 74,["68"] = 73,["69"] = 73,["70"] = 72,["71"] = 83,["72"] = 84,["73"] = 85,["74"] = 87,["75"] = 87,["76"] = 87,["77"] = 88,["78"] = 89,["79"] = 92,["80"] = 97,["81"] = 98,["82"] = 98,["83"] = 98,["84"] = 101,["85"] = 101,["86"] = 101,["87"] = 101,["88"] = 98,["89"] = 98,["90"] = 103,["91"] = 104,["92"] = 104,["93"] = 104,["94"] = 104,["95"] = 104,["96"] = 105,["98"] = 87,["99"] = 87,["101"] = 83,["102"] = 111,["103"] = 21,["104"] = 113,["105"] = 114,["106"] = 114,["107"] = 114,["109"] = 117,["110"] = 118,["111"] = 119,["113"] = 122,["114"] = 123,["115"] = 124,["117"] = 126,["118"] = 127,["119"] = 128,["121"] = 130,["124"] = 134,["125"] = 134,["126"] = 134,["127"] = 135,["128"] = 136,["129"] = 137,["130"] = 138,["132"] = 140,["135"] = 143,["136"] = 144,["137"] = 145,["141"] = 134,["142"] = 134,["146"] = 154,["147"] = 155,["148"] = 157,["149"] = 158,["150"] = 159,["153"] = 163,["154"] = 164,["155"] = 166,["156"] = 167,["159"] = 111,["160"] = 172,["161"] = 173,["162"] = 178,["163"] = 179,["165"] = 185,["166"] = 187,["167"] = 188,["168"] = 189,["169"] = 172,["170"] = 192,["171"] = 193,["172"] = 193,["173"] = 193,["174"] = 194,["175"] = 195,["176"] = 193,["177"] = 193,["178"] = 198,["179"] = 192,["180"] = 201,["181"] = 202,["182"] = 203,["183"] = 201,["184"] = 206,["185"] = 207,["186"] = 208,["187"] = 209,["189"] = 206,["190"] = 213,["191"] = 214,["192"] = 216,["193"] = 217,["194"] = 218,["195"] = 219,["196"] = 221,["197"] = 221,["198"] = 221,["199"] = 222,["200"] = 223,["201"] = 225,["202"] = 226,["204"] = 229,["205"] = 230,["207"] = 233,["208"] = 233,["209"] = 233,["210"] = 233,["211"] = 233,["212"] = 234,["214"] = 221,["215"] = 221,["216"] = 238,["217"] = 239,["218"] = 240,["219"] = 242,["220"] = 244,["221"] = 245,["222"] = 246,["223"] = 249,["224"] = 253,["228"] = 257,["230"] = 262,["231"] = 262,["232"] = 262,["233"] = 263,["234"] = 264,["235"] = 265,["236"] = 266,["237"] = 267,["239"] = 262,["240"] = 262,["241"] = 271,["242"] = 272,["243"] = 273,["244"] = 274,["246"] = 277,["247"] = 278,["248"] = 281,["249"] = 283,["250"] = 283,["251"] = 283,["252"] = 284,["253"] = 285,["254"] = 286,["255"] = 287,["257"] = 292,["258"] = 283,["259"] = 283,["260"] = 295,["261"] = 213,["262"] = 298,["263"] = 299,["264"] = 301,["265"] = 301,["266"] = 301,["267"] = 302,["268"] = 303,["269"] = 304,["270"] = 306,["271"] = 307,["275"] = 301,["276"] = 301,["277"] = 313,["278"] = 298,["279"] = 316,["280"] = 317,["281"] = 319,["282"] = 319,["283"] = 319,["284"] = 321,["285"] = 326,["286"] = 327,["287"] = 328,["288"] = 328,["289"] = 328,["290"] = 331,["291"] = 332,["294"] = 319,["295"] = 319,["296"] = 337,["297"] = 316,["298"] = 340,["299"] = 341,["300"] = 340,["301"] = 344,["302"] = 345,["303"] = 346,["304"] = 349,["305"] = 344,["306"] = 360,["307"] = 361,["308"] = 362,["309"] = 363,["312"] = 360,["313"] = 368,["314"] = 369,["315"] = 369,["316"] = 369,["317"] = 370,["318"] = 371,["320"] = 369,["321"] = 369,["322"] = 374,["323"] = 368,["324"] = 21,["325"] = 21});
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
        if ((self.timeRemaining == 0) and (not self.timeOver)) and (not self.infinite) then
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
