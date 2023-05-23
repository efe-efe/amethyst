local ____lualib = require("lualib_bundle")
local __TS__ObjectEntries = ____lualib.__TS__ObjectEntries
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 10,["6"] = 11,["7"] = 13,["8"] = 13,["9"] = 13,["10"] = 14,["11"] = 15,["12"] = 15,["13"] = 15,["15"] = 16,["16"] = 16,["17"] = 16,["19"] = 14,["21"] = 20});
abilitiesKv = LoadKeyValues("scripts/npc/npc_abilities_custom.txt")
meta = {}
for ____, ____value in ipairs(__TS__ObjectEntries(abilitiesKv)) do
    local key = ____value[1]
    local ability = ____value[2]
    local ____key_2 = key
    local ____ability_TargetingIndicator_0 = ability.TargetingIndicator
    if ____ability_TargetingIndicator_0 == nil then
        ____ability_TargetingIndicator_0 = {}
    end
    local ____ability_AbilityEnergyCost_1 = ability.AbilityEnergyCost
    if ____ability_AbilityEnergyCost_1 == nil then
        ____ability_AbilityEnergyCost_1 = 0
    end
    meta[____key_2] = {targetingIndicator = ____ability_TargetingIndicator_0, energyCost = ____ability_AbilityEnergyCost_1}
end
CustomNetTables:SetTableValue("main", "abilities", meta)
