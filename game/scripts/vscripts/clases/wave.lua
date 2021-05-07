--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 2,["6"] = 2,["7"] = 2,["8"] = 2,["9"] = 3,["10"] = 3,["11"] = 3,["12"] = 10,["13"] = 11,["14"] = 12,["15"] = 13,["16"] = 16,["17"] = 17,["18"] = 18,["19"] = 16,["20"] = 20,["21"] = 21,["22"] = 16,["23"] = 23,["24"] = 24,["25"] = 16,["26"] = 16,["27"] = 28,["28"] = 28,["29"] = 28,["30"] = 28,["31"] = 28,["32"] = 34,["33"] = 28,["34"] = 29,["35"] = 30,["36"] = 32,["37"] = 36,["38"] = 38,["39"] = 38,["40"] = 38,["42"] = 39,["43"] = 39,["44"] = 40,["45"] = 41,["46"] = 42,["47"] = 42,["48"] = 42,["50"] = 43,["51"] = 44,["52"] = 39,["55"] = 38,["56"] = 38,["57"] = 34,["58"] = 49,["59"] = 28,["60"] = 52,["61"] = 53,["62"] = 53,["63"] = 53,["64"] = 54,["65"] = 55,["67"] = 53,["68"] = 53,["70"] = 59,["72"] = 62,["73"] = 63,["75"] = 49,["76"] = 67,["77"] = 68,["78"] = 67,["79"] = 28,["80"] = 28});
local ____exports = {}
local ____custom_npc = require("clases.custom_npc")
local Centaur = ____custom_npc.Centaur
local DireZombie = ____custom_npc.DireZombie
local Queen = ____custom_npc.Queen
local ____game_state = require("clases.game_state")
local GameState = ____game_state.default
local CustomGameState = ____game_state.CustomGameState
____exports.NPCNames = {}
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
    function Wave.prototype.____constructor(self, alliances, duration, waveGroups)
        GameState.prototype.____constructor(self, alliances, duration)
        self.helper = 3 * 30
        self.npcs = {}
        self.aliveNpcs = 0
        self.waveGroups = waveGroups
        __TS__ArrayForEach(
            waveGroups,
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
    function Wave.prototype.Update(self)
        GameState.prototype.Update(self)
        if self.helper == 0 then
            __TS__ArrayForEach(
                self.npcs,
                function(____, npc)
                    if (npc:GetUnit() and (not npc:GetUnit():IsNull())) and npc:GetUnit():IsAlive() then
                        npc:Update()
                    end
                end
            )
        else
            self.helper = self.helper - 1
        end
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
