--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 114,["6"] = 114,["7"] = 115,["8"] = 116,["10"] = 114,["11"] = 124,["12"] = 125,["13"] = 126,["14"] = 127,["15"] = 128,["16"] = 129,["17"] = 129,["18"] = 129,["19"] = 129,["21"] = 132,["23"] = 124,["24"] = 136,["25"] = 137,["26"] = 138,["27"] = 139,["28"] = 140,["29"] = 141,["32"] = 145,["34"] = 136,["35"] = 8,["36"] = 8,["37"] = 8,["39"] = 8,["40"] = 11,["41"] = 11,["42"] = 11,["44"] = 11,["45"] = 14,["46"] = 14,["47"] = 14,["49"] = 14,["50"] = 15,["51"] = 22,["52"] = 15,["53"] = 27,["54"] = 27,["55"] = 27,["56"] = 27,["57"] = 30,["58"] = 30,["59"] = 30,["60"] = 30,["61"] = 33,["62"] = 33,["63"] = 33,["64"] = 33,["65"] = 36,["66"] = 37,["67"] = 38,["68"] = 40,["69"] = 41,["70"] = 43,["72"] = 45,["74"] = 48,["75"] = 48,["76"] = 48,["77"] = 50,["78"] = 51,["80"] = 53,["82"] = 56,["83"] = 58,["84"] = 59,["85"] = 60,["86"] = 61,["87"] = 62,["89"] = 59,["90"] = 40,["91"] = 67,["92"] = 68,["93"] = 70,["95"] = 72,["97"] = 75,["98"] = 75,["99"] = 75,["100"] = 76,["101"] = 76,["102"] = 76,["103"] = 78,["104"] = 79,["106"] = 81,["108"] = 84,["109"] = 86,["110"] = 86,["111"] = 87,["112"] = 88,["113"] = 89,["114"] = 90,["116"] = 87,["117"] = 94,["118"] = 95,["119"] = 96,["120"] = 97,["121"] = 98,["123"] = 100,["124"] = 101,["126"] = 103,["127"] = 104,["130"] = 108,["132"] = 111});
local ____exports = {}
local clearTable, getFileScope, toDotaClassInstance
function clearTable(self, ____table)
    for key in pairs(____table) do
        ____table[key] = nil
    end
end
function getFileScope(self)
    local level = 1
    while true do
        local info = debug.getinfo(level, "S")
        if info and (info.what == "main") then
            return {
                getfenv(level),
                info.source
            }
        end
        level = level + 1
    end
end
function toDotaClassInstance(self, instance, ____table)
    local prototype = ____table.prototype
    while prototype do
        for key in pairs(prototype) do
            if not (rawget(instance, key) ~= nil) then
                instance[key] = prototype[key]
            end
        end
        prototype = getmetatable(prototype)
    end
end
____exports.BaseAbility = __TS__Class()
local BaseAbility = ____exports.BaseAbility
BaseAbility.name = "BaseAbility"
function BaseAbility.prototype.____constructor(self)
end
____exports.BaseItem = __TS__Class()
local BaseItem = ____exports.BaseItem
BaseItem.name = "BaseItem"
function BaseItem.prototype.____constructor(self)
end
____exports.BaseModifier = __TS__Class()
local BaseModifier = ____exports.BaseModifier
BaseModifier.name = "BaseModifier"
function BaseModifier.prototype.____constructor(self)
end
function BaseModifier.apply(self, target, caster, ability, modifierTable)
    return target:AddNewModifier(caster, ability, self.name, modifierTable)
end
____exports.BaseModifierMotionHorizontal = __TS__Class()
local BaseModifierMotionHorizontal = ____exports.BaseModifierMotionHorizontal
BaseModifierMotionHorizontal.name = "BaseModifierMotionHorizontal"
__TS__ClassExtends(BaseModifierMotionHorizontal, ____exports.BaseModifier)
____exports.BaseModifierMotionVertical = __TS__Class()
local BaseModifierMotionVertical = ____exports.BaseModifierMotionVertical
BaseModifierMotionVertical.name = "BaseModifierMotionVertical"
__TS__ClassExtends(BaseModifierMotionVertical, ____exports.BaseModifier)
____exports.BaseModifierMotionBoth = __TS__Class()
local BaseModifierMotionBoth = ____exports.BaseModifierMotionBoth
BaseModifierMotionBoth.name = "BaseModifierMotionBoth"
__TS__ClassExtends(BaseModifierMotionBoth, ____exports.BaseModifier)
setmetatable(____exports.BaseAbility.prototype, {__index = CDOTA_Ability_Lua or C_DOTA_Ability_Lua})
setmetatable(____exports.BaseItem.prototype, {__index = CDOTA_Item_Lua or C_DOTA_Item_Lua})
setmetatable(____exports.BaseModifier.prototype, {__index = CDOTA_Modifier_Lua or C_DOTA_Modifier_Lua})
____exports.registerAbility = function(____, name) return function(____, ability)
    if name ~= nil then
        ability.name = name
    else
        name = ability.name
    end
    local env = unpack(
        getFileScope(nil)
    )
    if env[name] then
        clearTable(nil, env[name])
    else
        env[name] = {}
    end
    toDotaClassInstance(nil, env[name], ability)
    local originalSpawn = env[name].Spawn
    env[name].Spawn = function(self)
        self:____constructor()
        if originalSpawn then
            originalSpawn(self)
        end
    end
end end
____exports.registerModifier = function(____, name) return function(____, modifier)
    if name ~= nil then
        modifier.name = name
    else
        name = modifier.name
    end
    local env, source = unpack(
        getFileScope(nil)
    )
    local fileName = unpack(
        string.gsub(source, ".*scripts[\\/]vscripts[\\/]", "")
    )
    if env[name] then
        clearTable(nil, env[name])
    else
        env[name] = {}
    end
    toDotaClassInstance(nil, env[name], modifier)
    local originalOnCreated
    originalOnCreated = env[name].OnCreated
    env[name].OnCreated = function(self, parameters)
        self:____constructor()
        if originalOnCreated then
            originalOnCreated(self, parameters)
        end
    end
    local ____type = LUA_MODIFIER_MOTION_NONE
    local base = modifier.____super
    while base do
        if base == ____exports.BaseModifierMotionBoth then
            ____type = LUA_MODIFIER_MOTION_BOTH
            break
        elseif base == ____exports.BaseModifierMotionHorizontal then
            ____type = LUA_MODIFIER_MOTION_HORIZONTAL
            break
        elseif base == ____exports.BaseModifierMotionVertical then
            ____type = LUA_MODIFIER_MOTION_VERTICAL
            break
        end
        base = base.____super
    end
    LinkLuaModifier(name, fileName, ____type)
end end
return ____exports
