

function CDOTA_BaseNPC:Initialize(data)
	self.on_spawn_ends = 			{}
	self.on_basic_attack_impact = 	{}

	self.displacement_modifiers = 	{}
	self.reflect_modifiers = 		{}
	self.counter_modifiers = 		{}
	self.animation_modifiers = 		{}
	self.channeling_modifiers = 	{}
	self.status_modifiers =			{}
end

function CDOTA_BaseNPC_Hero:Initialize(data)
	self.direction = 				{}
	self.on_spawn_ends = 			{}
	self.on_basic_attack_impact = 	{}

	self.displacement_modifiers = 	{}
	self.reflect_modifiers = 		{}
	self.counter_modifiers = 		{}
	self.animation_modifiers = 		{}
	self.channeling_modifiers = 	{}
	self.status_modifiers = 		{}
	
	self.forced_direction = 		nil
	self.treshold = 				0

	self.first_left = 				false
	self.first_right = 				false
	self.first_up = 				false
	self.first_down = 				false

	self.initialized = 				nil
	self.healing_reduction_pct = 	0

	self:SetDirection(0,0)
	self:SetTreshold(GameRules.GameMode.max_treshold)
	self:SetInitialized(true)
	self:AddNewModifier(self,  nil, "modifier_hero_base", {})

	for i = 0, 23 do
		local ability = self:GetAbilityByIndex(i)
		if ability then
			if ability:GetAbilityType() ~= 2 then -- To not level up the talents
				ability:SetLevel(1)
			end
		end
	end
	self:OnSpawnEnds()
end
function CDOTA_BaseNPC:OnSpawnEnds()
	for _,routine in pairs(self.on_spawn_ends) do
		routine()
	end
end

function CDOTA_BaseNPC:Reset()
	self:SetMana(0)
	self:SetHealth(self:GetMaxHealth())
	self:SetTreshold(GameRules.GameMode.max_treshold)

	for i = 0, 23 do
		local ability = self:GetAbilityByIndex(i)
		if ability then
			ability:EndCooldown()
			if ability:GetToggleState() then
				ability:ToggleAbility()
			end
		end
	end

	for i = 0, 5 do
		local item = self:GetItemInSlot(i)
	
		if item then
			item:EndCooldown()
		end
	end

	self:InterruptCastPoint()
	self:Purge(true, true, false, true, false)
	self:RemoveModifierByName("modifier_generic_displacement")
end

function CDOTA_BaseNPC:OnBasicAttackImpact(hTarget)
	for _,routine in pairs(self.on_basic_attack_impact) do
		if routine then
			routine.method(routine.context, hTarget)
		end
	end
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
	local playerID = self:GetPlayerOwnerID()

	if playerID == -1 then
		return false
	end

	return GameRules.GameMode.players[playerID].alliance
end

function CDOTA_BaseNPC:IsAlly( unit )
	local playerID = self:GetPlayerOwnerID()
	local playerID_test = unit:GetPlayerOwnerID()

	if playerID_test == -1 then
		return false
	end

	return self:GetAlliance() == unit:GetAlliance()
end

function CDOTA_BaseNPC:CanWalk()
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

function CDOTA_BaseNPC:AddCooldownVisual( incoming_data )
	local data = {
		heroIndex = self:GetEntityIndex(),
        teamID = self:GetTeamNumber(),
		modifierName = incoming_data.modifier:GetName(),
	}
	
	table.insert(self.on_spawn_ends, function()
		CustomGameEventManager:Send_ServerToAllClients( "add_cooldown", data )
	end)
end

function CDOTA_BaseNPC:AddChargesVisual( incoming_data )
	local data = {
		heroIndex = self:GetEntityIndex(),
        teamID = self:GetTeamNumber(),
		modifierName = incoming_data.modifier:GetName(),
	}
	
	table.insert(self.on_spawn_ends, function()
		CustomGameEventManager:Send_ServerToAllClients( "add_charges", data )
	end)
end

function CDOTA_BaseNPC:AddStacksVisual(incoming_data)
	local data = {
		heroIndex = self:GetEntityIndex(),
        teamID = self:GetTeamNumber(),
		modifierName = incoming_data.modifier:GetName(),
	}

	CustomGameEventManager:Send_ServerToAllClients( "add_stacks", data )
end

function CDOTA_BaseNPC:AddRecastVisual( incoming_data )
	local data = {
		heroIndex = self:GetEntityIndex(),
		key = incoming_data.key,
		modifierName = incoming_data.modifier:GetName(),
		abilityName = incoming_data.abilityName,
        teamID = self:GetTeamNumber(),
	}
	CustomGameEventManager:Send_ServerToAllClients( "add_recast", data )
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

function CDOTA_BaseNPC:GiveManaPercent( percentage, source )
	local is_amethyst = false

	if source and source.GetParentEntity then
		local entity = source:GetParentEntity()

		if instanceof(entity, Amethyst) then 
			is_amethyst = true
		end
	end

    if source and (is_amethyst or source:IsObstacle()) then
        return
    end

    self:GiveMana(self:GetMaxMana() * percentage/100)
end

function CDOTA_BaseNPC:StrongPurge()
    self:Purge(false, true, false, true, false)
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

function CDOTA_BaseNPC:FaceTowardsCustom(vDirection)
	if self:IsDisplacing() then
		return
	end
	self:SetForwardVector(vDirection)
	self:FaceTowards(self:GetAbsOrigin() + vDirection)
end

function CDOTA_BaseNPC:AddStatus(data)
	local status = {
		priority = data.priority or 0,
		label = data.label or "No Label",
		style_name = data.style_name or "Generic",
		content = data.content or nil,
		trigger = data.trigger or "duration",
		max_stacks = data.max_stacks or nil,
		modifier_name = data.modifier_name,
	}
	self.status_modifiers[status.modifier_name] = status
end

function CDOTA_BaseNPC:RemoveStatus(modifier_name)
	self.status_modifiers[modifier_name] = nil
end


-- Modifiers
MODIFIER_DISPLACEMENT = 1
MODIFIER_COUNTER = 2
MODIFIER_REFLECT = 3
MODIFIER_ANIMATION = 4
MODIFIER_CHANNELING = 5 

function CDOTA_BaseNPC:AddModifierTracker(modifier_name, type) 	
	local key = nil

	if type == MODIFIER_DISPLACEMENT then key = "displacement_modifiers" end
	if type == MODIFIER_COUNTER then key = "counter_modifiers" end
	if type == MODIFIER_REFLECT then key = "reflect_modifiers" end
	if type == MODIFIER_ANIMATION then key = "animation_modifiers" end
	if type == MODIFIER_CHANNELING then key = "channeling_modifiers" end


	table.insert(self[key], modifier_name)
end


function CDOTA_BaseNPC:RemoveModifierTracker(modifier_name, type)
	local key = nil
	
	if type == MODIFIER_DISPLACEMENT then key = "displacement_modifiers" end
	if type == MODIFIER_COUNTER then key = "counter_modifiers" end
	if type == MODIFIER_REFLECT then key = "reflect_modifiers" end
	if type == MODIFIER_ANIMATION then key = "animation_modifiers" end
	if type == MODIFIER_CHANNELING then key = "channeling_modifiers" end

	for _,m_modifier_name in pairs(self[key]) do
		if m_modifier_name == modifier_name then
			self[key][_] = nil
		end
	end
end
 
-- States
function CDOTA_BaseNPC:IsCountering()
	if self.counter_modifiers and #self.counter_modifiers > 0 then
		return true
	end

	return 	self:HasModifier("modifier_counter")
end

function CDOTA_BaseNPC:IsReflecting()
	return self.reflect_modifiers and #self.reflect_modifiers > 0
end

function CDOTA_BaseNPC:IsDisplacing()
	return self.displacement_modifiers and #self.displacement_modifiers > 0
end

function CDOTA_BaseNPC:IsAnimating()
	return self.animation_modifiers and #self.animation_modifiers > 0
end

function CDOTA_BaseNPC:IsConfused()				return 	self:HasModifier("modifier_generic_confuse") 	end
function CDOTA_BaseNPC:IsSilenced()				return 	self:HasModifier("modifier_generic_silence")	end
function CDOTA_BaseNPC:IsFeared()				return 	self:HasModifier("modifier_generic_fear")		end
function CDOTA_BaseNPC:IsCasting()				return 	self:HasModifier("modifier_cast_point")			end
function CDOTA_BaseNPC:IsInitialized()			return 	self.initialized								end


-- Getters
function CDOTA_BaseNPC:GetTreshold()				return self.treshold				end
function CDOTA_BaseNPC:GetDirection()				return self.direction				end
function CDOTA_BaseNPC:GetStatus()					return self.status_modifiers		end

-- Setters
function CDOTA_BaseNPC:SetInitialized(initialized)	
	self.initialized = initialized
end

function CDOTA_BaseNPC:SetTreshold(treshold)	
	self.treshold = treshold
end

function CDOTA_BaseNPC:SetDirection(x, y)
	local current_direction = self:GetDirection()
	local m_x = x or current_direction.x
	local m_y = y or current_direction.y 
	self.direction = Vector(m_x, m_y, self:GetForwardVector().z)
end
