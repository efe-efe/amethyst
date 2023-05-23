local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__New = ____lualib.__TS__New
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 3,["13"] = 3,["14"] = 5,["15"] = 13,["16"] = 13,["17"] = 13,["18"] = 13,["19"] = 16,["20"] = 13,["21"] = 14,["22"] = 18,["23"] = 20,["24"] = 20,["25"] = 20,["26"] = 21,["27"] = 21,["28"] = 21,["29"] = 21,["30"] = 24,["31"] = 24,["32"] = 24,["33"] = 21,["34"] = 21,["35"] = 20,["36"] = 20,["37"] = 16,["38"] = 29,["39"] = 13,["40"] = 31,["41"] = 32,["42"] = 34,["43"] = 35,["44"] = 36,["46"] = 39,["47"] = 39,["48"] = 39,["49"] = 40,["50"] = 41,["51"] = 42,["52"] = 43,["55"] = 46,["56"] = 47,["57"] = 48,["60"] = 39,["61"] = 39,["63"] = 53,["64"] = 54,["67"] = 29,["68"] = 59,["69"] = 60,["70"] = 62,["71"] = 62,["72"] = 62,["73"] = 63,["74"] = 62,["75"] = 62,["76"] = 66,["77"] = 59,["78"] = 69,["79"] = 70,["80"] = 70,["81"] = 70,["82"] = 71,["83"] = 72,["85"] = 70,["86"] = 70,["87"] = 69});
local ____exports = {}
local ____dummy_target = require("clases.dummy_target")
local DummyTarget = ____dummy_target.default
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local CustomGameState = ____game_state.CustomGameState
local DUMMY_TARGET_RESPAWN = 5
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
            local ____self_dummyTargets_0 = self.dummyTargets
            ____self_dummyTargets_0[#____self_dummyTargets_0 + 1] = {
                origin = entity:GetAbsOrigin(),
                timer = 0,
                entity = __TS__New(
                    DummyTarget,
                    entity:GetAbsOrigin()
                )
            }
        end
    )
end
function Warmup.prototype.Update(self)
    GameState.prototype.Update(self)
    if self.timeRemaining > 0 then
        self:UpdateGameTimer(math.floor(self.timeRemaining / 30))
        if self.timeRemaining <= 30 and self.timeRemaining > 0 then
            local data = {text = tostring(self.timeRemaining / 30)}
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
        if not self.infinite then
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
return ____exports
