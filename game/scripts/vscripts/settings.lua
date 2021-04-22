--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 15,["7"] = 16,["9"] = 28});
local ____exports = {}
local settings = {FirstWarmupDuration = 40, WarmupDuration = 20, PreRoundDuration = 4, RoundDuration = 60, PickupsCreationTime = 20, AbilityPoints = 2, GemSpawnTime = 10, GemRespawnTime = 15, RoundsToWin = 5, RoundsDifferenceToWin = 3, DrawTime = 3}
if IsInToolsMode() then
    settings = __TS__ObjectAssign({}, settings, {FirstWarmupDuration = 1, WarmupDuration = 1, PreRoundDuration = 1, RoundDuration = -1, PickupsCreationTime = 2, GemSpawnTime = 5, GemRespawnTime = 5})
end
____exports.default = settings
return ____exports
