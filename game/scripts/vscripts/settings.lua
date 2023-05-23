local ____lualib = require("lualib_bundle")
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["6"] = 1,["7"] = 1,["8"] = 1,["9"] = 1,["10"] = 1,["11"] = 1,["12"] = 1,["13"] = 1,["14"] = 1,["15"] = 1,["16"] = 1,["17"] = 1,["18"] = 1,["19"] = 1,["20"] = 16,["21"] = 17,["22"] = 17,["23"] = 17,["24"] = 17,["25"] = 17,["26"] = 17,["27"] = 17,["28"] = 17,["29"] = 17,["30"] = 17,["32"] = 30});
local ____exports = {}
local settings = {
    FirstWarmupDuration = 40,
    WarmupDuration = 20,
    PreRoundDuration = 4,
    RoundDuration = 60,
    PickupsCreationTime = 20,
    AbilityPoints = 2,
    GemSpawnTime = 10,
    GemRespawnTime = 15,
    RoundsToWin = 5,
    RoundsDifferenceToWin = 3,
    PreStageDuration = 2,
    DrawTime = 3
}
if IsInToolsMode() then
    settings = __TS__ObjectAssign({}, settings, {
        FirstWarmupDuration = 10,
        WarmupDuration = 1,
        PreRoundDuration = 1,
        RoundDuration = -1,
        PickupsCreationTime = 2,
        GemSpawnTime = 5,
        GemRespawnTime = 5,
        PreStageDuration = 2
    })
end
____exports.default = settings
return ____exports
