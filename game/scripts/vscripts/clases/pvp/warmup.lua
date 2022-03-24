--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 3,["10"] = 5,["11"] = 13,["12"] = 13,["13"] = 13,["14"] = 13,["15"] = 13,["16"] = 16,["17"] = 13,["18"] = 14,["19"] = 18,["20"] = 20,["21"] = 20,["22"] = 20,["23"] = 21,["24"] = 21,["25"] = 21,["26"] = 21,["27"] = 21,["28"] = 24,["29"] = 24,["30"] = 24,["31"] = 21,["32"] = 21,["33"] = 21,["34"] = 20,["35"] = 20,["36"] = 16,["37"] = 29,["38"] = 13,["39"] = 31,["40"] = 32,["41"] = 32,["42"] = 32,["43"] = 34,["44"] = 35,["45"] = 35,["46"] = 35,["47"] = 36,["49"] = 39,["50"] = 39,["51"] = 39,["52"] = 40,["53"] = 41,["54"] = 42,["55"] = 43,["58"] = 46,["59"] = 47,["60"] = 48,["63"] = 39,["64"] = 39,["66"] = 53,["67"] = 54,["70"] = 29,["71"] = 59,["72"] = 60,["73"] = 62,["74"] = 62,["75"] = 62,["76"] = 63,["77"] = 62,["78"] = 62,["79"] = 66,["80"] = 59,["81"] = 69,["82"] = 70,["83"] = 70,["84"] = 70,["85"] = 72,["86"] = 73,["88"] = 70,["89"] = 70,["90"] = 69,["91"] = 13,["92"] = 13});
local ____exports = {}
local ____dummy_target = require("clases.dummy_target")
local DummyTarget = ____dummy_target.default
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local CustomGameState = ____game_state.CustomGameState
local DUMMY_TARGET_RESPAWN = 5
____exports.default = (function()
    ____exports.default = __TS__Class()
    local Warmup = ____exports.default
    Warmup.name = "Warmup"
    __TS__ClassExtends(Warmup, GameState)
    function Warmup.prototype.____constructor(self, alliances, duration)
        GameState.prototype.____constructor(self, alliances, duration)
        self.dummyTargets = {}
        local dummyTargetsEnts = Entities:FindAllByName("dummy_target")
        __TS__ArrayForEach(
            dummyTargetsEnts,
            function(____, entity)
                __TS__ArrayPush(
                    self.dummyTargets,
                    {
                        origin = entity:GetAbsOrigin(),
                        timer = 0,
                        entity = __TS__New(
                            DummyTarget,
                            entity:GetAbsOrigin()
                        )
                    }
                )
            end
        )
    end
    function Warmup.prototype.Update(self)
        GameState.prototype.Update(self)
        if self.timeRemaining > 0 then
            self:UpdateGameTimer(
                math.floor(self.timeRemaining / 30)
            )
            if (self.timeRemaining <= 30) and (self.timeRemaining > 0) then
                local data = {
                    text = tostring(self.timeRemaining / 30)
                }
                CustomGameEventManager:Send_ServerToAllClients("custom_message", data)
            end
            __TS__ArrayForEach(
                self.dummyTargets,
                function(____, dummyTarget)
                    if not dummyTarget.entity then
                        dummyTarget.timer = dummyTarget.timer - 1
                        if dummyTarget.timer <= 0 then
                            dummyTarget.entity = __TS__New(DummyTarget, dummyTarget.origin)
                        end
                    else
                        if not dummyTarget.entity:Alive() then
                            dummyTarget.timer = DUMMY_TARGET_RESPAWN * 30
                            dummyTarget.entity = nil
                        end
                    end
                end
            )
        else
            if self.maxDuration ~= -1 then
                self:EndWarmup()
            end
        end
    end
    function Warmup.prototype.EndWarmup(self)
        self:DestroyAllDummyTargets()
        __TS__ArrayForEach(
            self.alliances,
            function(____, alliance)
                alliance:SetAmethysts(0)
            end
        )
        GameRules.Addon:SetState(CustomGameState.PRE_ROUND)
    end
    function Warmup.prototype.DestroyAllDummyTargets(self)
        __TS__ArrayForEach(
            self.dummyTargets,
            function(____, dummyTarget)
                if dummyTarget.entity then
                    dummyTarget.entity:Destroy(true)
                end
            end
        )
    end
    return Warmup
end)()
return ____exports
