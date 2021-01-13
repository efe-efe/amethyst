DummyTarget = DummyTarget or class({}, nil, UnitEntity)

function DummyTarget:constructor(origin)    
    getbase(DummyTarget).constructor(self, origin, "npc_dota_creature_dummy_target")
end

function DummyTarget:OnDeath(params)
    self:Destroy()
end