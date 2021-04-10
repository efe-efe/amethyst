UnitEntity = UnitEntity or class({})

function UnitEntity:constructor(origin, name, team)
    self.origin = origin
    self.destroyed = false
    self.team = team or DOTA_TEAM_NOTEAM

    self:SetUnit(CreateUnitByName(
        name, --szUnitName
        self.origin, --vLocation
        true, --bFindClearSpace
        nil, --hNPCOwner
        nil, --hUnitOwner
        self.team
   ))   
    
    self:GetUnit():SetAbsOrigin(self.origin)
end

function UnitEntity:SetUnit(unit)
	self.unit = unit

    self.unit.GetParentEntity = function(unit)
        return self
    end
end

function UnitEntity:GetUnit()
    return self.unit
end

function UnitEntity:Alive()
    return not self.destroyed
end

function UnitEntity:Destroy(remove)
    self.destroyed = true

    if remove then
        UTIL_Remove(self:GetUnit())
    end
end