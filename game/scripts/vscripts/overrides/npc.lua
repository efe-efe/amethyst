

function CDOTA_BaseNPC:Initialize(data)
	self.on_basic_attack_impact = 	{}
	self.treshold = 				0

	self.charges_modifiers =		{}
	self.displacement_modifiers = 	{}
	self.reflect_modifiers = 		{}
	self.counter_modifiers = 		{}
	self.animation_modifiers = 		{}
	self.channeling_modifiers = 	{}
	self.status_modifiers =			{}
	self.fear_modifiers =			{}
	self.translate_modifiers = 		{}
	self.on_projectile_hit_modifiers = {}
	self:AddNewModifier(self,  nil, "modifier_visible", {})
	GameRules.GameMode:RegisterUnit(self)
	self:SetTreshold(GameRules.GameMode.max_treshold)
end

function CDOTA_BaseNPC_Hero:Initialize(data)
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
	self.on_projectile_hit_modifiers = {}
	self.stackbars_modifier =		nil
	self.charges_modifier =			nil
	self.cooldown_modifier =		nil
	
	self.forced_direction = 		nil
	self.treshold = 				0

	self.first_left = 				false
	self.first_right = 				false
	self.first_up = 				false
	self.first_down = 				false

	self.initialized = 				nil
	self.healing_reduction_pct = 	0

	--self:SetStashEnabled(false)	
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
	print('SendDataToClient: Not implemented yet!')
end

function CDOTA_BaseNPC_Hero:SendDataToClient()
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
	}
	CustomNetTables:SetTableValue("heroes", tostring(self:GetPlayerID()), data)
end

function CDOTA_BaseNPC:GiveManaCustom(fMana)
	self:GiveMana(fMana)
	self:SendDataToClient()
end

function CDOTA_BaseNPC:SetManaCustom(fMana)
	self:SetMana(fMana)
	self:SendDataToClient()
end

function CDOTA_BaseNPC:SetHealthCustom(fHealth)
	self:SetHealth(fHealth)
	self:SendDataToClient()
	
	local alliance = self:GetAlliance()
	if alliance then
		alliance:SendDataToClient()
	end
end 
	
function CDOTA_BaseNPC:Reset()
	if not IsInToolsMode() then
		self:SetManaCustom(0)
	end
	self:SetHealthCustom(self:GetMaxHealth())
	self:SetTreshold(GameRules.GameMode.max_treshold)

	for i = 0, 23 do
		local ability = self:GetAbilityByIndex(i)
		if ability then
			--[[if ability:GetMaxAbilityCharges() then
				ability:SetCurrentAbilityCharges(ability:GetMaxAbilityCharges())
			end]]
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
	for _,routine in pairs(self.on_basic_attack_impact) do
		if routine then
			routine.method(routine.context, hTarget)
		end
	end
end

function CDOTA_BaseNPC:OnProjectileHit(projectile, entity)
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
	self:RemoveModifierByName("modifier_casting")
end

function CDOTA_BaseNPC:HideHealthBar()
	self:AddNewModifier(self, nil, "modifier_hide_bar", {})
end

function CDOTA_BaseNPC:UnhideHealthBar()
	self:RemoveModifierByName("modifier_hide_bar")
end

function CDOTA_BaseNPC:ForceDirection(direction)
	self.forced_direction = direction
end

function CDOTA_BaseNPC:UnforceDirection(direction)
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

	local player_object = GameRules.GameMode.players[playerID]
	
	if player_object then
		return player_object.alliance
	end

	return nil
end

function CDOTA_BaseNPC:IsAlly(unit)
	local playerID = self:GetPlayerOwnerID()
	local playerID_test = unit:GetPlayerOwnerID()

	if playerID_test == -1 then
		return false
	end

	return self:GetAlliance() == unit:GetAlliance()
end

function CDOTA_BaseNPC:CanWalk()
	return not (self:IsStunned() or 
	self:IsCommandRestricted() or 
	self:IsRooted() or
	self:IsNightmared() or
	not self:IsAlive())
end

function CDOTA_BaseNPC:FindUnitsInRadius(origin, radius, teamFilter, typeFilter, flagFilter, orderFilter )
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
    return self:Attribute_GetIntValue("barrel", 0) == 1 and true or false
end

function CDOTA_BaseNPC:IsWall()
    return self:Attribute_GetIntValue("wall", 0) == 1 and true or false
end

function CDOTA_BaseNPC:IsObstacle()
    return (self:IsBarrel() or self:IsWall()) and true or false
end

function CDOTA_BaseNPC:GiveManaPercent(iPercentage, hSource)
	if (not hSource) or (hSource:ProvidesMana()) then
		local mana = self:GetMaxMana() * iPercentage/100, inform
		self:GiveManaCustom(mana)
		return mana
	end
	return false
end


function CDOTA_BaseNPC:ProvidesMana()
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

function CDOTA_BaseNPC:GiveManaPercentAndInform(iPercentage, hSource)
	local mana = self:GiveManaPercent(iPercentage, hSource)
	if mana then
		SendOverheadManaMessage(self, mana)
	end
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

function CDOTA_BaseNPC:DeactivateAllAbilitiesWithExeption(spell)
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

function CDOTA_BaseNPC:DeactivateNonPriorityAbilities()
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
	if IsServer() then
		for i = 0, 13 do
			self:GetAbilityByIndex(i):SetActivated(mode)
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
	local recast = {
		key = data.key or "NO KEY",
		modifier_name = data.modifier_name,
		ability_name = data.ability_name,
	}
	self.recast_modifiers[recast.modifier_name] = recast
end


function CDOTA_BaseNPC:AddStackbars(modifier_name) self.stackbars_modifier = modifier_name end
function CDOTA_BaseNPC:AddCharges(modifier_name) self.charges_modifier = modifier_name end
function CDOTA_BaseNPC:AddCooldown(modifier_name) self.cooldown_modifier = modifier_name end

function CDOTA_BaseNPC:RemoveStackbars() self.stackbars_modifier = nil end
function CDOTA_BaseNPC:RemoveCharges() self.charges_modifier = nil end
function CDOTA_BaseNPC:RemoveCooldown() self.cooldown_modifier = nil end

function CDOTA_BaseNPC:RemoveStatus(modifier_name)
	self.status_modifiers[modifier_name] = nil
end
function CDOTA_BaseNPC:RemoveRecast(modifier_name)
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

function CDOTA_BaseNPC:AddModifierTracker(data, type) 	
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

	table.insert(self[key], data)
end

function CDOTA_BaseNPC:RemoveModifierTracker(data, type)
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


	for _,m_data in pairs(self[key]) do
		if m_data == data then
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

function CDOTA_BaseNPC:IsFeared() 
	return self.fear_modifiers and #self.fear_modifiers > 0
end

function CDOTA_BaseNPC:IsConfused()				return 	self:HasModifier("modifier_generic_confuse") 	end
function CDOTA_BaseNPC:IsInitialized()			return 	self.initialized								end

-- Getters

function CDOTA_BaseNPC:GetDirection()
	if self:IsFeared() then
		local direction = (Vector(0,0,0) - self:GetAbsOrigin()):Normalized()
		
		return direction * -1
	end
	return self.direction
end

function CDOTA_BaseNPC:GetRawDirection()
	return self.direction
end

function CDOTA_BaseNPC:GetShield()
	local shield_modifier = self:FindModifierByName("modifier_shield")
    local shield = 0

    if shield_modifier ~= nil then
        if not shield_modifier:IsNull() then
            shield = shield_modifier:GetStackCount()
        end
	end
	
	return shield
end

function CDOTA_BaseNPC:GetTreshold()				return self.treshold						end
function CDOTA_BaseNPC:GetStatus()					return self.status_modifiers				end
function CDOTA_BaseNPC:GetStackbars()				return self.stackbars_modifier				end
function CDOTA_BaseNPC:GetCharges()					return self.charges_modifier				end
function CDOTA_BaseNPC:GetCooldown()				return self.cooldown_modifier				end
function CDOTA_BaseNPC:GetRecast()					return self.recast_modifiers				end
function CDOTA_BaseNPC:GetTranslate()				return self.translate_modifiers				end
function CDOTA_BaseNPC:GetOnProjectileHit()			return self.on_projectile_hit_modifiers		end

function CDOTA_BaseNPC:GetAbilities()
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


-- Setters
function CDOTA_BaseNPC:SetInitialized(initialized)	
	self.initialized = initialized
end

function CDOTA_BaseNPC:SetTreshold(treshold)	
	self.treshold = treshold
end

function CDOTA_BaseNPC_Hero:SetTreshold(treshold)	
	self.treshold = treshold
	self:SendDataToClient()
end

function CDOTA_BaseNPC:SetDirection(x, y)
	local current_direction = self:GetRawDirection()
	local m_x = x or current_direction.x
	local m_y = y or current_direction.y 
	self.direction = Vector(m_x, m_y, self:GetForwardVector().z)
end
