--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 147,["6"] = 122,["7"] = 123,["8"] = 124,["10"] = 122,["11"] = 128,["12"] = 129,["13"] = 130,["14"] = 131,["15"] = 132,["16"] = 133,["17"] = 133,["18"] = 133,["19"] = 133,["21"] = 136,["23"] = 128,["24"] = 147,["25"] = 148,["26"] = 149,["27"] = 150,["28"] = 153,["29"] = 154,["32"] = 158,["34"] = 147,["35"] = 10,["36"] = 10,["37"] = 10,["39"] = 10,["40"] = 13,["41"] = 13,["42"] = 13,["44"] = 13,["45"] = 16,["46"] = 16,["47"] = 16,["49"] = 16,["50"] = 17,["51"] = 24,["52"] = 17,["53"] = 29,["54"] = 29,["55"] = 29,["56"] = 29,["57"] = 32,["58"] = 32,["59"] = 32,["60"] = 32,["61"] = 35,["62"] = 35,["63"] = 35,["64"] = 35,["65"] = 38,["66"] = 41,["67"] = 44,["68"] = 48,["69"] = 49,["70"] = 51,["72"] = 53,["74"] = 56,["75"] = 56,["76"] = 56,["77"] = 58,["78"] = 59,["80"] = 61,["82"] = 64,["83"] = 66,["84"] = 67,["85"] = 68,["86"] = 69,["87"] = 70,["89"] = 67,["90"] = 48,["91"] = 75,["92"] = 76,["93"] = 78,["95"] = 80,["97"] = 83,["98"] = 83,["99"] = 83,["100"] = 84,["101"] = 86,["102"] = 87,["104"] = 89,["106"] = 92,["107"] = 94,["108"] = 95,["109"] = 96,["110"] = 97,["111"] = 98,["113"] = 95,["114"] = 102,["115"] = 103,["116"] = 104,["117"] = 105,["118"] = 106,["120"] = 108,["121"] = 109,["123"] = 111,["124"] = 112,["127"] = 116,["129"] = 119,["130"] = 75,["131"] = 140,["132"] = 141,["133"] = 141,["134"] = 141,["135"] = 142,["136"] = 143,["137"] = 142,["138"] = 140});
local ____exports = {}
local toDotaClassInstance
function ____exports.clearTable(self, ____table)
    for key in pairs(____table) do
        ____table[key] = nil
    end
end
function ____exports.getFileScope(self)
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
        ____exports.getFileScope(nil)
    )
    if env[name] then
        ____exports.clearTable(nil, env[name])
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
        ____exports.getFileScope(nil)
    )
    local fileName = string.gsub(source, ".*scripts[\\/]vscripts[\\/]", "")
    if env[name] then
        ____exports.clearTable(nil, env[name])
    else
        env[name] = {}
    end
    toDotaClassInstance(nil, env[name], modifier)
    local originalOnCreated = env[name].OnCreated
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
function ____exports.entityFunction(self, name, f)
    local env = unpack(
        ____exports.getFileScope(nil)
    )
    env[name] = function(...)
        f(nil, ...)
    end
end
return ____exports
