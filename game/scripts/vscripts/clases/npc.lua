NPC = NPC or class({}, nil, UnitEntity)
DireZombie = DireZombie or class({}, nil, NPC)

function NPC:constructor(vOrigin, sUnitName)
    getbase(NPC).constructor(self, vOrigin, sUnitName, DOTA_TEAM_CUSTOM_1)
end

function NPC:Update()
end

function DireZombie:constructor(vOrigin)
    getbase(DireZombie).constructor(self, vOrigin, "dire_zombie")
end