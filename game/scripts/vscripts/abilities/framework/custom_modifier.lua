local ____lualib = require("lualib_bundle")
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ObjectKeys = ____lualib.__TS__ObjectKeys
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["11"] = 1,["12"] = 1,["13"] = 1,["14"] = 1,["15"] = 1,["16"] = 9,["17"] = 11,["18"] = 9,["19"] = 14,["20"] = 16,["21"] = 14,["22"] = 19,["23"] = 21,["24"] = 19,["25"] = 24,["26"] = 33,["28"] = 34,["29"] = 35,["30"] = 36,["31"] = 37,["32"] = 38,["33"] = 39,["35"] = 40,["36"] = 40,["37"] = 40,["39"] = 40,["40"] = 33,["41"] = 44,["42"] = 46,["43"] = 24,["44"] = 49,["45"] = 49,["46"] = 49,["47"] = 49,["49"] = 49,["50"] = 50,["51"] = 51,["52"] = 52,["53"] = 54,["54"] = 49,["55"] = 61,["56"] = 69,["57"] = 61,["58"] = 74,["59"] = 75,["62"] = 79,["63"] = 80,["65"] = 74,["66"] = 84,["67"] = 85,["68"] = 86,["70"] = 89,["71"] = 90,["72"] = 91,["73"] = 92,["74"] = 93,["76"] = 95,["78"] = 84,["79"] = 56,["80"] = 57,["81"] = 58,["82"] = 59,["83"] = 100,["84"] = 100,["85"] = 100,["86"] = 100,["88"] = 100,["89"] = 101,["90"] = 102,["91"] = 103,["92"] = 105,["93"] = 100,["94"] = 111,["95"] = 119,["96"] = 111,["97"] = 123,["98"] = 124,["101"] = 128,["102"] = 129,["104"] = 123,["105"] = 133,["106"] = 134,["107"] = 135,["109"] = 138,["110"] = 139,["111"] = 140,["112"] = 141,["113"] = 142,["115"] = 144,["117"] = 133,["118"] = 107,["119"] = 108,["120"] = 109,["121"] = 149,["122"] = 149,["123"] = 149,["124"] = 149,["126"] = 149,["127"] = 150,["128"] = 151,["129"] = 152,["130"] = 149,["131"] = 158,["132"] = 166,["133"] = 158,["134"] = 154,["135"] = 155,["136"] = 156,["137"] = 170,["138"] = 170,["139"] = 170,["140"] = 170,["142"] = 170,["143"] = 171,["144"] = 172,["145"] = 173,["146"] = 179,["147"] = 170,["148"] = 181,["149"] = 189,["150"] = 181,["151"] = 194,["152"] = 195,["155"] = 199,["156"] = 200,["158"] = 194,["159"] = 204,["160"] = 205,["161"] = 206,["163"] = 209,["164"] = 210,["165"] = 211,["166"] = 212,["167"] = 213,["169"] = 215,["171"] = 204,["172"] = 175,["173"] = 176,["174"] = 177});
local ____exports = {}
local ____dota_ts_adapter = require("lib.dota_ts_adapter")
local BaseModifier = ____dota_ts_adapter.BaseModifier
local BaseModifierMotionHorizontal = ____dota_ts_adapter.BaseModifierMotionHorizontal
local BaseModifierMotionVertical = ____dota_ts_adapter.BaseModifierMotionVertical
local BaseModifierMotionBoth = ____dota_ts_adapter.BaseModifierMotionBoth
local function hasOne(self, target)
    return target:HasModifier(self.name)
end
local function findOne(self, target)
    return target:FindModifierByName(self.name)
end
local function findAll(self, target)
    return target:FindAllModifiersByName(self.name)
end
local function createThinker(self, caster, ability, at, modifierTable, phantomBlocker)
    local ____CreateModifierThinker_4 = CreateModifierThinker
    local ____array_3 = __TS__SparseArrayNew(
        caster,
        ability,
        self.name,
        modifierTable,
        at,
        caster and caster:GetTeam() or DOTA_TEAM_NOTEAM
    )
    local ____phantomBlocker_2 = phantomBlocker
    if ____phantomBlocker_2 == nil then
        ____phantomBlocker_2 = false
    end
    __TS__SparseArrayPush(____array_3, ____phantomBlocker_2)
    local thinker = ____CreateModifierThinker_4(__TS__SparseArraySpread(____array_3))
    local modifier = thinker:FindModifierByName(self.name)
    return {thinker, modifier}
end
____exports.CustomModifier = __TS__Class()
local CustomModifier = ____exports.CustomModifier
CustomModifier.name = "CustomModifier"
__TS__ClassExtends(CustomModifier, BaseModifier)
function CustomModifier.prototype.____constructor(self, ...)
    BaseModifier.prototype.____constructor(self, ...)
    self.caster = self:GetCaster()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.specialValueCache = {}
end
function CustomModifier.apply(self, target, caster, ability, modifierTable)
    return target:AddNewModifier(caster, ability, self.name, modifierTable)
end
function CustomModifier.prototype.OnRefresh(self, kv)
    if not IsValidEntity(self.ability) then
        return
    end
    for ____, key in ipairs(__TS__ObjectKeys(self.specialValueCache)) do
        self.specialValueCache[key] = self.ability:GetSpecialValueFor(key)
    end
end
function CustomModifier.prototype.Value(self, name)
    if not self.ability then
        error("Trying to call this.Value for a modifier applied without an ability", 0)
    end
    local cached = self.specialValueCache[name]
    if cached == nil then
        local value = self.ability:GetSpecialValueFor(name)
        self.specialValueCache[name] = value
        return value
    else
        return cached
    end
end
CustomModifier.findOne = findOne
CustomModifier.findAll = findAll
CustomModifier.hasOne = hasOne
CustomModifier.createThinker = createThinker
____exports.CustomModifierMotionHorizontal = __TS__Class()
local CustomModifierMotionHorizontal = ____exports.CustomModifierMotionHorizontal
CustomModifierMotionHorizontal.name = "CustomModifierMotionHorizontal"
__TS__ClassExtends(CustomModifierMotionHorizontal, BaseModifierMotionHorizontal)
function CustomModifierMotionHorizontal.prototype.____constructor(self, ...)
    BaseModifierMotionHorizontal.prototype.____constructor(self, ...)
    self.caster = self:GetCaster()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.specialValueCache = {}
end
function CustomModifierMotionHorizontal.apply(self, target, caster, ability, modifierTable)
    return target:AddNewModifier(caster, ability, self.name, modifierTable)
end
function CustomModifierMotionHorizontal.prototype.OnRefresh(self, kv)
    if not IsValidEntity(self.ability) then
        return
    end
    for ____, key in ipairs(__TS__ObjectKeys(self.specialValueCache)) do
        self.specialValueCache[key] = self.ability:GetSpecialValueFor(key)
    end
end
function CustomModifierMotionHorizontal.prototype.Value(self, name)
    if not self.ability then
        error("Trying to call this.Value for a modifier applied without an ability", 0)
    end
    local cached = self.specialValueCache[name]
    if cached == nil then
        local value = self.ability:GetSpecialValueFor(name)
        self.specialValueCache[name] = value
        return value
    else
        return cached
    end
end
CustomModifierMotionHorizontal.findOne = findOne
CustomModifierMotionHorizontal.findAll = findAll
CustomModifierMotionHorizontal.createThinker = createThinker
____exports.CustomModifierMotionVertical = __TS__Class()
local CustomModifierMotionVertical = ____exports.CustomModifierMotionVertical
CustomModifierMotionVertical.name = "CustomModifierMotionVertical"
__TS__ClassExtends(CustomModifierMotionVertical, BaseModifierMotionVertical)
function CustomModifierMotionVertical.prototype.____constructor(self, ...)
    BaseModifierMotionVertical.prototype.____constructor(self, ...)
    self.caster = self:GetCaster()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
end
function CustomModifierMotionVertical.apply(self, target, caster, ability, modifierTable)
    return target:AddNewModifier(caster, ability, self.name, modifierTable)
end
CustomModifierMotionVertical.findOne = findOne
CustomModifierMotionVertical.findAll = findAll
CustomModifierMotionVertical.createThinker = createThinker
____exports.CustomModifierMotionBoth = __TS__Class()
local CustomModifierMotionBoth = ____exports.CustomModifierMotionBoth
CustomModifierMotionBoth.name = "CustomModifierMotionBoth"
__TS__ClassExtends(CustomModifierMotionBoth, BaseModifierMotionBoth)
function CustomModifierMotionBoth.prototype.____constructor(self, ...)
    BaseModifierMotionBoth.prototype.____constructor(self, ...)
    self.caster = self:GetCaster()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.specialValueCache = {}
end
function CustomModifierMotionBoth.apply(self, target, caster, ability, modifierTable)
    return target:AddNewModifier(caster, ability, self.name, modifierTable)
end
function CustomModifierMotionBoth.prototype.OnRefresh(self, kv)
    if not IsValidEntity(self.ability) then
        return
    end
    for ____, key in ipairs(__TS__ObjectKeys(self.specialValueCache)) do
        self.specialValueCache[key] = self.ability:GetSpecialValueFor(key)
    end
end
function CustomModifierMotionBoth.prototype.Value(self, name)
    if not self.ability then
        error("Trying to call this.Value for a modifier applied without an ability", 0)
    end
    local cached = self.specialValueCache[name]
    if cached == nil then
        local value = self.ability:GetSpecialValueFor(name)
        self.specialValueCache[name] = value
        return value
    else
        return cached
    end
end
CustomModifierMotionBoth.findOne = findOne
CustomModifierMotionBoth.findAll = findAll
CustomModifierMotionBoth.createThinker = createThinker
return ____exports
