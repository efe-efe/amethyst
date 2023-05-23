local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["7"] = 158,["8"] = 133,["9"] = 134,["10"] = 135,["12"] = 133,["13"] = 139,["14"] = 140,["15"] = 141,["16"] = 142,["17"] = 143,["18"] = 144,["19"] = 144,["20"] = 144,["21"] = 144,["23"] = 147,["25"] = 139,["26"] = 158,["27"] = 159,["28"] = 159,["29"] = 160,["30"] = 161,["31"] = 164,["32"] = 165,["35"] = 169,["38"] = 10,["39"] = 10,["40"] = 10,["42"] = 10,["43"] = 13,["44"] = 13,["45"] = 13,["47"] = 13,["48"] = 16,["49"] = 16,["50"] = 16,["52"] = 16,["53"] = 17,["54"] = 24,["55"] = 17,["56"] = 35,["57"] = 35,["58"] = 35,["59"] = 35,["60"] = 39,["61"] = 39,["62"] = 39,["63"] = 39,["64"] = 43,["65"] = 43,["66"] = 43,["67"] = 43,["68"] = 46,["69"] = 49,["70"] = 52,["71"] = 56,["72"] = 59,["73"] = 61,["75"] = 63,["77"] = 66,["78"] = 68,["79"] = 69,["81"] = 71,["83"] = 74,["84"] = 76,["85"] = 77,["86"] = 78,["87"] = 79,["88"] = 80,["90"] = 77,["91"] = 57,["92"] = 85,["93"] = 87,["94"] = 89,["96"] = 91,["98"] = 94,["99"] = 95,["100"] = 97,["101"] = 98,["103"] = 100,["105"] = 103,["106"] = 105,["107"] = 106,["108"] = 107,["109"] = 108,["110"] = 109,["112"] = 106,["113"] = 113,["114"] = 114,["115"] = 115,["116"] = 116,["117"] = 117,["119"] = 119,["120"] = 120,["122"] = 122,["123"] = 123,["126"] = 127,["128"] = 130,["129"] = 86,["130"] = 151,["131"] = 152,["132"] = 153,["133"] = 154,["134"] = 153,["135"] = 151});
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
        if info and info.what == "main" then
            return {
                getfenv(level),
                info.source
            }
        end
        level = level + 1
    end
end
function toDotaClassInstance(self, instance, ____table)
    local ____table_0 = ____table
    local prototype = ____table_0.prototype
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
    local env = unpack(____exports.getFileScope(nil))
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
    local env, source = unpack(____exports.getFileScope(nil))
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
    local env = unpack(____exports.getFileScope(nil))
    env[name] = function(...)
        f(nil, ...)
    end
end
return ____exports
