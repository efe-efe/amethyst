--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 3,["8"] = 3,["9"] = 3,["10"] = 9,["11"] = 9,["12"] = 9,["13"] = 9,["14"] = 9,["15"] = 15,["16"] = 9,["17"] = 10,["18"] = 11,["19"] = 13,["20"] = 17,["21"] = 19,["22"] = 19,["23"] = 19,["24"] = 20,["25"] = 20,["26"] = 20,["28"] = 21,["29"] = 21,["30"] = 22,["31"] = 23,["32"] = 24,["33"] = 24,["34"] = 24,["36"] = 25,["37"] = 26,["38"] = 27,["39"] = 21,["42"] = 20,["43"] = 20,["44"] = 19,["45"] = 19,["46"] = 15,["47"] = 35,["48"] = 36,["49"] = 37,["50"] = 37,["51"] = 37,["52"] = 37,["53"] = 38,["54"] = 39,["56"] = 35,["57"] = 43,["58"] = 44,["59"] = 44,["60"] = 44,["61"] = 44,["62"] = 45,["63"] = 46,["65"] = 43,["66"] = 50,["67"] = 9,["68"] = 53,["69"] = 53,["70"] = 53,["71"] = 54,["72"] = 53,["73"] = 53,["74"] = 57,["75"] = 58,["77"] = 50,["78"] = 62,["79"] = 63,["80"] = 62,["81"] = 9,["82"] = 9});
local ____exports = {}
local ____custom_ai = require("clases.custom_ai")
local CustomAIFactories = ____custom_ai.CustomAIFactories
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local CustomGameState = ____game_state.CustomGameState
____exports.default = (function()
    ____exports.default = __TS__Class()
    local Level = ____exports.default
    Level.name = "Level"
    __TS__ClassExtends(Level, GameState)
    function Level.prototype.____constructor(self, alliances, duration, wavesInfo)
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
                                EFX("particles/ai_spawn.vpcf", PATTACH_ABSORIGIN_FOLLOW, ai.unit, {release = true})
                                i = i + 1
                            end
                        end
                    end
                )
            end
        )
    end
    function Level.prototype.OnUnitDies(self, unit)
        local previousAis = #self.ais
        self.ais = __TS__ArrayFilter(
            self.ais,
            function(____, ai) return ai.unit ~= unit end
        )
        if previousAis > #self.ais then
            self.aliveAis = self.aliveAis - 1
        end
    end
    function Level.prototype.OnUnitHurt(self, unit)
        local ai = __TS__ArrayFilter(
            self.ais,
            function(____, ai) return ai.unit == unit end
        )[1]
        if ai then
            ai:OnHurt()
        end
    end
    function Level.prototype.Update(self)
        GameState.prototype.Update(self)
        __TS__ArrayForEach(
            self.ais,
            function(____, ai)
                ai:Update()
            end
        )
        if self.aliveAis <= 0 then
            self:EndLevel()
        end
    end
    function Level.prototype.EndLevel(self)
        GameRules.Addon:SetState(CustomGameState.PRE_LEVEL)
    end
    return Level
end)()
return ____exports
