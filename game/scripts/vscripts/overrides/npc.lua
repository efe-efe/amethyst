

function CDOTA_BaseNPC:Initialize(data)
	print('WARNING: USING CDOTA_BaseNPC:Initialize instead of CustomEntities. Entity name = ', self:GetName())
	self.on_basic_attack_impact = 	{}
	self.treshold = 				0
	self.energy = 					0
	self.max_energy = 				100

	self.charges_modifiers =		{}
	self.displacement_modifiers = 	{}
	self.reflect_modifiers = 		{}
	self.counter_modifiers = 		{}
	self.animation_modifiers = 		{}
	self.channeling_modifiers = 	{}
	self.status_modifiers =			{}
	self.fear_modifiers =			{}
	self.translate_modifiers = 		{}
	self.move_force_modifiers = 	{}
	self.on_projectile_hit_modifiers = {}

	self:SetEnergy(self.max_energy)	
	self:AddNewModifier(self,  nil, "modifier_visible", {})
	GameRules.GameMode:RegisterUnit(self)
	self:SetTreshold(GameRules.GameMode.max_treshold)
end

function CDOTA_BaseNPC_Hero:Initialize(data)
	print('WARNING: USING CDOTA_BaseNPC_Hero:Initialize instead of CustomEntities. Entity name = ', self:GetName())

	self.direction = 				{}
	self.on_basic_attack_impact = 	{}

	self.charges_modifiers =		{}
	self.displacement_modifiers = 	{}
	self.reflect_modifiers = 		{}
	self.counter_modifiers = 		{}
	self.animation_modifiers = 		{}
	self.channeling_modifiers = 	{}
	self.status_modifiers = 		{}
	self.recast_modifiers =			{}
	self.fear_modifiers =			{}
	self.translate_modifiers = 		{}
	self.move_force_modifiers = 	{}
	self.on_projectile_hit_modifiers = {}
	self.stackbars_modifier =		nil
	self.charges_modifier =			nil
	self.cooldown_modifier =		nil
	
	self.treshold = 				0
	self.energy = 					0
	self.max_energy = 				100

	self.first_left = 				false
	self.first_right = 				false
	self.first_up = 				false
	self.first_down = 				false

	self.initialized = 				nil
	self.healing_reduction_pct = 	0
	self.collision_direction = 		-1

	self:SetEnergy(self.max_energy)	
	self:SetDirection(0,0)
	self:SetTreshold(GameRules.GameMode.max_treshold)
	self:SetInitialized(true)
	self:AddNewModifier(self,  nil, "modifier_hero_base", {})
	self:AddNewModifier(self,  nil, "modifier_visible", {})

	for i = 0, 23 do
		local ability = self:GetAbilityByIndex(i)
		if ability then
			if ability:GetAbilityType() ~= 2 then -- To not level up the talents
				ability:SetLevel(1)
			end
		end
	end

	self:SetAbilityPoints(ABILITY_POINTS)
	ConstructHero(self)
end

function CDOTA_BaseNPC:SendDataToClient()
	print('WARNING: USING CDOTA_BaseNPC_Hero:SendDataToClient instead of CustomEntities. Entity name = ', self:GetName())
	print('SendDataToClient: Not implemented yet!')
end

function CDOTA_BaseNPC_Hero:SetCollisionDirection(iCollisionDirection)
	print('WARNING: USING CDOTA_BaseNPC_Hero:SetCollisionDirection instead of CustomEntities. Entity name = ', self:GetName())
	self.collision_direction = iCollisionDirection
end

function CDOTA_BaseNPC_Hero:GetCollisionDirection()
	print('WARNING: USING CDOTA_BaseNPC_Hero:GetCollisionDirection instead of CustomEntities. Entity name = ', self:GetName())
	return self.collision_direction
end


function CDOTA_BaseNPC_Hero:SendDataToClient()
	print('WARNING: USING CDOTA_BaseNPC_Hero:SendDataToClient instead of CustomEntities. Entity name = ', self:GetName())
	if self:IsIllusion() then
		return
	end

	local allianceName = "NOT_ALLIANCE"

	if self:GetAlliance() then
		allianceName = self:GetAlliance():GetName() 
	end

	local data = {
		entityIndex = self:GetEntityIndex(),
		teamId = self:GetTeam(),
		playerId = self:GetPlayerOwnerID(),
		allianceName = allianceName,
		name = self:GetName(),
		health = self:GetHealth(),
		maxHealth = self:GetMaxHealth(),
		treshold = self:GetTreshold(),
		shield = self:GetShield(),
		mana = self:GetMana(),
		maxMana = self:GetMaxMana(),
		status = self:GetStatus(),
		recast = self:GetRecast(),
		stackbars = self:GetStackbars(),
		charges = self:GetCharges(),
		cooldown = self:GetCooldown(),
		abilities = self:GetAbilities(),
		energy = self:GetEnergy(),
		maxEnergy = self:GetMaxEnergy(),
	}
	CustomNetTables:SetTableValue("heroes", tostring(self:GetPlayerID()), data)
end

function CDOTA_BaseNPC:GiveManaPercent(iPercentage, bInformClient, bShowOverhead)
	print('WARNING: USING CDOTA_BaseNPC_Hero:GiveManaPercent instead of CustomEntities. Entity name = ', self:GetName())
	local mana = self:GetMaxMana() * iPercentage/100
	self:GiveManaCustom(mana, bInformClient, bShowOverhead)
end

function CDOTA_BaseNPC:GiveEnergyPercent(iPercentage, bInformClient, bShowOverhead)
	print('WARNING: USING CDOTA_BaseNPC_Hero:GiveEnergyPercent instead of CustomEntities. Entity name = ', self:GetName())
	local energy = self:GetMaxEnergy() * iPercentage/100
	self:GiveEnergy(energy, bInformClient, bShowOverhead)
end

function CDOTA_BaseNPC:GiveManaAndEnergyPercent(iPercentage, bInformClient, bShowOverhead)
	print('WARNING: USING CDOTA_BaseNPC_Hero:GiveManaAndEnergyPercent instead of CustomEntities. Entity name = ', self:GetName())
	self:GiveManaPercent(iPercentage, false, bShowOverhead)
	self:GiveEnergyPercent(iPercentage, false, false)
	if bInformClient then
		self:SendDataToClient()
	end
end

function CDOTA_BaseNPC:GiveManaAndEnergy(fAmount, bInformClient, bShowOverhead)
	print('WARNING: USING CDOTA_BaseNPC_Hero:GiveManaAndEnergy instead of CustomEntities. Entity name = ', self:GetName())
	self:GiveEnergy(fAmount, false)
	self:GiveManaCustom(fAmount, false, bShowOverhead)
	if bInformClient then
		self:SendDataToClient()
	end
end

function CDOTA_BaseNPC:GiveManaCustom(fMana, bInformClient, bShowOverhead)
	print('WARNING: USING CDOTA_BaseNPC_Hero:GiveManaCustom instead of CustomEntities. Entity name = ', self:GetName())
	self:GiveMana(fMana)
	if bInformClient then
		self:SendDataToClient()
	end
	if bShowOverhead then
		SendOverheadManaMessage(self, fMana)
	end
end

function CDOTA_BaseNPC:SetManaCustom(fMana, bInformClient)
	print('WARNING: USING CDOTA_BaseNPC_Hero:SetManaCustom instead of CustomEntities. Entity name = ', self:GetName())
	self:SetMana(fMana)
	if bInformClient then
		self:SendDataToClient()
	end
end

function CDOTA_BaseNPC:SetHealthCustom(fHealth)
	print('WARNING: USING CDOTA_BaseNPC_Hero:SetHealthCustom instead of CustomEntities. Entity name = ', self:GetName())
	self:SetHealth(fHealth)
	self:SendDataToClient()
	
	local alliance = self:GetAlliance()
	if alliance then
		alliance:SendDataToClient()
	end
end 
	
function CDOTA_BaseNPC:Reset()
	print('WARNING: USING CDOTA_BaseNPC_Hero:Reset instead of CustomEntities. Entity name = ', self:GetName())
	if not IsInToolsMode() then
		self:SetManaCustom(0, true)
		self:SetEnergy(0)
	end
	self:SetHealthCustom(self:GetMaxHealth())
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

	for _,modifier_name in pairs(self.charges_modifiers) do
		local modifier = self:FindModifierByName(modifier_name)
		if modifier then
			modifier:RefreshCharges()
		end
	end

	self:InterruptCastPoint()
	self:Purge(true, true, false, true, false)
end

function CDOTA_BaseNPC:OnBasicAttackImpact(hTarget)
	print('WARNING: USING CDOTA_BaseNPC_Hero:OnBasicAttackImpact instead of CustomEntities. Entity name = ', self:GetName())
	for _,routine in pairs(self.on_basic_attack_impact) do
		if routine then
			routine.method(routine.context, hTarget)
		end
	end
end

function CDOTA_BaseNPC:OnProjectileHit(projectile, entity)
	print('WARNING: USING CDOTA_BaseNPC_Hero:OnProjectileHit instead of CustomEntities. Entity name = ', self:GetName())
	local keep_processing = true

	for _,modifier_name in pairs(entity:GetOnProjectileHit()) do
		local modifier_handle = entity:FindModifierByName(modifier_name)
		
		if not modifier_handle:OnProjectileHitCustom({ projectile = projectile, target = entity }) then
			keep_processing = false
		end
	end

	return keep_processing
end


function CDOTA_BaseNPC:InterruptCastPoint()
	print('WARNING: USING CDOTA_BaseNPC_Hero:InterruptCastPoint instead of CustomEntities. Entity name = ', self:GetName())
	self:RemoveModifierByName("modifier_casting")
end

function CDOTA_BaseNPC:HideHealthBar()
	print('WARNING: USING CDOTA_BaseNPC_Hero:HideHealthBar instead of CustomEntities. Entity name = ', self:GetName())
	self:AddNewModifier(self, nil, "modifier_hide_bar", {})
end

function CDOTA_BaseNPC:UnhideHealthBar()
	print('WARNING: USING CDOTA_BaseNPC_Hero:UnhideHealthBar instead of CustomEntities. Entity name = ', self:GetName())
	self:RemoveModifierByName("modifier_hide_bar")
end

function CDOTA_BaseNPC:GetAlliance()
	print('WARNING: USING CDOTA_BaseNPC_Hero:GetAlliance instead of CustomEntities. Entity name = ', self:GetName())
	local playerID = self:GetPlayerOwnerID()

	if playerID == -1 then
		return false
	end

	local player_object = GameRules.GameMode.players[playerID]
	
	if player_object then
		return player_object.alliance
	end

	return nil
end

function CDOTA_BaseNPC:IsAlly(unit)
	print('WARNING: USING CDOTA_BaseNPC_Hero:IsAlly instead of CustomEntities. Entity name = ', self:GetName())
	local playerID = self:GetPlayerOwnerID()
	local playerID_test = unit:GetPlayerOwnerID()

	if playerID_test == -1 then
		return false
	end

	return self:GetAlliance() == unit:GetAlliance()
end

function CDOTA_BaseNPC:CanWalk()
	print('WARNING: USING CDOTA_BaseNPC_Hero:CanWalk instead of CustomEntities. Entity name = ', self:GetName())
	return not (self:IsStunned() or 
	self:IsCommandRestricted() or 
	self:IsRooted() or
	self:IsNightmared() or
	not self:IsAlive())
end

function CDOTA_BaseNPC:FindUnitsInRadius(origin, radius, teamFilter, typeFilter, flagFilter, orderFilter )
	print('WARNING: USING CDOTA_BaseNPC_Hero:FindUnitsInRadius instead of CustomEntities. Entity name = ', self:GetName())
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

function CDOTA_BaseNPC:FindUnitsInLine(start_pos, end_pos, radius, teamFilter, typeFilter, flagFilter)
	print('WARNING: USING CDOTA_BaseNPC_Hero:FindUnitsInLine instead of CustomEntities. Entity name = ', self:GetName())
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

function CDOTA_BaseNPC:FindUnitsInCone(vDirection, fMinProjection, vCenterPos, fRadius, nTeamFilter, nTypeFilter, nFlagFilter, nOrderFilter)
	print('WARNING: USING CDOTA_BaseNPC_Hero:FindUnitsInCone instead of CustomEntities. Entity name = ', self:GetName())
	local units = FindUnitsInCone(
		self:GetTeamNumber(), 
		vDirection, 
		fMinProjection,
		vCenterPos, 
		fRadius, 
		nil, 
		nTeamFilter, 
		nTypeFilter, 
		nFlagFilter, 
		nOrderFilter, 
		false
	)

	local filtered_units = {}
	local counter = 1
	
	for _,unit in pairs(units) do
		if nTeamFilter == DOTA_UNIT_TARGET_TEAM_FRIENDLY and self:IsAlly(unit) then
			filtered_units[counter] = unit
			counter = counter + 1
		elseif nTeamFilter == DOTA_UNIT_TARGET_TEAM_ENEMY and not self:IsAlly(unit) then
			filtered_units[counter] = unit
			counter = counter + 1
		elseif nTeamFilter == DOTA_UNIT_TARGET_TEAM_BOTH then
			filtered_units[counter] = unit
			counter = counter + 1
		end
	end
	
	return filtered_units
end

function CDOTA_BaseNPC:FindUnitsInCirclesProjection(vCenterPos, vStartPos, vEndPos, fStartRadius, fEndRadius, teamFilter, nTypeFilter, nFlagFilter, nOrderFilter)
	print('WARNING: USING CDOTA_BaseNPC_Hero:FindUnitsInCirclesProjection instead of CustomEntities. Entity name = ', self:GetName())
	local units = FindUnitsInCirclesProjection(
		self:GetTeamNumber(), 
		vCenterPos, 
		vStartPos,
		vEndPos,
		fStartRadius, 
		fEndRadius, 
		nil, 
		DOTA_UNIT_TARGET_TEAM_BOTH, 
		nTypeFilter, 
		nFlagFilter, 
		nOrderFilter, 
		false
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

function CDOTA_BaseNPC:IsBarrel()
	print('WARNING: USING CDOTA_BaseNPC_Hero:IsBarrel instead of CustomEntities. Entity name = ', self:GetName())

    return self:Attribute_GetIntValue("barrel", 0) == 1 and true or false
end

function CDOTA_BaseNPC:IsWall()
	print('WARNING: USING CDOTA_BaseNPC_Hero:IsWall instead of CustomEntities. Entity name = ', self:GetName())

    return self:Attribute_GetIntValue("wall", 0) == 1 and true or false
end

function CDOTA_BaseNPC:IsObstacle()
	print('WARNING: USING CDOTA_BaseNPC_Hero:IsObstacle instead of CustomEntities. Entity name = ', self:GetName())
    return (self:IsBarrel() or self:IsWall()) and true or false
end

function CDOTA_BaseNPC:ProvidesMana()
	print('WARNING: USING CDOTA_BaseNPC_Hero:ProvidesMana instead of CustomEntities. Entity name = ', self:GetName())
	if self and self.GetParentEntity then
		local entity = self:GetParentEntity()

		if instanceof(entity, Amethyst) then 
			return false
		end
	end

    if self:IsObstacle() then
        return false
	end

	return true
end

function CDOTA_BaseNPC:StrongPurge()
	print('WARNING: USING CDOTA_BaseNPC_Hero:StrongPurge instead of CustomEntities. Entity name = ', self:GetName())
    self:Purge(false, true, false, true, false)
end

function CDOTA_BaseNPC:IsWalking()
	print('WARNING: USING CDOTA_BaseNPC_Hero:IsWalking instead of CustomEntities. Entity name = ', self:GetName())
	local is_walking = false
	local direction = self:GetDirection()
	
	if 	direction.x ~= 0 or direction.y ~= 0 then
		return true
	else
		return false
	end
end

function CDOTA_BaseNPC:DeactivateAllAbilitiesWithExeption(spell)
	print('WARNING: USING CDOTA_BaseNPC_Hero:DeactivateAllAbilitiesWithExeption instead of CustomEntities. Entity name = ', self:GetName())
	if IsServer() then
		for i = 0, 10 do
			local ability = self:GetAbilityByIndex(i)
			if ability then
                if ability ~= spell then
                    ability:SetActivated(false)
                end
			end
		end
	end
end

function CDOTA_BaseNPC:SafeGetModifier(sModifierName, hCaster)
	print('WARNING: USING CDOTA_BaseNPC_Hero:SafeGetModifier instead of CustomEntities. Entity name = ', self:GetName())
	local modifier = nil
    if hCaster == nil then
        modifier = self:FindModifierByName(sModifierName)
    else
        modifier = self:FindModifierByNameAndCaster(sModifierName, hCaster)
    end

	if modifier ~= nil then
		if not modifier:IsNull() then
			return modifier
		end
	end

	return nil
end

function CDOTA_BaseNPC:SafeGetModifierStacks(sModifierName, hCaster)
	print('WARNING: USING CDOTA_BaseNPC_Hero:SafeGetModifierStacks instead of CustomEntities. Entity name = ', self:GetName())
	local modifier = self:SafeGetModifier(sModifierName, hCaster)
	if modifier then
		return modifier:GetStackCount()
	end

	return 0
end

function CDOTA_BaseNPC:SafeDestroyModifier(sModifierName, hCaster)
	print('WARNING: USING CDOTA_BaseNPC_Hero:SafeDestroyModifier instead of CustomEntities. Entity name = ', self:GetName())
	local modifier = self:SafeGetModifier(sModifierName, hCaster)
	if modifier then
		modifier:Destroy()
	end
end

function CDOTA_BaseNPC:DeactivateNonPriorityAbilities()
	print('WARNING: USING CDOTA_BaseNPC_Hero:DeactivateNonPriorityAbilities instead of CustomEntities. Entity name = ', self:GetName())
	if IsServer() then
		for i = 0, 10 do
			local ability = self:GetAbilityByIndex(i)
			if 	not ability:IsCounter() and
				not ability:IsMobility() and 
				not ability:IsUltimate() and 
				not ability:HasPriority() 
			then
				ability:SetActivated(false)
			end
		end
	end
end

function CDOTA_BaseNPC:SetAllAbilitiesActivated(mode)
	print('WARNING: USING CDOTA_BaseNPC_Hero:SetAllAbilitiesActivated instead of CustomEntities. Entity name = ', self:GetName())
	if IsServer() then
		for i = 0, 13 do
			self:GetAbilityByIndex(i):SetActivated(mode)
		end
	end
end

function CDOTA_BaseNPC:FaceTowardsCustom(vDirection)
	print('WARNING: USING CDOTA_BaseNPC_Hero:FaceTowardsCustom instead of CustomEntities. Entity name = ', self:GetName())
	if self:IsDisplacing() then
		return
	end
	self:SetForwardVector(vDirection)
	self:FaceTowards(self:GetAbsOrigin() + vDirection)
end

function CDOTA_BaseNPC:AddStatus(data)
	print('WARNING: USING CDOTA_BaseNPC_Hero:AddStatus instead of CustomEntities. Entity name = ', self:GetName())
	local status = {
		label = data.label or "No Label",
		modifier_name = data.modifier_name,
		priority = data.priority or 0,
		trigger = data.trigger or STATUS_TRIGGER_DURATION,
		content = data.content or STATUS_CONTENT_CLEAROUT,
		style_name = data.style_name or "Generic",
		max_stacks = data.max_stacks or nil,
		scope = data.scope or STATUS_SCOPE_PUBLIC
	}
	
	self.status_modifiers[status.modifier_name] = status
end

function CDOTA_BaseNPC:AddRecast(data)
	print('WARNING: USING CDOTA_BaseNPC_Hero:AddRecast instead of CustomEntities. Entity name = ', self:GetName())
	local recast = {
		key = data.key or "NO KEY",
		modifier_name = data.modifier_name,
		ability_name = data.ability_name,
	}
	self.recast_modifiers[recast.modifier_name] = recast
end


function CDOTA_BaseNPC:AddStackbars(modifier_name)
	print('WARNING: USING CDOTA_BaseNPC_Hero:AddStackbars instead of CustomEntities. Entity name = ', self:GetName())
	self.stackbars_modifier = modifier_name 
end
function CDOTA_BaseNPC:AddCharges(modifier_name)
	print('WARNING: USING CDOTA_BaseNPC_Hero:AddCharges instead of CustomEntities. Entity name = ', self:GetName())
	self.charges_modifier = modifier_name 
end
function CDOTA_BaseNPC:AddCooldown(modifier_name) 
	print('WARNING: USING CDOTA_BaseNPC_Hero:AddCooldown instead of CustomEntities. Entity name = ', self:GetName())
	self.cooldown_modifier = modifier_name 
end

function CDOTA_BaseNPC:RemoveStackbars() 
	print('WARNING: USING CDOTA_BaseNPC_Hero:RemoveStackbars instead of CustomEntities. Entity name = ', self:GetName())
	self.stackbars_modifier = nil 
end
function CDOTA_BaseNPC:RemoveCharges() 
	print('WARNING: USING CDOTA_BaseNPC_Hero:RemoveCharges instead of CustomEntities. Entity name = ', self:GetName())
	self.charges_modifier = nil 
end
function CDOTA_BaseNPC:RemoveCooldown() 
	print('WARNING: USING CDOTA_BaseNPC_Hero:RemoveCooldown instead of CustomEntities. Entity name = ', self:GetName())
	self.cooldown_modifier = nil 
end

function CDOTA_BaseNPC:RemoveStatus(modifier_name)
	print('WARNING: USING CDOTA_BaseNPC_Hero:RemoveStatus instead of CustomEntities. Entity name = ', self:GetName())
	self.status_modifiers[modifier_name] = nil
end
function CDOTA_BaseNPC:RemoveRecast(modifier_name)
	print('WARNING: USING CDOTA_BaseNPC_Hero:RemoveRecast instead of CustomEntities. Entity name = ', self:GetName())
	self.recast_modifiers[modifier_name] = nil
end

-- Modifiers
MODIFIER_DISPLACEMENT = 1
MODIFIER_COUNTER = 2
MODIFIER_REFLECT = 3
MODIFIER_ANIMATION = 4
MODIFIER_CHANNELING = 5 
MODIFIER_CHARGES = 6 
MODIFIER_TRANSLATE = 7 
MODIFIER_ON_PROJECTILE_HIT = 8 
MODIFIER_MOVE_FORCE = 9

function CDOTA_BaseNPC:AddModifierTracker(data, type) 	
	print('WARNING: USING CDOTA_BaseNPC_Hero:AddModifierTracker instead of CustomEntities. Entity name = ', self:GetName())
	local key = nil

	if type == MODIFIER_DISPLACEMENT then key = "displacement_modifiers" end
	if type == MODIFIER_COUNTER then key = "counter_modifiers" end
	if type == MODIFIER_REFLECT then key = "reflect_modifiers" end
	if type == MODIFIER_ANIMATION then key = "animation_modifiers" end
	if type == MODIFIER_CHANNELING then key = "channeling_modifiers" end
	if type == MODIFIER_CHARGES then key = "charges_modifiers" end
	if type == MODIFIER_FEAR then key = "fear_modifiers" end
	if type == MODIFIER_TRANSLATE then key = "translate_modifiers" end
	if type == MODIFIER_ON_PROJECTILE_HIT then key = "on_projectile_hit_modifiers" end
	if type == MODIFIER_MOVE_FORCE then key = "move_force_modifiers" end

	table.insert(self[key], data)
end

function CDOTA_BaseNPC:RemoveModifierTracker(data, type)
	print('WARNING: USING CDOTA_BaseNPC_Hero:RemoveModifierTracker instead of CustomEntities. Entity name = ', self:GetName())
	local key = nil
	
	if type == MODIFIER_DISPLACEMENT then key = "displacement_modifiers" end
	if type == MODIFIER_COUNTER then key = "counter_modifiers" end
	if type == MODIFIER_REFLECT then key = "reflect_modifiers" end
	if type == MODIFIER_ANIMATION then key = "animation_modifiers" end
	if type == MODIFIER_CHANNELING then key = "channeling_modifiers" end
	if type == MODIFIER_CHARGES then key = "charges_modifiers" end
	if type == MODIFIER_FEAR then key = "fear_modifiers" end
	if type == MODIFIER_TRANSLATE then key = "translate_modifiers" end
	if type == MODIFIER_ON_PROJECTILE_HIT then key = "on_projectile_hit_modifiers" end
	if type == MODIFIER_MOVE_FORCE then key = "move_force_modifiers" end

	for _,m_data in pairs(self[key]) do
		if m_data == data then
			self[key][_] = nil
		end
	end
end
 
-- States
function CDOTA_BaseNPC:IsCountering()
	print('WARNING: USING CDOTA_BaseNPC_Hero:IsCountering instead of CustomEntities. Entity name = ', self:GetName())
	if self.counter_modifiers and #self.counter_modifiers > 0 then
		return true
	end

	return 	self:HasModifier("modifier_counter")
end

function CDOTA_BaseNPC:IsReflecting()
	print('WARNING: USING CDOTA_BaseNPC_Hero:IsReflecting instead of CustomEntities. Entity name = ', self:GetName())
	return self.reflect_modifiers and #self.reflect_modifiers > 0
end

function CDOTA_BaseNPC:IsDisplacing()
	print('WARNING: USING CDOTA_BaseNPC_Hero:IsDisplacing instead of CustomEntities. Entity name = ', self:GetName())
	return self.displacement_modifiers and #self.displacement_modifiers > 0
end

function CDOTA_BaseNPC:IsAnimating()
	print('WARNING: USING CDOTA_BaseNPC_Hero:IsAnimating instead of CustomEntities. Entity name = ', self:GetName())
	return self.animation_modifiers and #self.animation_modifiers > 0
end

function CDOTA_BaseNPC:IsFeared() 
	print('WARNING: USING CDOTA_BaseNPC_Hero:IsFeared instead of CustomEntities. Entity name = ', self:GetName())
	return self.fear_modifiers and #self.fear_modifiers > 0
end

function CDOTA_BaseNPC:IsMoveForced()
	print('WARNING: USING CDOTA_BaseNPC_Hero:IsMoveForced instead of CustomEntities. Entity name = ', self:GetName())
	return self.move_force_modifiers and #self.move_force_modifiers > 0
end

function CDOTA_BaseNPC:IsConfused()
	print('WARNING: USING CDOTA_BaseNPC_Hero:IsConfused instead of CustomEntities. Entity name = ', self:GetName())
	return 	self:HasModifier("modifier_generic_confuse") 	
end
function CDOTA_BaseNPC:IsInitialized()
	print('WARNING: USING CDOTA_BaseNPC_Hero:IsInitialized instead of CustomEntities. Entity name = ', self:GetName())
	return 	self.initialized								
end

-- Getters

function CDOTA_BaseNPC:GetDirection()
	print('WARNING: USING CDOTA_BaseNPC_Hero:GetDirection instead of CustomEntities. Entity name = ', self:GetName())
	if self:IsFeared() then
		local fear_modifier_name = self.fear_modifiers[1]
		local fear_origin = self:FindModifierByName(fear_modifier_name):GetAbsOrigin()
		local direction = (fear_origin - self:GetAbsOrigin()):Normalized()
		
		return direction * -1
	end

	if self:IsMoveForced() then
		if self.direction.x == 0 and self.direction.y == 0 then 
			local forward_vector = self:GetForwardVector()
			return Vector(forward_vector.x, forward_vector.y)
		end	
	end
	return self.direction
end

function CDOTA_BaseNPC:GetRawDirection()
	print('WARNING: USING CDOTA_BaseNPC_Hero:GetRawDirection instead of CustomEntities. Entity name = ', self:GetName())
	return self.direction
end

function CDOTA_BaseNPC:GetShield()
	print('WARNING: USING CDOTA_BaseNPC_Hero:GetShield instead of CustomEntities. Entity name = ', self:GetName())
	local shield_modifier = self:FindModifierByName("modifier_shield")
    local shield = 0

    if shield_modifier ~= nil then
        if not shield_modifier:IsNull() then
            shield = shield_modifier:GetStackCount()
        end
	end
	
	return shield
end

function CDOTA_BaseNPC:GetTreshold()
	print('WARNING: USING CDOTA_BaseNPC_Hero:GetTreshold instead of CustomEntities. Entity name = ', self:GetName())
	return self.treshold						
end
function CDOTA_BaseNPC:GetStatus()
	print('WARNING: USING CDOTA_BaseNPC_Hero:GetStatus instead of CustomEntities. Entity name = ', self:GetName())
	return self.status_modifiers				
end
function CDOTA_BaseNPC:GetStackbars()
	print('WARNING: USING CDOTA_BaseNPC_Hero:GetStackbars instead of CustomEntities. Entity name = ', self:GetName())
	return self.stackbars_modifier				
end
function CDOTA_BaseNPC:GetCharges()
	print('WARNING: USING CDOTA_BaseNPC_Hero:GetCharges instead of CustomEntities. Entity name = ', self:GetName())
	return self.charges_modifier				
end
function CDOTA_BaseNPC:GetCooldown()
	print('WARNING: USING CDOTA_BaseNPC_Hero:GetCooldown instead of CustomEntities. Entity name = ', self:GetName())
	return self.cooldown_modifier				
end
function CDOTA_BaseNPC:GetRecast()
	print('WARNING: USING CDOTA_BaseNPC_Hero:GetRecast instead of CustomEntities. Entity name = ', self:GetName())
	return self.recast_modifiers				
end
function CDOTA_BaseNPC:GetTranslate()
	print('WARNING: USING CDOTA_BaseNPC_Hero:GetTranslate instead of CustomEntities. Entity name = ', self:GetName())
	return self.translate_modifiers				
end
function CDOTA_BaseNPC:GetOnProjectileHit()
	print('WARNING: USING CDOTA_BaseNPC_Hero:GetOnProjectileHit instead of CustomEntities. Entity name = ', self:GetName())
	return self.on_projectile_hit_modifiers		
end

function CDOTA_BaseNPC:GetAbilities()
	print('WARNING: USING CDOTA_BaseNPC_Hero:GetAbilities instead of CustomEntities. Entity name = ', self:GetName())
	local abilities = {}

	for i = 0, 8 do
		local ability = self:GetAbilityByIndex(i)
		table.insert(abilities, {
			name = ability:GetName(),
			level = ability:GetLevel(),
		})
	end

	return abilities
end

function CDOTA_BaseNPC:GiveEnergy(iEnergy, bInformClient)
	print('WARNING: USING CDOTA_BaseNPC_Hero:GiveEnergy instead of CustomEntities. Entity name = ', self:GetName())
	self:SetEnergy(self:GetEnergy() + iEnergy, bInformClient)
end

function CDOTA_BaseNPC:SetEnergy(iEnergy, bInformClient)
	print('WARNING: USING CDOTA_BaseNPC_Hero:SetEnergy instead of CustomEntities. Entity name = ', self:GetName())
	self.energy = Clamp(iEnergy, self:GetMaxEnergy(), 0)

	if bInformClient then
		self:SendDataToClient()
	end
end

function CDOTA_BaseNPC:GetEnergy()
	print('WARNING: USING CDOTA_BaseNPC_Hero:GetEnergy instead of CustomEntities. Entity name = ', self:GetName())
	return self.energy
end

function CDOTA_BaseNPC:GetMaxEnergy()
	print('WARNING: USING CDOTA_BaseNPC_Hero:GetMaxEnergy instead of CustomEntities. Entity name = ', self:GetName())
	return self.max_energy
end


-- Setters
function CDOTA_BaseNPC:SetInitialized(initialized)	
	print('WARNING: USING CDOTA_BaseNPC_Hero:SetInitialized instead of CustomEntities. Entity name = ', self:GetName())
	self.initialized = initialized
end

function CDOTA_BaseNPC:SetTreshold(treshold)
	print('WARNING: USING CDOTA_BaseNPC_Hero:SetTreshold instead of CustomEntities. Entity name = ', self:GetName())	
	self.treshold = treshold
end

function CDOTA_BaseNPC_Hero:SetTreshold(treshold)	
	print('WARNING: USING CDOTA_BaseNPC_Hero:SetTreshold instead of CustomEntities. Entity name = ', self:GetName())
	self.treshold = treshold
	self:SendDataToClient()
end

function CDOTA_BaseNPC:SetDirection(x, y)
	print('WARNING: USING CDOTA_BaseNPC_Hero:SetDirection instead of CustomEntities. Entity name = ', self:GetName())
	local current_direction = self:GetRawDirection()
	local m_x = x or current_direction.x
	local m_y = y or current_direction.y 
	self.direction = Vector(m_x, m_y, self:GetForwardVector().z)
end
