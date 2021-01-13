CustomEntities = class({})

MODIFIER_DISPLACEMENT = 1
MODIFIER_COUNTER = 2
MODIFIER_REFLECT = 3
MODIFIER_ANIMATION = 4
MODIFIER_CHANNELING = 5 
MODIFIER_CHARGES = 6 
MODIFIER_TRANSLATE = 7 
MODIFIER_ON_PROJECTILE_HIT = 8 
MODIFIER_MOVE_FORCE = 9
MODIFIER_BANISHED = 10
MODIFIER_SHIELD = 11

function CustomEntities:Initialize(hEntity)
	hEntity.on_basic_attack_impact = 	    {}
	hEntity.treshold = 				        0
	hEntity.energy = 					    0
	hEntity.max_energy = 				    100
	hEntity.healing_reduction_pct = 		0
	hEntity.initialized = 					nil

	hEntity.charges_modifiers =		        {}
	hEntity.displacement_modifiers = 	    {}
	hEntity.reflect_modifiers = 		    {}
	hEntity.counter_modifiers = 		    {}
	hEntity.animation_modifiers = 		    {}
	hEntity.channeling_modifiers = 	        {}
	hEntity.status_modifiers =			    {}
	hEntity.fear_modifiers =			    {}
	hEntity.translate_modifiers = 		    {}
	hEntity.move_force_modifiers =  	    {}
	hEntity.banished_modifiers =			{}
	hEntity.on_projectile_hit_modifiers =   {}
	hEntity.shield_modifiers =   			{}
	
	CustomEntities:SetEnergy(hEntity, hEntity.max_energy)	
    CustomEntities:SetTreshold(hEntity, GameRules.GameMode.max_treshold)
    
	hEntity:AddNewModifier(hEntity,  nil, "modifier_visible", {})
	GameRules.GameMode:RegisterUnit(hEntity)

	if hEntity:IsRealHero() then
		hEntity.direction = 					{}
		hEntity.recast_modifiers =				{}
		hEntity.on_projectile_hit_modifiers = 	{}
		hEntity.stackbars_modifier =			nil
		hEntity.charges_modifier =				nil
		hEntity.cooldown_modifier =				nil
		hEntity.collision_direction = 			-1
	
		CustomEntities:SetDirection(hEntity, 0, 0)
		hEntity:AddNewModifier(hEntity,  nil, "modifier_hero_base", {})
	
		for i = 0, 23 do
			local ability = hEntity:GetAbilityByIndex(i)
			if ability then
				if ability:GetAbilityType() ~= 2 then -- To not level up the talents
					ability:SetLevel(1)
				end
			end
		end
	
		hEntity:SetAbilityPoints(ABILITY_POINTS)
		ConstructHero(hEntity)
	end

	CustomEntities:SetInitialized(hEntity, true)
end

function CustomEntities:IsInitialized(hEntity)
	return 	hEntity.initialized
end

function CustomEntities:SetInitialized(hEntity, bInitialized)	
	hEntity.initialized = bInitialized
end

function CustomEntities:SetDirection(hEntity, fX, fY)
	local current_direction = CustomEntities:GetRawDirection(hEntity)
	local m_x = fX or current_direction.x
	local m_y = fY or current_direction.y 
	hEntity.direction = Vector(m_x, m_y, hEntity:GetForwardVector().z)
end

function CustomEntities:GetRawDirection(hEntity)
	return hEntity.direction
end

function CustomEntities:SetEnergy(hEntity, iEnergy, bInformClient)
	hEntity.energy = Clamp(iEnergy, CustomEntities:GetMaxEnergy(hEntity), 0)

	if bInformClient then
		CustomEntities:SendDataToClient(hEntity)
	end
end

function CustomEntities:GetMaxEnergy(hEntity)
	return hEntity.max_energy
end

function CustomEntities:SetTreshold(hEntity, iTreshold)	
	hEntity.treshold = iTreshold
	CustomEntities:SendDataToClient(hEntity)
end

function CustomEntities:SendDataToClient(hEntity)
	if hEntity:IsRealHero() then
		if hEntity:IsIllusion() then
			return
		end
	
		local allianceName = "NOT_ALLIANCE"
	
		if CustomEntities:GetAlliance(hEntity) then
			allianceName = CustomEntities:GetAlliance(hEntity):GetName() 
		end

		local data = {
			entityIndex = hEntity:GetEntityIndex(),
			teamId = hEntity:GetTeam(),
			playerId = hEntity:GetPlayerOwnerID(),
			allianceName = allianceName,
			name = hEntity:GetName(),
			health = hEntity:GetHealth(),
			maxHealth = hEntity:GetMaxHealth(),
			treshold = CustomEntities:GetTreshold(hEntity),
			shield = CustomEntities:GetShield(hEntity),
			mana = hEntity:GetMana(),
			maxMana = hEntity:GetMaxMana(),
			status = CustomEntities:GetStatus(hEntity),
			recast = CustomEntities:GetRecast(hEntity),
			stackbars = CustomEntities:GetStackbars(hEntity),
			charges = CustomEntities:GetCharges(hEntity),
			cooldown = CustomEntities:GetCooldown(hEntity),
			abilities = CustomEntities:GetAbilities(hEntity),
			energy = CustomEntities:GetEnergy(hEntity),
			maxEnergy = CustomEntities:GetMaxEnergy(hEntity),
		}
		CustomNetTables:SetTableValue("heroes", tostring(hEntity:GetPlayerID()), data)
	else
		--print('SendDataToClient: Not implemented yet for non hero units. Please come back later')
	end
end

function CustomEntities:GetAlliance(hEntity)
	local playerID = hEntity:GetPlayerOwnerID()

	if playerID == -1 then
		return false
	end

	local player_object = GameRules.GameMode.players[playerID]
	
	if player_object then
		return player_object.alliance
	end

	return nil
end

function CustomEntities:GetEnergy(hEntity)
	return hEntity.energy
end

function CustomEntities:GetTreshold(hEntity)
	return hEntity.treshold
end

function CustomEntities:GetShield(hEntity)
	local shield = 0

	for _,shield_modifier_name in pairs(CustomEntities:GetShields(hEntity)) do
		local shield_modifier = hEntity:FindModifierByName(shield_modifier_name)

		if shield_modifier ~= nil then
			if not shield_modifier:IsNull() then
				shield = shield + shield_modifier:GetStackCount()
			end
		end
	end

	return shield
end

function CustomEntities:GetStatus(hEntity)
	return hEntity.status_modifiers
end

function CustomEntities:GetRecast(hEntity)
	return hEntity.recast_modifiers
end

function CustomEntities:GetStackbars(hEntity)
	return hEntity.stackbars_modifier
end

function CustomEntities:GetCharges(hEntity)
	return hEntity.charges_modifier
end

function CustomEntities:GetCooldown(hEntity)
	return hEntity.cooldown_modifier
end

function CustomEntities:GetTranslate(hEntity)
	return hEntity.translate_modifiers
end

function CustomEntities:GetOnProjectileHit(hEntity)
	return hEntity.on_projectile_hit_modifiers
end

function CustomEntities:GetShields(hEntity)
	return hEntity.shield_modifiers
end

function CustomEntities:GetAbilities(hEntity)
	local abilities = {}

	for i = 0, 8 do
		local ability = hEntity:GetAbilityByIndex(i)
		table.insert(abilities, {
			name = ability:GetName(),
			level = ability:GetLevel(),
		})
	end

	return abilities
end

function CustomEntities:GiveManaCustom(hEntity, fMana, bInformClient, bShowOverhead)
	if hEntity:HasModifier("modifier_sapphire") then
		fMana = fMana * 2
	end

	hEntity:GiveMana(fMana)

	if bInformClient then
		CustomEntities:SendDataToClient(hEntity)
	end
	if bShowOverhead then
		SendOverheadManaMessage(hEntity, fMana)
	end
end

function CustomEntities:GiveManaPercent(hEntity, iPercentage, bInformClient, bShowOverhead)
	local mana = hEntity:GetMaxMana() * iPercentage/100
	CustomEntities:GiveManaCustom(hEntity, mana, bInformClient, bShowOverhead)
end

function CustomEntities:GiveEnergyPercent(hEntity, iPercentage, bInformClient, bShowOverhead)
	local energy = CustomEntities:GetMaxEnergy(hEntity) * iPercentage/100
	CustomEntities:GiveEnergy(hEntity, energy, bInformClient, bShowOverhead)
end

function CustomEntities:GiveEnergy(hEntity, iEnergy, bInformClient, bShowOverhead)
	CustomEntities:SetEnergy(hEntity, CustomEntities:GetEnergy(hEntity) + iEnergy, bInformClient)

	if bShowOverhead then
		SendOverheadEnergyMessage(hEntity, iEnergy)
	end
end

function CustomEntities:GiveManaAndEnergyPercent(hEntity, iPercentage, bInformClient, bShowOverhead)
	CustomEntities:GiveManaPercent(hEntity, iPercentage, false, bShowOverhead)
	CustomEntities:GiveEnergyPercent(hEntity, iPercentage, false, bShowOverhead)
	if bInformClient then
		CustomEntities:SendDataToClient(hEntity)
	end
end

function CustomEntities:GiveManaAndEnergy(hEntity, fAmount, bInformClient, bShowOverhead)
	CustomEntities:GiveEnergy(hEntity, fAmount, false, bShowOverhead)
	CustomEntities:GiveManaCustom(hEntity, fAmount, false, bShowOverhead)
	if bInformClient then
		CustomEntities:SendDataToClient(hEntity)
	end
end

function CustomEntities:SetHealthCustom(hEntity, fHealth)
	hEntity:SetHealth(fHealth)
	CustomEntities:SendDataToClient(hEntity)
	
	local alliance = CustomEntities:GetAlliance(hEntity)
	if alliance then
		alliance:SendDataToClient()
	end
end 

function CustomEntities:SetManaCustom(hEntity, fMana, bInformClient)
	hEntity:SetMana(fMana)
	if bInformClient then
		CustomEntities:SendDataToClient(hEntity)
	end
end

function CustomEntities:Reset(hEntity)
	if not IsInToolsMode() then
		CustomEntities:SetManaCustom(hEntity, 0, true)
		CustomEntities:SetEnergy(hEntity, 0)
	end
	CustomEntities:SetHealthCustom(hEntity, hEntity:GetMaxHealth())
	CustomEntities:SetTreshold(hEntity, GameRules.GameMode.max_treshold)

	for i = 0, 23 do
		local ability = hEntity:GetAbilityByIndex(i)
		if ability then
			ability:EndCooldown()
			if ability:GetToggleState() then
				ability:ToggleAbility()
			end
		end
	end

	for _,modifier_name in pairs(hEntity.charges_modifiers) do
		local modifier = hEntity:FindModifierByName(modifier_name)
		if modifier then
			modifier:RefreshCharges()
		end
	end

	CustomEntities:InterruptCastPoint(hEntity)
	hEntity:Purge(true, true, false, true, false)
end

function CustomEntities:AddModifierTracker(hEntity, sName, iType) 	
	local key = nil

	if iType == MODIFIER_DISPLACEMENT then key = "displacement_modifiers" end
	if iType == MODIFIER_COUNTER then key = "counter_modifiers" end
	if iType == MODIFIER_REFLECT then key = "reflect_modifiers" end
	if iType == MODIFIER_ANIMATION then key = "animation_modifiers" end
	if iType == MODIFIER_CHANNELING then key = "channeling_modifiers" end
	if iType == MODIFIER_CHARGES then key = "charges_modifiers" end
	if iType == MODIFIER_FEAR then key = "fear_modifiers" end
	if iType == MODIFIER_TRANSLATE then key = "translate_modifiers" end
	if iType == MODIFIER_ON_PROJECTILE_HIT then key = "on_projectile_hit_modifiers" end
	if iType == MODIFIER_MOVE_FORCE then key = "move_force_modifiers" end
	if iType == MODIFIER_BANISHED then key = "banished_modifiers" end
	if iType == MODIFIER_SHIELD then key = "shield_modifiers" end
	
	table.insert(hEntity[key], sName)
end

function CustomEntities:RemoveModifierTracker(hEntity, sName, iType)
	local key = nil
	
	if iType  == MODIFIER_DISPLACEMENT then key = "displacement_modifiers" end
	if iType  == MODIFIER_COUNTER then key = "counter_modifiers" end
	if iType  == MODIFIER_REFLECT then key = "reflect_modifiers" end
	if iType  == MODIFIER_ANIMATION then key = "animation_modifiers" end
	if iType  == MODIFIER_CHANNELING then key = "channeling_modifiers" end
	if iType  == MODIFIER_CHARGES then key = "charges_modifiers" end
	if iType  == MODIFIER_FEAR then key = "fear_modifiers" end
	if iType  == MODIFIER_TRANSLATE then key = "translate_modifiers" end
	if iType  == MODIFIER_ON_PROJECTILE_HIT then key = "on_projectile_hit_modifiers" end
	if iType  == MODIFIER_MOVE_FORCE then key = "move_force_modifiers" end
	if iType  == MODIFIER_BANISHED then key = "banished_modifiers" end
	if iType  == MODIFIER_SHIELD then key = "shield_modifiers" end

	for _,m_data in pairs(hEntity[key]) do
		if m_data == sName then
			hEntity[key][_] = nil
		end
	end
end

function CustomEntities:GetDirection(hEntity)
	if CustomEntities:IsFeared(hEntity) then
		local fear_modifier_name = hEntity.fear_modifiers[1]
		local fear_origin = hEntity:FindModifierByName(fear_modifier_name):GetAbsOrigin()
		local direction = (fear_origin - hEntity:GetAbsOrigin()):Normalized()
		
		return direction * -1
	end

	if CustomEntities:IsMoveForced(hEntity) then
		if hEntity.direction.x == 0 and hEntity.direction.y == 0 then 
			local forward_vector = hEntity:GetForwardVector()
			return Vector(forward_vector.x, forward_vector.y)
		end	
	end
	return hEntity.direction
end

function CustomEntities:IsBanished(hEntity)
	return hEntity.banished_modifiers and #hEntity.banished_modifiers > 0
end

function CustomEntities:IsFeared(hEntity)
	return hEntity.fear_modifiers and #hEntity.fear_modifiers > 0
end

function CustomEntities:IsMoveForced(hEntity)
	return hEntity.move_force_modifiers and #hEntity.move_force_modifiers > 0
end

function CustomEntities:IsAnimating(hEntity)
	return hEntity.animation_modifiers and #hEntity.animation_modifiers > 0
end

function CustomEntities:IsCountering(hEntity)
	if hEntity.counter_modifiers and #hEntity.counter_modifiers > 0 then
		return true
	end

	return 	hEntity:HasModifier("modifier_counter")
end

function CustomEntities:FakeMissAttack(hEntity, vOrigin)
	local origin = vOrigin and vOrigin or hEntity:GetAbsOrigin()
	local dummy = CreateModifierThinker(hEntity, nil, nil, {}, origin, hEntity:GetTeamNumber(), false)
	dummy:AddNewModifier(hEntity, nil, "modifier_miss", {})
	hEntity:PerformAttack(dummy, false, false, true, true, false, false, false)
	dummy:RemoveSelf()
end

function CustomEntities:FullyFaceTowards(hEntity, vDirection)
	if CustomEntities:IsDisplacing(hEntity) then
		return
	end
	hEntity:SetForwardVector(vDirection)
	hEntity:FaceTowards(hEntity:GetAbsOrigin() + vDirection)
end

function CustomEntities:IsDisplacing(hEntity)
	return hEntity.displacement_modifiers and #hEntity.displacement_modifiers > 0
end

function CustomEntities:CanWalk(hEntity)
	return not (hEntity:IsStunned() or 
	hEntity:IsCommandRestricted() or 
	hEntity:IsRooted() or
	hEntity:IsNightmared() or
	not hEntity:IsAlive())
end

function CustomEntities:StrongPurge(hEntity)
    hEntity:Purge(false, true, false, true, false)
end

function CustomEntities:AddStatus(hEntity, tData)
	local status = {
		label = tData.label or "No Label",
		modifier_name = tData.modifier_name,
		priority = tData.priority or 0,
		trigger = tData.trigger or STATUS_TRIGGER_DURATION,
		content = tData.content or STATUS_CONTENT_CLEAROUT,
		style_name = tData.style_name or "Generic",
		max_stacks = tData.max_stacks or nil,
		scope = tData.scope or STATUS_SCOPE_PUBLIC
	}
	
	hEntity.status_modifiers[status.modifier_name] = status
end

function CustomEntities:AddRecast(hEntity, tData)
	local recast = {
		key = tData.key or "NO KEY",
		modifier_name = tData.modifier_name,
		ability_name = tData.ability_name,
	}
	hEntity.recast_modifiers[recast.modifier_name] = recast
end

function CustomEntities:AddStackbars(hEntity, sModifierName)
	hEntity.stackbars_modifier = sModifierName 
end

function CustomEntities:AddCharges(hEntity, sModifierName)
	hEntity.charges_modifier = sModifierName 
end

function CustomEntities:AddCooldown(hEntity, sModifierName) 
	hEntity.cooldown_modifier = sModifierName 
end

function CustomEntities:SetCollisionDirection(hEntity, iCollisionDirection)
	if hEntity:IsRealHero() then
		hEntity.collision_direction = iCollisionDirection
	end
end

function CustomEntities:InterruptCastPoint(hEntity)
	hEntity:RemoveModifierByName("modifier_casting")
end

function CustomEntities:FindUnitsInCone(hEntity, vDirection, fMinProjection, vCenterPos, fRadius, nTeamFilter, nTypeFilter, nFlagFilter, nOrderFilter)
	local units = FindUnitsInCone(
		hEntity:GetTeamNumber(), 
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
		if nTeamFilter == DOTA_UNIT_TARGET_TEAM_FRIENDLY and CustomEntities:Allies(hEntity, unit) then
			filtered_units[counter] = unit
			counter = counter + 1
		elseif nTeamFilter == DOTA_UNIT_TARGET_TEAM_ENEMY and not CustomEntities:Allies(hEntity, unit) then
			filtered_units[counter] = unit
			counter = counter + 1
		elseif nTeamFilter == DOTA_UNIT_TARGET_TEAM_BOTH then
			filtered_units[counter] = unit
			counter = counter + 1
		end
	end
	
	return filtered_units
end

function CustomEntities:FindUnitsInRadius(hEntity, vOrigin, radius, teamFilter, typeFilter, flagFilter, orderFilter )
    local units = FindUnitsInRadius(
        hEntity:GetTeamNumber(),
        vOrigin,
        nil,
        radius,
        DOTA_UNIT_TARGET_TEAM_BOTH,
        typeFilter,
        flagFilter,
        orderFilter,
        false
	)

	local filtered_units = {}
	local counter = 1
	
	for _,unit in pairs(units) do
		if teamFilter == DOTA_UNIT_TARGET_TEAM_FRIENDLY and CustomEntities:Allies(hEntity, unit) then
			filtered_units[counter] = unit
			counter = counter + 1
		elseif teamFilter == DOTA_UNIT_TARGET_TEAM_ENEMY and not CustomEntities:Allies(hEntity, unit) then
			filtered_units[counter] = unit
			counter = counter + 1
		elseif teamFilter == DOTA_UNIT_TARGET_TEAM_BOTH then
			filtered_units[counter] = unit
			counter = counter + 1
		end
	end
	
	return filtered_units
end

function CustomEntities:FindUnitsInLine(hEntity, start_pos, end_pos, radius, teamFilter, typeFilter, flagFilter)
	local units = FindUnitsInLine(
		hEntity:GetTeamNumber(),
		start_pos,
		end_pos,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		typeFilter,
		flagFilter
	)

	local filtered_units = {}
	local counter = 1
	
	for _,unit in pairs(units) do
		if teamFilter == DOTA_UNIT_TARGET_TEAM_FRIENDLY and CustomEntities:Allies(hEntity, unit) then
			filtered_units[counter] = unit
			counter = counter + 1
		elseif teamFilter == DOTA_UNIT_TARGET_TEAM_ENEMY and not CustomEntities:Allies(hEntity, unit) then
			filtered_units[counter] = unit
			counter = counter + 1
		elseif teamFilter == DOTA_UNIT_TARGET_TEAM_BOTH then
			filtered_units[counter] = unit
			counter = counter + 1
		end
	end
	
	return filtered_units
end


function CustomEntities:Allies(hEntity, hTarget)
	local playerID = hEntity:GetPlayerOwnerID()
	local playerID_test = hTarget:GetPlayerOwnerID()

	if playerID_test == -1 then
		return false
	end

	return CustomEntities:GetAlliance(hEntity) == CustomEntities:GetAlliance(hTarget)
end

function CustomEntities:RemoveStackbars(hEntity) 
	hEntity.stackbars_modifier = nil 
end

function CustomEntities:RemoveCharges(hEntity) 
	hEntity.charges_modifier = nil 
end

function CustomEntities:RemoveCooldown(hEntity) 
	hEntity.cooldown_modifier = nil 
end

function CustomEntities:RemoveStatus(hEntity, sModifierName)
	hEntity.status_modifiers[sModifierName] = nil
end

function CustomEntities:RemoveRecast(hEntity, sModifierName)
	hEntity.recast_modifiers[sModifierName] = nil
end

function CustomEntities:DeactivateNonPriorityAbilities(hEntity)
	if IsServer() then
		for i = 0, 10 do
			local ability = hEntity:GetAbilityByIndex(i)
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

function CustomEntities:SetAllAbilitiesActivated(hEntity, bMode)
	if IsServer() then
		for i = 0, 13 do
			hEntity:GetAbilityByIndex(i):SetActivated(bMode)
		end
	end
end

function CustomEntities:IsBarrel(hEntity)
    return hEntity:Attribute_GetIntValue("barrel", 0) == 1 and true or false
end

function CustomEntities:IsWall(hEntity)
    return hEntity:Attribute_GetIntValue("wall", 0) == 1 and true or false
end

function CustomEntities:IsObstacle(hEntity)
    return (CustomEntities:IsBarrel(hEntity) or CustomEntities:IsWall(hEntity)) and true or false
end

function CustomEntities:IsAmethyst(hEntity)
	if hEntity and hEntity.GetParentEntity then
		local entity = hEntity:GetParentEntity()

		if instanceof(entity, GenericGem) then 
			return true
		end
	end

	return false
end

function CustomEntities:ProvidesMana(hEntity)
	if CustomEntities:IsAmethyst(hEntity) then
		return false
	end

    if CustomEntities:IsObstacle(hEntity) then
        return false
	end

	return true
end

function CustomEntities:GetCollisionDirection(hEntity)
	return hEntity.collision_direction
end

function CustomEntities:SafeGetModifier(hEntity, sModifierName, hCaster)
	local modifier = nil
    if hCaster == nil then
        modifier = hEntity:FindModifierByName(sModifierName)
    else
        modifier = hEntity:FindModifierByNameAndCaster(sModifierName, hCaster)
    end

	if modifier ~= nil then
		if not modifier:IsNull() then
			return modifier
		end
	end

	return nil
end

function CustomEntities:SafeGetModifierStacks(hEntity, sModifierName, hCaster)
	local modifier = CustomEntities:SafeGetModifier(hEntity, sModifierName, hCaster)
	if modifier then
		return modifier:GetStackCount()
	end

	return 0
end

function CustomEntities:SafeDestroyModifier(hEntity, sModifierName, hCaster)
	local modifier = CustomEntities:SafeGetModifier(hEntity, sModifierName, hCaster)
	if modifier then
		modifier:Destroy()
	end
end

function CustomEntities:OnBasicAttackImpact(hEntity, hTarget)
	for _,routine in pairs(hEntity.on_basic_attack_impact) do
		if routine then
			routine.method(routine.context, hTarget)
		end
	end
end
