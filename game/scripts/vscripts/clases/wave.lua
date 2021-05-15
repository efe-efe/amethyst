--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 2,["8"] = 2,["9"] = 2,["10"] = 3,["11"] = 3,["12"] = 3,["13"] = 10,["14"] = 11,["15"] = 12,["16"] = 13,["17"] = 14,["18"] = 17,["19"] = 18,["20"] = 19,["21"] = 17,["22"] = 21,["23"] = 22,["24"] = 17,["25"] = 24,["26"] = 25,["27"] = 17,["28"] = 27,["29"] = 28,["30"] = 17,["31"] = 17,["32"] = 32,["33"] = 32,["34"] = 32,["35"] = 32,["36"] = 32,["37"] = 38,["38"] = 32,["39"] = 33,["40"] = 34,["41"] = 36,["42"] = 40,["43"] = 42,["44"] = 42,["45"] = 42,["46"] = 43,["47"] = 43,["48"] = 43,["50"] = 44,["51"] = 44,["52"] = 45,["53"] = 46,["54"] = 47,["55"] = 47,["56"] = 47,["58"] = 48,["59"] = 49,["60"] = 44,["63"] = 43,["64"] = 43,["65"] = 42,["66"] = 42,["67"] = 38,["68"] = 55,["69"] = 56,["70"] = 57,["71"] = 57,["72"] = 57,["73"] = 57,["74"] = 58,["75"] = 59,["77"] = 55,["78"] = 63,["79"] = 32,["80"] = 66,["81"] = 66,["82"] = 66,["83"] = 67,["84"] = 66,["85"] = 66,["86"] = 70,["87"] = 71,["89"] = 63,["90"] = 75,["91"] = 76,["92"] = 75,["93"] = 32,["94"] = 32});
local ____exports = {}
local ____custom_ai = require("clases.custom_ai")
local Centaur = ____custom_ai.Centaur
local DireZombie = ____custom_ai.DireZombie
local Queen = ____custom_ai.Queen
local DireZombieRager = ____custom_ai.DireZombieRager
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local CustomGameState = ____game_state.CustomGameState
____exports.NPCNames = NPCNames or ({})
____exports.NPCNames.DIRE_ZOMBIE = "DireZombie"
____exports.NPCNames.DIRE_ZOMBIE_RAGER = "DireZombieRager"
____exports.NPCNames.QUEEN = "Queen"
____exports.NPCNames.CENTAUR = "Centaur"
local NPCFactories = {
    [____exports.NPCNames.DIRE_ZOMBIE] = function(____, origin)
        return __TS__New(DireZombie, origin)
    end,
    [____exports.NPCNames.DIRE_ZOMBIE_RAGER] = function(____, origin)
        return __TS__New(DireZombieRager, origin)
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
