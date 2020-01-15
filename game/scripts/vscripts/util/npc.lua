function CDOTA_BaseNPC:Initialize(data)
	self.bFirstSpawnedPG = true

	self.direction = {}
	self.forced_direction = nil
	self.direction.x = 0
	self.direction.y = 0
	self.direction.z = 0

	self.first_left = false
	self.first_right = false
	self.first_up = false
	self.first_down = false

	self.last_spell = nil
	self.lifes = data.max_lifes

	self.healing_reduction_pct = 0
end

function CDOTA_BaseNPC:InterruptCastPoint()
	self:RemoveModifierByName("modifier_cast_point")
end

function CDOTA_BaseNPC:HideHealthBar()
	self:AddNewModifier(self, nil, "modifier_hide_bar", {})
end

function CDOTA_BaseNPC:UnhideHealthBar()
	self:RemoveModifierByName("modifier_hide_bar")
end

function CDOTA_BaseNPC:ForceDirection( direction )
	self.forced_direction = direction
end

function CDOTA_BaseNPC:UnforceDirection( direction )
	self.forced_direction = nil
end

function CDOTA_BaseNPC:IsDirectionForced()
	if self.forced_direction ~= nil then
		return true
	end
	return false
end

function CDOTA_BaseNPC:GetAlliance()
	local team = self:GetTeamNumber()
	return Alliances:FindByTeam(team)
end

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

function CDOTA_BaseNPC:FindUnitsInLine( start_pos, end_pos, radius, teamFilter, typeFilter, flagFilter )
	local units = FindUnitsInLine(
		self:GetTeamNumber(), -- int, your team number
		start_pos, -- point, start position
		end_pos, -- point, end position
		nil, -- handle, cacheUnit. (not known)
		radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_BOTH,
		typeFilter,
		flagFilter
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

function CDOTA_BaseNPC:IsAmethyst()
    return self:Attribute_GetIntValue("middle_orb", 0) == 1 and true or false
end

function CDOTA_BaseNPC:IsBarrel()
    return self:Attribute_GetIntValue("barrel", 0) == 1 and true or false
end

function CDOTA_BaseNPC:IsWall()
    return self:Attribute_GetIntValue("wall", 0) == 1 and true or false
end


function CDOTA_BaseNPC:IsObstacle()
    return ( self:IsBarrel() or self:IsWall() ) and true or false
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
    if source ~= nil and (source:IsAmethyst() or source:IsObstacle()) then
        return
    end

    self:GiveMana(self:GetMaxMana() * percentage/100)
end

function CDOTA_BaseNPC:IsSilenced()
    return self:HasModifier("modifier_generic_silenced")
end

function CDOTA_BaseNPC:HasFear()
    return self:HasModifier("modifier_generic_fear")
end

function CDOTA_BaseNPC:StrongPurge()
    self:Purge(false, true, false, true, false)
end

function CDOTA_BaseNPC:GetDirection()
	return Vector(self.direction.x, self.direction.y, nil)
end

function CDOTA_BaseNPC:GetForcedDirection()
	if self.forced_direction == nil then
		return nil
	else 
		return Vector(self.forced_direction.x, self.forced_direction.y, nil)
	end
end

function CDOTA_BaseNPC:IsWalking()
	local is_walking = false
	local direction = self:GetDirection()
	local forced_direction = self:GetForcedDirection()
	
	if 	direction.x ~= 0 or 
		direction.y ~= 0 or 
		forced_direction and (
			forced_direction.x ~= 0 or 
			forced_direction.y ~= 0
		)
	then
		return true
	else
		return false
	end
end

function CDOTA_BaseNPC:IsCountering()
	return self:HasModifier("modifier_counter")
end

function CDOTA_BaseNPC:IsConfused()
	return self:HasModifier("modifier_generic_confused")
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



