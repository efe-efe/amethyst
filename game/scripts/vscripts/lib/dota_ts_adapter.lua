--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 158,["6"] = 133,["7"] = 134,["8"] = 135,["10"] = 133,["11"] = 139,["12"] = 140,["13"] = 141,["14"] = 142,["15"] = 143,["16"] = 144,["17"] = 144,["18"] = 144,["19"] = 144,["21"] = 147,["23"] = 139,["24"] = 158,["25"] = 159,["26"] = 160,["27"] = 161,["28"] = 164,["29"] = 165,["32"] = 169,["34"] = 158,["35"] = 10,["36"] = 10,["37"] = 10,["39"] = 10,["40"] = 13,["41"] = 13,["42"] = 13,["44"] = 13,["45"] = 16,["46"] = 16,["47"] = 16,["49"] = 16,["50"] = 17,["51"] = 24,["52"] = 17,["53"] = 35,["54"] = 35,["55"] = 35,["56"] = 35,["57"] = 39,["58"] = 39,["59"] = 39,["60"] = 39,["61"] = 43,["62"] = 43,["63"] = 43,["64"] = 43,["65"] = 46,["66"] = 49,["67"] = 52,["68"] = 56,["69"] = 59,["70"] = 61,["72"] = 63,["74"] = 66,["75"] = 66,["76"] = 66,["77"] = 68,["78"] = 69,["80"] = 71,["82"] = 74,["83"] = 76,["84"] = 77,["85"] = 78,["86"] = 79,["87"] = 80,["89"] = 77,["90"] = 57,["91"] = 85,["92"] = 87,["93"] = 89,["95"] = 91,["97"] = 94,["98"] = 94,["99"] = 94,["100"] = 95,["101"] = 97,["102"] = 98,["104"] = 100,["106"] = 103,["107"] = 105,["108"] = 106,["109"] = 107,["110"] = 108,["111"] = 109,["113"] = 106,["114"] = 113,["115"] = 114,["116"] = 115,["117"] = 116,["118"] = 117,["120"] = 119,["121"] = 120,["123"] = 122,["124"] = 123,["127"] = 127,["129"] = 130,["130"] = 86,["131"] = 151,["132"] = 152,["133"] = 152,["134"] = 152,["135"] = 153,["136"] = 154,["137"] = 153,["138"] = 151});
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
