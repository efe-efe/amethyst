Pickup = Pickup or class({}, nil, HScriptEntity)

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

function Pickup:constructor(type, origin, delay, scale, callback)
    self.type = type
    self.origin = origin
    self.scale = scale
    self.delay = delay
    self.callback = callback
    self.item = nil
    self.drop = nil

    self:SetItem(CreateItem( PICKUP_ITEM_NAMES[self.type], nil, nil ))
    self:GetItem():SetCastOnPickup(true)

    self:Spawn()
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

function Pickup:Spawn()
    self:GetItem():LaunchLootInitialHeight( false, 0, 50, 0.5, self.origin )
    self:GetItem():SetContextThink("Spawn", function() 
        self.drop = CreateItemOnPositionForLaunch( self.origin, self:GetItem() )
        ParticleManager:CreateParticle( PICKUP_PARTICLES[self.type], PATTACH_ABSORIGIN_FOLLOW, self.drop )
        
        if self.scale ~= nil then
            self.drop:SetModelScale( self.scale )	
        end
    end, self.delay)
end

function Pickup:OnPickedUp()
    UTIL_Remove( self:GetItem() ) -- otherwise it pollutes the player inventory

    if self.callback then
        self.callback()
    end
end

function Pickup:Remove()

end