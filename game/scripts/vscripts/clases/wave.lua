--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 3,["12"] = 10,["13"] = 11,["14"] = 12,["15"] = 13,["16"] = 16,["17"] = 17,["18"] = 18,["19"] = 16,["20"] = 20,["21"] = 21,["22"] = 16,["23"] = 23,["24"] = 24,["25"] = 16,["26"] = 16,["27"] = 28,["28"] = 28,["29"] = 28,["30"] = 28,["31"] = 28,["32"] = 34,["33"] = 28,["34"] = 29,["35"] = 30,["36"] = 32,["37"] = 36,["38"] = 38,["39"] = 38,["40"] = 38,["41"] = 39,["42"] = 39,["43"] = 39,["45"] = 40,["46"] = 40,["47"] = 41,["48"] = 42,["49"] = 43,["50"] = 43,["51"] = 43,["53"] = 44,["54"] = 45,["55"] = 40,["58"] = 39,["59"] = 39,["60"] = 38,["61"] = 38,["62"] = 34,["63"] = 51,["64"] = 52,["65"] = 53,["66"] = 53,["67"] = 53,["68"] = 53,["69"] = 54,["70"] = 55,["72"] = 51,["73"] = 59,["74"] = 28,["75"] = 62,["76"] = 62,["77"] = 62,["78"] = 63,["79"] = 62,["80"] = 62,["81"] = 66,["82"] = 67,["84"] = 59,["85"] = 71,["86"] = 72,["87"] = 71,["88"] = 28,["89"] = 28});
local ____exports = {}
local ____custom_ai = require("clases.custom_ai")
local Centaur = ____custom_ai.Centaur
local DireZombie = ____custom_ai.DireZombie
local Queen = ____custom_ai.Queen
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local CustomGameState = ____game_state.CustomGameState
____exports.NPCNames = NPCNames or ({})
____exports.NPCNames.DIRE_ZOMBIE = "DireZombie"
____exports.NPCNames.QUEEN = "Queen"
____exports.NPCNames.CENTAUR = "Centaur"
local NPCFactories = {
    [____exports.NPCNames.DIRE_ZOMBIE] = function(____, origin)
        return __TS__New(DireZombie, origin)
    end,
    [____exports.NPCNames.QUEEN] = function(____, origin)
        return __TS__New(Queen, origin)
    end,
    [____exports.NPCNames.CENTAUR] = function(____, origin)
        return __TS__New(Centaur, origin)
    end
}
____exports.default = (function()
    ____exports.default = __TS__Class()
    local Wave = ____exports.default
    Wave.name = "Wave"
    __TS__ClassExtends(Wave, GameState)
    function Wave.prototype.____constructor(self, alliances, duration, wavesInfo)
        GameState.prototype.____constructor(self, alliances, duration)
        self.helper = 3 * 30
        self.npcs = {}
        self.aliveNpcs = 0
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
                                local npc = NPCFactories[waveGroup.name](
                                    NPCFactories,
                                    Vector(x, y, 128)
                                )
                                __TS__ArrayPush(self.npcs, npc)
                                self.aliveNpcs = self.aliveNpcs + 1
                                i = i + 1
                            end
                        end
                    end
                )
            end
        )
    end
    function Wave.prototype.OnUnitDies(self, unit)
        local previousNpcs = #self.npcs
        self.npcs = __TS__ArrayFilter(
            self.npcs,
            function(____, npc) return npc.unit ~= unit end
        )
        if previousNpcs > #self.npcs then
            self.aliveNpcs = self.aliveNpcs - 1
        end
    end
    function Wave.prototype.Update(self)
        GameState.prototype.Update(self)
        __TS__ArrayForEach(
            self.npcs,
            function(____, npc)
                npc:Update()
            end
        )
        if self.aliveNpcs <= 0 then
            self:EndWave()
        end
    end
    function Wave.prototype.EndWave(self)
        GameRules.Addon:SetState(CustomGameState.PRE_WAVE)
    end
    return Wave
end)()
return ____exports
