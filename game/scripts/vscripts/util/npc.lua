function CDOTA_BaseNPC:IsAlly( hero )
	return Alliances:CheckAllies(self, hero)
end

function CDOTA_BaseNPC:CanWalk( hero )
	return not ( self:IsStunned() or 
	self:IsCommandRestricted() or 
	self:IsRooted() or
	self:IsNightmared() or
	not self:IsAlive() )
end

function CDOTA_BaseNPC:FindUnitsInRadius( origin, radius, teamFilter, typeFilter, flagFilter, orderFilter  )
    local units = FindUnitsInRadius( 
        self:GetTeamNumber(), -- int, your team number
        origin, -- point, center point
        nil, -- handle, cacheUnit. (not known)
        radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_BOTH, -- int, team filter
        typeFilter,	-- int, type filter
        flagFilter, -- int, flag filter
        orderFilter, -- int, order filter
        false -- bool, can grow cache
	)

	local filtered_units = {}
	local counter = 1
	
	for _,unit in pairs(units) do
		if teamFilter == DOTA_UNIT_TARGET_TEAM_FRIENDLY and self:IsAlly(unit) then
			filtered_units[counter] = unit
			counter = counter + 1
		elseif teamFilter == DOTA_UNIT_TARGET_TEAM_ENEMY and not self:IsAlly(unit) then
			filtered_units[counter] = unit
			counter = counter + 1
		elseif teamFilter == DOTA_UNIT_TARGET_TEAM_BOTH then
			filtered_units[counter] = unit
			counter = counter + 1
		end
	end
	
	return filtered_units
end

function CDOTA_BaseNPC:AddStatusBar( incoming_data ) --{ label, modifier, priority, reversed }
	local data = {
		heroIndex = self:GetEntityIndex(),
		label = incoming_data.label,
		modifierName = incoming_data.modifier:GetName(),
		priority = incoming_data.priority or 0,
		reversed = incoming_data.reversed or nil,
		type = incoming_data.type or "duration",
		maxStacks = incoming_data.maxStacks or nil,
		local_only = incoming_data.local_only or nil,
		stylename = incoming_data.stylename or nil,
	}
	CustomGameEventManager:Send_ServerToAllClients( "add_status", data )
end

function CDOTA_BaseNPC:AddRecastVisual( incoming_data )
	local data = {
		heroIndex = self:GetEntityIndex(),
		key = incoming_data.key,
		modifierName = incoming_data.modifier:GetName(),
		abilityName = incoming_data.abilityName,
	}

	self:AddStatusBar({
		label = "Recast", 
		modifier = incoming_data.modifier, 
		priority = 4, 
		local_only = 1,
		stylename = "Recast",
		type = incoming_data.type or "duration",
		maxStacks = incoming_data.maxStacks or nil,
	})

	CustomGameEventManager:Send_ServerToAllClients( "add_recast", data )
end

function CDOTA_BaseNPC:IsMiddleOrb()
    return self:Attribute_GetIntValue("middle_orb", 0) == 1 and true or false
end

function CDOTA_BaseNPC:IsWall()
    return self:Attribute_GetIntValue("wall", 0) == 1 and true or false
end

--[[
function CDOTA_BaseNPC:GetLastAbility()
	return self.last_spell
end

function CDOTA_BaseNPC:SetLastAbility( ability )
	self.last_spell = ability
end
]]

function CDOTA_BaseNPC:GiveManaPercent( percentage, source )
    if source ~= nil and (source:IsMiddleOrb() or source:IsWall()) then
        return
    end

    self:GiveMana(self:GetMaxMana() * percentage/100)
end

function CDOTA_BaseNPC:IsSilenced()
    return self:HasModifier("modifier_generic_silenced_lua")
end

function CDOTA_BaseNPC:IsStunned()
    return self:HasModifier("modifier_generic_stunned")
end

function CDOTA_BaseNPC:StrongPurge()
    self:Purge(false, true, false, true, false)
end

function CDOTA_BaseNPC:GetDirection()
	return Vector(self.direction.x, self.direction.y, nil)
end

function CDOTA_BaseNPC:IsWalking()
	local direction = self:GetDirection()
    return direction.x ~= 0 or direction.y ~= 0
end

function CDOTA_BaseNPC:DeactivateAllAbilitiesWithExeption( spell )
	if IsServer() then
		for i = 0, 10 do
			local ability = self:GetAbilityByIndex(i)
			if ability then
                if ability ~= spell then
                    ability:SetActivated( false )
                end
			end
		end
	end
end

function CDOTA_BaseNPC:DeactivateNonPriorityAbilities()
	if IsServer() then
		for i = 0, 10 do
			local ability = self:GetAbilityByIndex(i)
			if 	not ability:IsCounter() and
				not ability:IsMobility() and 
				not ability:IsUltimate() and 
				not ability:HasPriority() 
			then
				ability:SetActivated( false )
			end
		end
	end
end

function CDOTA_BaseNPC:SetAllAbilitiesActivated( mode )
	if IsServer() then
		for i = 0, 13 do
			self:GetAbilityByIndex(i):SetActivated( mode )
		end
	end
end



