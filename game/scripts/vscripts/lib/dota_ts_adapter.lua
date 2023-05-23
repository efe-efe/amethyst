local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Delete = ____lualib.__TS__Delete
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["8"] = 150,["9"] = 150,["10"] = 151,["11"] = 152,["14"] = 156,["15"] = 157,["16"] = 158,["17"] = 159,["18"] = 160,["19"] = 161,["20"] = 161,["21"] = 161,["22"] = 161,["24"] = 164,["27"] = 168,["28"] = 169,["29"] = 169,["30"] = 170,["31"] = 171,["32"] = 174,["33"] = 175,["36"] = 179,["39"] = 2,["40"] = 2,["41"] = 2,["43"] = 2,["44"] = 5,["45"] = 5,["46"] = 5,["48"] = 5,["49"] = 8,["50"] = 8,["51"] = 8,["53"] = 8,["54"] = 9,["55"] = 16,["56"] = 9,["57"] = 20,["58"] = 20,["59"] = 33,["60"] = 33,["61"] = 33,["62"] = 33,["63"] = 36,["64"] = 36,["65"] = 36,["66"] = 36,["67"] = 39,["68"] = 39,["69"] = 39,["70"] = 39,["71"] = 42,["72"] = 45,["73"] = 48,["74"] = 55,["75"] = 56,["76"] = 58,["78"] = 60,["80"] = 63,["81"] = 65,["82"] = 66,["84"] = 68,["86"] = 71,["87"] = 73,["88"] = 74,["89"] = 75,["90"] = 76,["91"] = 77,["93"] = 79,["94"] = 80,["95"] = 81,["97"] = 74,["98"] = 55,["99"] = 86,["100"] = 87,["101"] = 89,["102"] = 91,["104"] = 93,["106"] = 96,["107"] = 97,["108"] = 99,["109"] = 100,["111"] = 102,["113"] = 105,["114"] = 107,["115"] = 108,["116"] = 109,["117"] = 110,["118"] = 111,["120"] = 113,["121"] = 114,["122"] = 115,["124"] = 108,["125"] = 119,["126"] = 120,["127"] = 121,["128"] = 122,["129"] = 123,["131"] = 125,["132"] = 126,["134"] = 128,["135"] = 129,["138"] = 133,["140"] = 136,["141"] = 86,["144"] = 143,["145"] = 144,["146"] = 145,["147"] = 146,["148"] = 145,["149"] = 143});
local ____exports = {}
local clearTable, getFileScope, toDotaClassInstance
function clearTable(self, ____table)
    for key in pairs(____table) do
        __TS__Delete(____table, key)
    end
end
function getFileScope(self)
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
    local ____table_2 = ____table
    local prototype = ____table_2.prototype
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
    return target:AddNewModifier(caster or target, ability, self.name, modifierTable or ({}))
end
function BaseModifier.prototype.OnHealDone(self, event)
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
setmetatable(____exports.BaseModifier.prototype, {__index = CDOTA_Modifier_Lua})
____exports.registerAbility = function(____, name) return function(____, ability)
    if name ~= nil then
        ability.name = name
    else
        name = ability.name
    end
    local env = unpack(getFileScope(nil))
    if env[name] then
        clearTable(nil, env[name])
    else
        env[name] = {}
    end
    toDotaClassInstance(nil, env[name], ability)
    local originalSpawn = env[name].Spawn
    env[name].Spawn = function(self)
        if beforeAbilitySpawn then
            beforeAbilitySpawn(nil, self)
            beforeAbilitySpawn = nil
        end
        self:____constructor()
        if originalSpawn then
            originalSpawn(self)
        end
    end
end end
____exports.registerModifier = function(____, params) return function(____, modifier)
    local name = params and params.customNameForI18n
    if name ~= nil then
        modifier.name = name
    else
        name = modifier.name
    end
    local env, source = unpack(getFileScope(nil))
    local fileName = string.gsub(source, ".*scripts[\\/]vscripts[\\/]", "")
    if env[name] then
        clearTable(nil, env[name])
    else
        env[name] = {}
    end
    toDotaClassInstance(nil, env[name], modifier)
    local originalOnCreated = env[name].OnCreated
    env[name].OnCreated = function(self, parameters)
        if beforeModifierOnCreated then
            beforeModifierOnCreated(nil, self)
            beforeModifierOnCreated = nil
        end
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
--- Use to expose top-level functions in entity scripts.
-- Usage: registerEntityFunction("OnStartTouch", (trigger: TriggerStartTouchEvent) => { <your code here> });
function ____exports.registerEntityFunction(self, name, f)
    local env = unpack(getFileScope(nil))
    env[name] = function(...)
        f(nil, ...)
    end
end
return ____exports
