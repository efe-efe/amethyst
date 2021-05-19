--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 3,["10"] = 9,["11"] = 9,["12"] = 9,["13"] = 9,["14"] = 9,["15"] = 15,["16"] = 9,["17"] = 10,["18"] = 11,["19"] = 13,["20"] = 17,["21"] = 19,["22"] = 19,["23"] = 19,["24"] = 20,["25"] = 20,["26"] = 20,["28"] = 21,["29"] = 21,["30"] = 22,["31"] = 23,["32"] = 24,["33"] = 24,["34"] = 24,["36"] = 25,["37"] = 26,["38"] = 21,["41"] = 20,["42"] = 20,["43"] = 19,["44"] = 19,["45"] = 15,["46"] = 32,["47"] = 33,["48"] = 34,["49"] = 34,["50"] = 34,["51"] = 34,["52"] = 35,["53"] = 36,["55"] = 32,["56"] = 40,["57"] = 41,["58"] = 41,["59"] = 41,["60"] = 41,["61"] = 42,["62"] = 43,["64"] = 40,["65"] = 47,["66"] = 9,["67"] = 50,["68"] = 50,["69"] = 50,["70"] = 51,["71"] = 50,["72"] = 50,["73"] = 54,["74"] = 55,["76"] = 47,["77"] = 59,["78"] = 60,["79"] = 59,["80"] = 9,["81"] = 9});
local ____exports = {}
local ____custom_ai = require("clases.custom_ai")
local CustomAIFactories = ____custom_ai.CustomAIFactories
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local CustomGameState = ____game_state.CustomGameState
____exports.default = (function()
    ____exports.default = __TS__Class()
    local Wave = ____exports.default
    Wave.name = "Wave"
    __TS__ClassExtends(Wave, GameState)
    function Wave.prototype.____constructor(self, alliances, duration, wavesInfo)
        GameState.prototype.____constructor(self, alliances, duration)
        self.helper = 3 * 30
        self.ais = {}
        self.aliveAis = 0
        self.wavesInfo = wavesInfo
        __TS__ArrayForEach(
            wavesInfo,
            function(____, waveInfo)
                __TS__ArrayForEach(
                    waveInfo,
                    function(____, waveGroup)
                        do
                            local i = 0
                            while i < waveGroup.ammount do
                                local x = RandomInt(-1500, 1500)
                                local y = RandomInt(-1500, 1500)
                                local ai = CustomAIFactories[waveGroup.name](
                                    CustomAIFactories,
                                    Vector(x, y, 128)
                                )
                                __TS__ArrayPush(self.ais, ai)
                                self.aliveAis = self.aliveAis + 1
                                i = i + 1
                            end
                        end
                    end
                )
            end
        )
    end
    function Wave.prototype.OnUnitDies(self, unit)
        local previousAis = #self.ais
        self.ais = __TS__ArrayFilter(
            self.ais,
            function(____, ai) return ai.unit ~= unit end
        )
        if previousAis > #self.ais then
            self.aliveAis = self.aliveAis - 1
        end
    end
    function Wave.prototype.OnUnitHurt(self, unit)
        local ai = __TS__ArrayFilter(
            self.ais,
            function(____, ai) return ai.unit == unit end
        )[1]
        if ai then
            ai:OnHurt()
        end
    end
    function Wave.prototype.Update(self)
        GameState.prototype.Update(self)
        __TS__ArrayForEach(
            self.ais,
            function(____, ai)
                ai:Update()
            end
        )
        if self.aliveAis <= 0 then
            self:EndWave()
        end
    end
    function Wave.prototype.EndWave(self)
        GameRules.Addon:SetState(CustomGameState.PRE_WAVE)
    end
    return Wave
end)()
return ____exports
