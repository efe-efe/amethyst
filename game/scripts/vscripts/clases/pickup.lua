--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["5"] = 1,["6"] = 1,["7"] = 3,["8"] = 4,["9"] = 4,["10"] = 5,["11"] = 5,["12"] = 6,["13"] = 6,["14"] = 7,["15"] = 7,["16"] = 10,["17"] = 17,["20"] = 24,["22"] = 24,["23"] = 30,["24"] = 30,["25"] = 30,["27"] = 24,["28"] = 32,["29"] = 33,["30"] = 34,["31"] = 36,["32"] = 36,["33"] = 36,["34"] = 37,["35"] = 38,["36"] = 39,["37"] = 40,["39"] = 43,["40"] = 44,["41"] = 45,["42"] = 45,["43"] = 45,["45"] = 48,["46"] = 49,["48"] = 43,["49"] = 24});
local ____exports = {}
local ____Item = require("clases.Item")
local Item = ____Item.default
____exports.PickupTypes = {}
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
____exports.default = (function()
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
        self:SetItem(
            CreateItem(PICKUP_ITEM_NAMES[self.type], nil, nil)
        )
        self.item:LaunchLootInitialHeight(false, 0, 50, 0.5, self.origin)
        self.drop = CreateItemOnPositionForLaunch(self.origin, self.item)
        ParticleManager:CreateParticle(PICKUP_PARTICLES[self.type], PATTACH_ABSORIGIN_FOLLOW, self.drop)
        self.drop:SetModelScale(self.scale)
    end
    function Pickup.prototype.Destroy(self)
        if not self.picked then
            UTIL_Remove(
                self:GetItem()
            )
        end
        if (self.drop ~= nil) and (not self.drop:IsNull()) then
            UTIL_Remove(self.drop)
        end
    end
    return Pickup
end)()
return ____exports
