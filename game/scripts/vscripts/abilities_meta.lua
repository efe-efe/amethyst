--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["4"] = 10,["5"] = 11,["6"] = 13,["7"] = 13,["8"] = 13,["9"] = 13,["10"] = 13,["11"] = 14,["12"] = 15,["14"] = 15,["18"] = 14,["19"] = 16,["21"] = 16,["25"] = 14,["26"] = 14,["28"] = 20});
abilitiesKv = LoadKeyValues("scripts/npc/npc_abilities_custom.txt")
meta = {}
for ____, ____value in ipairs(
    __TS__ObjectEntries(abilitiesKv)
) do
    key = ____value[1]
    ability = ____value[2]
    meta[key] = {
        targetingIndicator = (function(____lhs)
            if ____lhs == nil then
                return {}
            else
                return ____lhs
            end
        end)(ability.TargetingIndicator),
        energyCost = (function(____lhs)
            if ____lhs == nil then
                return 0
            else
                return ____lhs
            end
        end)(ability.AbilityEnergyCost)
    }
end
CustomNetTables:SetTableValue("main", "abilities", meta)
