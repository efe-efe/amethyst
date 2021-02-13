CustomEntities = class({})

PROJECTILE_HIT = 0
MEELE_HIT = 1
AOE_HIT = 2
SINGLE_HIT = 3

MODIFIER_TYPES = {
	PRE_ATTACK_DAMAGE = 0,
	DISPLACEMENT = 1,
	COUNTER = 2,
	ANIMATION = 3,
	CHANNELING = 4,
	CHARGES = 5,
	FEAR = 6,
	TRANSLATE = 7,
	ON_HIT = 8,
	ON_EVENT = 9,
	MOVE_FORCE = 10,
	BANISHED = 11,
	SHIELD = 12,
	STATUS = 13,
	RECAST = 14,
}

MODIFIER_OBJECT_NAMES = {}
for key,value in pairs(MODIFIER_TYPES) do
	MODIFIER_OBJECT_NAMES[MODIFIER_TYPES[key]] = string.lower(key) .. '_modifiers'
end

MODIFIER_EVENTS = {
	ON_BASIC_ATTACK_STARTED = 0,
	ON_BASIC_ATTACK_LANDED = 1,
	ON_BASIC_ATTACK_MISSED = 2,
	ON_BASIC_ATTACK_ENDED = 3,
}

function CustomEntities:Initialize(hEntity)
	hEntity.treshold = 				        0
	hEntity.energy = 					    0
	hEntity.max_energy = 				    100
	hEntity.energy_per_cell = 				100
	hEntity.healing_reduction_pct = 		0
	hEntity.initialized = 					nil
	hEntity.modifiers = 					{}

	for key,value in pairs(MODIFIER_TYPES) do
		hEntity.modifiers[MODIFIER_OBJECT_NAMES[MODIFIER_TYPES[key]]] = {}
	end

	hEntity.stackbars_modifiers =			nil
	hEntity.charges_modifiers =				nil
	hEntity.cooldown_modifiers =			nil
	
	CustomEntities:SetEnergy(hEntity, hEntity.max_energy)	
    CustomEntities:SetTreshold(hEntity, GameRules.GameMode.max_treshold)
    
	hEntity:AddNewModifier(hEntity,  nil, "modifier_visible", {})
	GameRules.GameMode:RegisterUnit(hEntity)

	if hEntity:IsRealHero() then
		hEntity.direction = 					{}
		hEntity.recast_modifiers =				{}
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

function CustomEntities:RefreshCooldowns(hEntity)
	for i = 0, 23 do
		local hAbility = hEntity:GetAbilityByIndex(i)
		if hAbility then
			hAbility:EndCooldown()
			if hAbility:GetToggleState() then
				hAbility:ToggleAbility()
			end
		end
	end

	for _,sModifierName in pairs(hEntity.modifiers[MODIFIER_OBJECT_NAMES[MODIFIER_TYPES.CHARGES]]) do
		local hModifier = hEntity:FindModifierByName(sModifierName)
		if hModifier then
			hModifier:RefreshCharges()
		end
	end
end

function CustomEntities:Reset(hEntity)
	if not IsInToolsMode() then
		CustomEntities:SetManaCustom(hEntity, 0, true)
		CustomEntities:SetEnergy(hEntity, 0)
	end
	CustomEntities:SetHealthCustom(hEntity, hEntity:GetMaxHealth())
	CustomEntities:SetTreshold(hEntity, GameRules.GameMode.max_treshold)
	CustomEntities:RefreshCooldowns(hEntity)	
	CustomEntities:InterruptCastPoint(hEntity)
	hEntity:Purge(true, true, false, true, false)
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
			energyPerCell = CustomEntities:GetEnergyPerCell(hEntity)
		}
		CustomNetTables:SetTableValue("heroes", tostring(hEntity:GetPlayerID()), data)
	else
		--print('SendDataToClient: Not implemented yet for non hero units. Please come back later')
	end
end

function CustomEntities:AutoUpgradeAbilities(hEntity)
	for i = 0, 8 do
		if hEntity:GetAbilityPoints() == 0 then
			break
		end

		local ability = hEntity:GetAbilityByIndex(i)
		if ability then
			if ability:GetLevel() < ability:GetMaxLevel() then
				hEntity:UpgradeAbility(ability)
			end
		end
	end
end

function CustomEntities:GetEnergyPerCell(hEntity)
	return hEntity.energy_per_cell
end

function CustomEntities:SetEnergyPerCell(hEntity, iEnergy)
	hEntity.energy_per_cell = iEnergy
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

function CustomEntities:GetAllModifiersWithType(hEntity, iType)
	return hEntity.modifiers[MODIFIER_OBJECT_NAMES[iType]]
end

function CustomEntities:GetShield(hEntity)
	local shield = 0

	for key, value in pairs(CustomEntities:GetAllModifiersWithType(hEntity, MODIFIER_TYPES.SHIELD)) do
		local hModifier = hEntity:FindModifierByName(value)

		if hModifier ~= nil then
			if not hModifier:IsNull() then
				shield = shield + hModifier:GetStackCount()
			end
		end
	end

	return shield
end

function CustomEntities:GetStatus(hEntity)
	local status = {} 
	
	for key, value in pairs(CustomEntities:GetAllModifiersWithType(hEntity, MODIFIER_TYPES.STATUS)) do
		local hModifier = hEntity:FindModifierByName(value)

		if hModifier ~= nil then
			if not hModifier:IsNull() then
				local data = hModifier:GetStatusData() 
				if data then
					status[value] = data
				end
			end
		end
	end
	return status
end

function CustomEntities:GetRecast(hEntity)
	local recast = {} 
	
	for key, value in pairs(CustomEntities:GetAllModifiersWithType(hEntity, MODIFIER_TYPES.RECAST)) do
		local hModifier = hEntity:FindModifierByName(value)
		recast[value] = hModifier:GetRecastData()

	end

	return recast
end

function CustomEntities:GetStackbars(hEntity)
	return hEntity.stackbars_modifiers
end

function CustomEntities:GetCharges(hEntity)
	return hEntity.charges_modifiers
end

function CustomEntities:GetCooldown(hEntity)
	return hEntity.cooldown_modifiers
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


function CustomEntities:AddModifierTracker(hEntity, sName, iType)
	table.insert(hEntity.modifiers[MODIFIER_OBJECT_NAMES[iType]], sName)
end

function CustomEntities:RemoveModifierTracker(hEntity, sName, iType)
	for key, value in pairs(hEntity.modifiers[MODIFIER_OBJECT_NAMES[iType]]) do
		if value == sName then
			hEntity.modifiers[MODIFIER_OBJECT_NAMES[iType]][key] = nil
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
	return CustomEntities:HasModifiersFromType(hEntity, MODIFIER_TYPES.FEAR)
end

function CustomEntities:IsMoveForced(hEntity)
	return CustomEntities:HasModifiersFromType(hEntity, MODIFIER_TYPES.MOVE_FORCE)
end

function CustomEntities:IsAnimating(hEntity)
	return CustomEntities:HasModifiersFromType(hEntity, MODIFIER_TYPES.ANIMATION)
end

function CustomEntities:IsCountering(hEntity)
	if CustomEntities:HasModifiersFromType(hEntity, MODIFIER_TYPES.COUNTER) then
		return true
	end
end

function CustomEntities:FullyFaceTowards(hEntity, vDirection)
	if CustomEntities:IsDisplacing(hEntity) then
		return
	end
	hEntity:SetForwardVector(vDirection)
	hEntity:FaceTowards(hEntity:GetAbsOrigin() + vDirection)
end

function CustomEntities:HasModifiersFromType(hEntity, iType)
	local tModifiers = CustomEntities:GetAllModifiersWithType(hEntity, iType)
	return tModifiers and #tModifiers > 0
end

function CustomEntities:IsDisplacing(hEntity)
	return CustomEntities:HasModifiersFromType(hEntity, MODIFIER_TYPES.DISPLACEMENT)
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
	hEntity.stackbars_modifiers = sModifierName 
end

function CustomEntities:AddCharges(hEntity, sModifierName)
	hEntity.charges_modifiers = sModifierName 
end

function CustomEntities:AddCooldown(hEntity, sModifierName) 
	hEntity.cooldown_modifiers = sModifierName 
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

function CustomEntities:FindUnitsInRadius(hEntity, vOrigin, fRadius, iTeamFilter, iTypeFilter, iFlagFilter, iOrderFilter)
    local units = FindUnitsInRadius(
        hEntity:GetTeamNumber(),
        vOrigin,
        nil,
        fRadius,
        DOTA_UNIT_TARGET_TEAM_BOTH,
        iTypeFilter,
        iFlagFilter,
        iOrderFilter,
        false
	)

	local filtered_units = {}
	local counter = 1
	
	for _,unit in pairs(units) do
		if iTeamFilter == DOTA_UNIT_TARGET_TEAM_FRIENDLY and CustomEntities:Allies(hEntity, unit) then
			filtered_units[counter] = unit
			counter = counter + 1
		elseif iTeamFilter == DOTA_UNIT_TARGET_TEAM_ENEMY and not CustomEntities:Allies(hEntity, unit) then
			filtered_units[counter] = unit
			counter = counter + 1
		elseif iTeamFilter == DOTA_UNIT_TARGET_TEAM_BOTH then
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
	hEntity.stackbars_modifiers = nil 
end

function CustomEntities:RemoveCharges(hEntity) 
	hEntity.charges_modifiers = nil 
end

function CustomEntities:RemoveCooldown(hEntity) 
	hEntity.cooldown_modifiers = nil 
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

function CustomEntities:TrueHeal(hEntity, iHeal)
	local base_health = hEntity:GetHealth()
    CustomEntities:SetHealthCustom(hEntity, base_health + iHeal)

    local new_treshold = CustomEntities:GetTreshold(hEntity) + iHeal
	if new_treshold > GameRules.GameMode.max_treshold then
		CustomEntities:SetTreshold(hEntity, GameRules.GameMode.max_treshold)
	else
		CustomEntities:SetTreshold(hEntity, new_treshold)
    end

	if hEntity:GetHealth() < hEntity:GetMaxHealth() then
		SendOverheadHealMessage(hEntity, iHeal)
	end
end

function CustomEntities:EmitModifierEvent(hEntity, tData)
	for _,sModifierName in pairs(CustomEntities:GetAllModifiersWithType(hEntity, MODIFIER_TYPES.ON_EVENT)) do
		local hModifier = hEntity:FindModifierByName(sModifierName)
		hModifier:OnEvent(tData)
	end
end

function CustomEntities:ProjectileAttack(hEntity, tData)
	local bTriggerCounters = (tData.bTriggerCounters == nil) and true or tData.bTriggerCounters
	local onUnitHit = tData.tProjectile.OnUnitHit
	local onFinish = tData.tProjectile.OnFinish

	tData.tProjectile.OnUnitHit = function(hProjectile, hTarget)
		local tOnHitModifiers = CustomEntities:GetAllModifiersWithType(hTarget, MODIFIER_TYPES.ON_HIT)

		if #tOnHitModifiers > 0 then
			for _,sModifierName in pairs(tOnHitModifiers) do
				local hModifier = hTarget:FindModifierByName(sModifierName)
				local bProcessEffect = hModifier:OnHit({
					hProjectile = hProjectile,
					bTriggerCounters = bTriggerCounters, 
					iType = PROJECTILE_HIT
				})

				if bProcessEffect then
					onUnitHit(hProjectile, hTarget)
					if tData.bIsBasicAttack then
						CustomEntities:EmitModifierEvent(hEntity, { 
							iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_LANDED,
							hTarget = hTarget, 
						})
					end
				else
					hProjectile:IgnoreNextUnitBehavior()
				end
			end
		else 
			onUnitHit(hProjectile, hTarget)
			if tData.bIsBasicAttack then
				CustomEntities:EmitModifierEvent(hEntity, { 
					iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_LANDED,
					hTarget = hTarget, 
				})
			end
		end
	end

	tData.tProjectile.OnFinish = function(hProjectile, vPosition)
		if next(hProjectile.tHitLog) == nil then
			if tData.bIsBasicAttack then
				CustomEntities:EmitModifierEvent(hEntity, { iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_MISSED })
			end
		end
		
		if tData.bIsBasicAttack then
			CustomEntities:EmitModifierEvent(hEntity, { iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_ENDED })
		end

		if onFinish then
			onFinish(hProjectile, vPosition)
		end
	end
	
	local hProjectile = ProjectilesManagerInstance:CreateProjectile(tData.tProjectile)

	if tData.bIsBasicAttack then
		CustomEntities:EmitModifierEvent(hEntity, { iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_STARTED })
	end

	if tData.OnProjectileCreated then
		tData.OnProjectileCreated(hProjectile)
	end
end

function CustomEntities:MeeleAttack(hEntity, tData)
	local bTriggerCounters = (tData.bTriggerCounters == nil) and true or tData.bTriggerCounters
	local iTeamFilter = tData.iTeamFilter or DOTA_UNIT_TARGET_TEAM_ENEMY
	local iTypeFilter = tData.iTypeFilter or DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	local iFlagFilter = tData.iFlagFilter or DOTA_UNIT_TARGET_FLAG_NONE
	local iOrderFilter = tData.iOrderFilter or FIND_CLOSEST
	local iMaxTargets = tData.iMaxTargets or 1
	local bShakeOnHeroes = (tData.bShakeOnHeroes == nil and tData.bIsBasicAttack) and true or tData.bShakeOnHeroes
	local bShouldShake = false
	
	if tData.bIsBasicAttack then
		CustomEntities:EmitModifierEvent(hEntity, { iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_STARTED })
	end

	local callback = tData.Callback
	tData.Callback = function(hTarget)
		if bShakeOnHeroes and hTarget:IsRealHero() then
			bShouldShake = true
		end
		callback(hTarget)
	end

	local units = CustomEntities:FindUnitsInCone(
		hEntity,
		tData.vDirection, 
		0, 
		tData.vOrigin, 
		tData.fRadius, 
		iTeamFilter, 
		iTypeFilter, 
		iFlagFilter, 
		iOrderFilter
	)

	local iTargets = 0

	for _,unit in pairs(units) do
		local tOnHitModifiers = CustomEntities:GetAllModifiersWithType(unit, MODIFIER_TYPES.ON_HIT)

		if #tOnHitModifiers > 0 then
			for _,sModifierName in pairs(tOnHitModifiers) do
				local hModifier = unit:FindModifierByName(sModifierName)
				local bProcessEffect = hModifier:OnHit({ 
					hSource = hEntity, 
					bTriggerCounters = bTriggerCounters, 
					Callback = tData.Callback, 
					iType = MEELE_HIT
				})

				if bProcessEffect then
					tData.Callback(unit)
					if tData.bIsBasicAttack then
						CustomEntities:EmitModifierEvent(hEntity, { 
							iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_LANDED,
							hTarget = unit,
						})
					end
				end
			end
		else
			tData.Callback(unit)
			if tData.bIsBasicAttack then
				CustomEntities:EmitModifierEvent(hEntity, { 
					iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_LANDED,
					hTarget = unit,
				})
			end
		end

		iTargets = iTargets + 1

		if tData.iMaxTargets ~= -1 and tData.iMaxTargets == iTargets then
			break
		end
	end

	if iTargets == 0 then
		if tData.bIsBasicAttack then
			CustomEntities:EmitModifierEvent(hEntity, { iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_MISSED })
		end
	end
	
	if bShouldShake then
		ScreenShake(tData.vOrigin, 100, 100, 0.45, 1000, 0, true)
	end
	
	if tData.bIsBasicAttack then
		CustomEntities:EmitModifierEvent(hEntity, { iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_ENDED })
	end

	return units
end

function CustomEntities:AoeAttack(hEntity, tData)
	local bTriggerCounters = tData.bTriggerCounters
	local iTeamFilter = tData.iTeamFilter or DOTA_UNIT_TARGET_TEAM_ENEMY
	local iTypeFilter = tData.iTypeFilter or DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	local iFlagFilter = tData.iFlagFilter or DOTA_UNIT_TARGET_FLAG_NONE
	local iOrderFilter = tData.iOrderFilter or FIND_CLOSEST
	local iMaxTargets = tData.iMaxTargets or -1
	
	if tData.bIsBasicAttack then
		CustomEntities:EmitModifierEvent(hEntity, { iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_STARTED })
	end
	
	local units = CustomEntities:FindUnitsInRadius(
		hEntity,
		tData.vOrigin, 
		tData.fRadius, 
		iTeamFilter, 
		iTypeFilter, 
		iFlagFilter,
		iOrderFilter
	)

	local iTargets = 0

	for _,unit in pairs(units) do
		local tOnHitModifiers = CustomEntities:GetAllModifiersWithType(unit, MODIFIER_TYPES.ON_HIT)

		if #tOnHitModifiers > 0 then
			for _,sModifierName in pairs(tOnHitModifiers) do
				local hModifier = unit:FindModifierByName(sModifierName)
				local bProcessEffect = hModifier:OnHit({ 
					hSource = hEntity, 
					bTriggerCounters = bTriggerCounters, 
					Callback = tData.Callback, 
					iType = AOE_HIT 
				})

				if bProcessEffect then
					tData.Callback(unit)
					if tData.bIsBasicAttack then
						CustomEntities:EmitModifierEvent(hEntity, { 
							iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_LANDED,
							hTarget = unit, 
						})
					end
				end
			end
		else
			tData.Callback(unit)
			if tData.bIsBasicAttack then
				CustomEntities:EmitModifierEvent(hEntity, { 
					iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_LANDED,
					hTarget = unit, 
				})
			end
		end

		iTargets = iTargets + 1

		if tData.iMaxTargets ~= -1 and tData.iMaxTargets == iTargets then
			break
		end
	end

	if iTargets == 0 then
		if tData.bIsBasicAttack then
			CustomEntities:EmitModifierEvent(hEntity, { iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_MISSED })
		end
	end
	
	if tData.bIsBasicAttack then
		CustomEntities:EmitModifierEvent(hEntity, { iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_ENDED })
	end

	return units
end

function CustomEntities:SingleAttack(hEntity, tData)
	local bTriggerCounters = (tData.bTriggerCounters == nil) and true or tData.bTriggerCounters

	if tData.bIsBasicAttack then
		CustomEntities:EmitModifierEvent(hEntity, { iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_STARTED })
	end

	if not tData.hTarget then
		if tData.bIsBasicAttack then
			CustomEntities:EmitModifierEvent(hEntity, { iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_MISSED })
		end
	else
		local tOnHitModifiers = CustomEntities:GetAllModifiersWithType(tData.hTarget, MODIFIER_TYPES.ON_HIT)

		if #tOnHitModifiers > 0 then
			for _,sModifierName in pairs(tOnHitModifiers) do
				local hModifier = tData.hTarget:FindModifierByName(sModifierName)
				local bProcessEffect = hModifier:OnHit({ 
					hSource = hEntity, 
					bTriggerCounters = bTriggerCounters, 
					Callback = tData.Callback, 
					iType = SINGLE_HIT
				})

				if bProcessEffect then
					tData.Callback(tData.hTarget)
					if tData.bIsBasicAttack then
						CustomEntities:EmitModifierEvent(hEntity, { 
							iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_LANDED,
							hTarget = tData.hTarget,
						})
					end
				end
			end
		else
			tData.Callback(tData.hTarget)
			if tData.bIsBasicAttack then
				CustomEntities:EmitModifierEvent(hEntity, { 
					iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_LANDED,
					hTarget = tData.hTarget,
				})
			end
		end
	end
	
	CustomEntities:EmitModifierEvent(hEntity, { iEventId = MODIFIER_EVENTS.ON_BASIC_ATTACK_ENDED })
end

function CustomEntities:AttackWithBaseDamage(hEntity, tData)
	local pre_attack_damage = 0

	for key, value in pairs(CustomEntities:GetAllModifiersWithType(hEntity, MODIFIER_TYPES.PRE_ATTACK_DAMAGE)) do
		local hModifier = hEntity:FindModifierByName(value)

		if hModifier ~= nil then
			if not hModifier:IsNull() then
				pre_attack_damage = pre_attack_damage + hModifier:GetPreAttackDamage({
					victim = tData.hTarget
				})
			end
		end
	end

	local damage_table = {
		victim = tData.hTarget,
		attacker = hEntity,
		damage = hEntity:GetAverageTrueAttackDamage(tData.hTarget) + pre_attack_damage,
		damage_type = tData.iDamageType or DAMAGE_TYPE_PHYSICAL,
		ability = tData.hAbility,
	}

	ApplyDamage(damage_table)
end

function CustomEntities:HideHealthBar(hEntity)
	hEntity:AddNewModifier(hEntity, nil, "modifier_hide_bar", {})
end

function CustomEntities:UnhideHealthBar(hEntity)
	hEntity:RemoveModifierByName("modifier_hide_bar")
end