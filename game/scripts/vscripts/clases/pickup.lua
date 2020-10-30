Pickup = Pickup or class({})

PickupTypes = {
    HEALTH = 0,
    MANA = 1,
    SHIELD = 2,
    DEATH = 3,
}

local PICKUP_ITEM_NAMES = {
    [PickupTypes.HEALTH] = "item_health_orb",
    [PickupTypes.MANA] = "item_mana_orb",
    [PickupTypes.SHIELD] = "item_shield_orb",
    [PickupTypes.DEATH] = "item_death_orb"
}

local PICKUP_PARTICLES = {
    [PickupTypes.HEALTH] = "particles/generic_gameplay/rune_regeneration.vpcf",
    [PickupTypes.MANA] = "particles/generic_gameplay/rune_doubledamage.vpcf",
    [PickupTypes.SHIELD] = "particles/generic_gameplay/rune_bounty.vpcf",
    [PickupTypes.DEATH] = "particles/generic_gameplay/rune_haste.vpcf"
}

local PICKUP_MODELS = {
    [PickupTypes.HEALTH] = "models/props_gameplay/salve.vmdl",
    [PickupTypes.MANA] = "models/props_gameplay/clarity.vmdl",
    [PickupTypes.SHIELD] = "models/props_gameplay/stout_shield.vmdl",
    [PickupTypes.DEATH] = "models/props_items/bloodstone.vmdl"
}

function Pickup:constructor(type, origin, scale)
    self.type = type
    self.origin = origin
    self.scale = scale
    self.item = nil
    self.drop = nil
    self.picked = false

    self:SetItem(CreateItem(PICKUP_ITEM_NAMES[self.type], nil, nil))

    local item = self:GetItem()
    item:LaunchLootInitialHeight(false, 0, 50, 0.5, self.origin)
    self.drop = CreateItemOnPositionForLaunch(self.origin, item)
    ParticleManager:CreateParticle(PICKUP_PARTICLES[self.type], PATTACH_ABSORIGIN_FOLLOW, self.drop)
    
    if self.scale ~= nil then
        self.drop:SetModelScale(self.scale)	
    end
end

function Pickup:Alive()
    return not self.picked
end

function Pickup:SetItem(item)
	self.item = item

    self.item.GetParentEntity = function(item)
        return self
    end
end

function Pickup:GetItem()
    return self.item
end

function Pickup:OnPickedUp(event)
    UTIL_Remove(self:GetItem()) -- otherwise it pollutes the player inventory
    self.picked = true
end

function Pickup:Destroy()
    if not self.picked then
        UTIL_Remove(self:GetItem())
    end

    if self.drop ~= nil and not self.drop:IsNull() then
        UTIL_Remove(self.drop)
    end
end