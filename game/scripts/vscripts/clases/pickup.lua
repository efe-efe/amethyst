local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["7"] = 1,["8"] = 1,["9"] = 3,["10"] = 4,["11"] = 4,["12"] = 5,["13"] = 5,["14"] = 6,["15"] = 6,["16"] = 7,["17"] = 7,["18"] = 10,["19"] = 17,["20"] = 24,["21"] = 24,["22"] = 24,["23"] = 24,["24"] = 30,["25"] = 30,["26"] = 30,["28"] = 24,["29"] = 32,["30"] = 33,["31"] = 34,["32"] = 36,["33"] = 39,["34"] = 39,["35"] = 39,["36"] = 39,["37"] = 39,["38"] = 39,["39"] = 39,["40"] = 40,["41"] = 41,["42"] = 46,["43"] = 30,["44"] = 49,["45"] = 50,["46"] = 51,["48"] = 54,["49"] = 55,["51"] = 49});
local ____exports = {}
local ____Item = require("clases.Item")
local Item = ____Item.default
____exports.PickupTypes = PickupTypes or ({})
____exports.PickupTypes.HEALTH = 0
____exports.PickupTypes[____exports.PickupTypes.HEALTH] = "HEALTH"
____exports.PickupTypes.MANA = 1
____exports.PickupTypes[____exports.PickupTypes.MANA] = "MANA"
____exports.PickupTypes.SHIELD = 2
____exports.PickupTypes[____exports.PickupTypes.SHIELD] = "SHIELD"
____exports.PickupTypes.DEATH = 3
____exports.PickupTypes[____exports.PickupTypes.DEATH] = "DEATH"
local PICKUP_ITEM_NAMES = {[____exports.PickupTypes.HEALTH] = "item_health_orb", [____exports.PickupTypes.MANA] = "item_mana_orb", [____exports.PickupTypes.SHIELD] = "item_shield_orb", [____exports.PickupTypes.DEATH] = "item_death_orb"}
local PICKUP_PARTICLES = {[____exports.PickupTypes.HEALTH] = "particles/generic_gameplay/rune_regeneration.vpcf", [____exports.PickupTypes.MANA] = "particles/generic_gameplay/rune_doubledamage.vpcf", [____exports.PickupTypes.SHIELD] = "particles/generic_gameplay/rune_bounty.vpcf", [____exports.PickupTypes.DEATH] = "particles/generic_gameplay/rune_haste.vpcf"}
____exports.default = __TS__Class()
local Pickup = ____exports.default
Pickup.name = "Pickup"
__TS__ClassExtends(Pickup, Item)
function Pickup.prototype.____constructor(self, ____type, origin, scale)
    if scale == nil then
        scale = 1
    end
    Item.prototype.____constructor(self)
    self.type = ____type
    self.origin = origin
    self.scale = scale
    self:SetItem(CreateItem(PICKUP_ITEM_NAMES[self.type], nil, nil))
    self.item:LaunchLootInitialHeight(
        false,
        0,
        50,
        0.5,
        self.origin
    )
    self.drop = CreateItemOnPositionForLaunch(self.origin, self.item)
    ParticleManager:CreateParticle(PICKUP_PARTICLES[self.type], PATTACH_ABSORIGIN_FOLLOW, self.drop)
    self.drop:SetModelScale(self.scale)
end
function Pickup.prototype.Destroy(self)
    if not self.picked then
        UTIL_Remove(self:GetItem())
    end
    if self.drop ~= nil and not self.drop:IsNull() then
        UTIL_Remove(self.drop)
    end
end
return ____exports
