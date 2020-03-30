DummyTarget = DummyTarget or class({}, nil, UnitEntity)

function DummyTarget:constructor(origin)    
    getbase(DummyTarget).constructor(self, origin, "npc_dota_creature_dummy_target")

    local unit = self:GetUnit()
    local data = { unitIndex = unit:GetEntityIndex() }
    
    CustomGameEventManager:Send_ServerToAllClients( "add_unit", data )    
end

function DummyTarget:OnDeath(params)
    self:Destroy()
end