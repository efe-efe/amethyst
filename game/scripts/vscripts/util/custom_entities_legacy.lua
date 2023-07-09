CustomEntitiesLegacy = class({})

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

BEEN_HURT = 1
NOT_HURT = 0

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

function CustomEntitiesLegacy:Initialize(hEntity, bIsPVENPC)
	hEntity.threshold = 				    0
	hEntity.energy = 					    0
	hEntity.max_energy = 				    100
	hEntity.energy_per_cell = 				100
	hEntity.initialized = 					nil
	hEntity.modifiers = 					{}
	hEntity.parent =						nil
	hEntity.been_hurt =						NOT_HURT

	for key,value in pairs(MODIFIER_TYPES) do
		hEntity.modifiers[MODIFIER_OBJECT_NAMES[MODIFIER_TYPES[key]]] = {}
	end

	hEntity.stackbars_modifiers =			nil
	hEntity.charges_modifiers =				nil
	hEntity.cooldown_modifiers =			nil

    CustomEntitiesLegacy:SetThreshold(hEntity, GameRules.Addon.max_treshold)
    

	if hEntity:IsRealHero() or bIsPVENPC then
		hEntity.direction = {}
		hEntity.collision_direction = -1
	
		CustomEntitiesLegacy:SetDirection(hEntity, 0, 0)
		ConstructHero(hEntity)
	end

	if hEntity:IsRealHero() then
		hEntity.recast_modifiers = {}
	end

	CustomEntitiesLegacy:SetInitialized(hEntity, true)
end

function CustomEntitiesLegacy:SetParent(hEntity, cParent)
	hEntity.parent = cParent
end

function CustomEntitiesLegacy:GetParent(hEntity)
	return hEntity.parent
end

function CustomEntitiesLegacy:GetNormal(hEntity, vPosition, fScale)
    local m_scale = fScale or 1
    local nscale = -1 * m_scale
    local zl = GetGroundPosition(vPosition + Vector(nscale,0,0), hEntity).z
    local zr = GetGroundPosition(vPosition + Vector(scale,0,0), hEntity).z
    local zu = GetGroundPosition(vPosition + Vector(0,scale,0), hEntity).z
    local zd = GetGroundPosition(vPosition + Vector(0,nscale,0), hEntity).z
    return Vector(zl - zr, zd - zu, 2 * m_scale):Normalized()
end

function CustomEntitiesLegacy:RefreshCooldowns(hEntity)
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

function CustomEntitiesLegacy:Reset(hEntity)
	if not IsInToolsMode() then
		CustomEntitiesLegacy:SetManaCustom(hEntity, 0, true)
		CustomEntitiesLegacy:SetEnergy(hEntity, 0)
	end
	CustomEntitiesLegacy:SetHealthCustom(hEntity, hEntity:GetMaxHealth())
	CustomEntitiesLegacy:SetThreshold(hEntity, GameRules.Addon.max_treshold)
	CustomEntitiesLegacy:RefreshCooldowns(hEntity)	
	CustomEntitiesLegacy:InterruptCastPoint(hEntity)
	hEntity:Purge(true, true, false, true, false)
end

function CustomEntitiesLegacy:IsInitialized(hEntity)
	return 	hEntity.initialized
end

function CustomEntitiesLegacy:SetInitialized(hEntity, bInitialized)	
	hEntity.initialized = bInitialized
end

function CustomEntitiesLegacy:SetDirection(hEntity, fX, fY)
	local current_direction = CustomEntitiesLegacy:GetRawDirection(hEntity)
	local m_x = fX or current_direction.x
	local m_y = fY or current_direction.y 
	hEntity.direction = Vector(m_x, m_y, hEntity:GetForwardVector().z)
end

function CustomEntitiesLegacy:GetRawDirection(hEntity)
	return hEntity.direction
end

function CustomEntitiesLegacy:SetEnergy(hEntity, iEnergy, bInformClient)
	hEntity.energy = Clamp(iEnergy, CustomEntitiesLegacy:GetMaxEnergy(hEntity), 0)

	if bInformClient then
		CustomEntitiesLegacy:SendDataToClient(hEntity)
	end
end

function CustomEntitiesLegacy:GetMaxEnergy(hEntity)
	return hEntity.max_energy
end

function CustomEntitiesLegacy:SetThreshold(hEntity, iTreshold)	
	hEntity.threshold = iTreshold
	CustomEntitiesLegacy:SendDataToClient(hEntity)
end

function CustomEntitiesLegacy:SendDataToClient(hEntity)
	if hEntity:IsRealHero() then
		if hEntity:IsIllusion() then
			return
		end
	
		local allianceName = "NOT_ALLIANCE"
	
		if CustomEntitiesLegacy:GetAlliance(hEntity) then
			allianceName = CustomEntitiesLegacy:GetAlliance(hEntity):GetName() 
		end

		local data = {
			entityIndex = hEntity:GetEntityIndex(),
			teamId = hEntity:GetTeam(),
			playerId = hEntity:GetPlayerOwnerID(),
			allianceName = allianceName,
			name = hEntity:GetName(),
			health = hEntity:GetHealth(),
			maxHealth = hEntity:GetMaxHealth(),
			threshold = CustomEntitiesLegacy:GetThreshold(hEntity),
			shield = CustomEntitiesLegacy:GetShield(hEntity),
			mana = hEntity:GetMana(),
			maxMana = hEntity:GetMaxMana(),
			stackbars = CustomEntitiesLegacy:GetStackbars(hEntity),
			charges = CustomEntitiesLegacy:GetCharges(hEntity),
			cooldown = CustomEntitiesLegacy:GetCooldown(hEntity),
			abilities = CustomEntitiesLegacy:GetAbilities(hEntity),
			energy = CustomEntitiesLegacy:GetEnergy(hEntity),
			maxEnergy = CustomEntitiesLegacy:GetMaxEnergy(hEntity),
			energyPerCell = CustomEntitiesLegacy:GetEnergyPerCell(hEntity),
		}
		CustomNetTables:SetTableValue('units', tostring(hEntity:GetPlayerID()), data)
	else
		if hEntity:IsIllusion() then
			return
		end

		local data = {
			playerId = nil,
			entityIndex = hEntity:GetEntityIndex(),
			teamId = hEntity:GetTeam(),
			health = hEntity:GetHealth(),
			maxHealth = hEntity:GetMaxHealth(),
			shield = CustomEntitiesLegacy:GetShield(hEntity),
			status = CustomEntitiesLegacy:GetStatus(hEntity),
			beenHurt = CustomEntitiesLegacy:GetBeenHurt(hEntity),
		}
		CustomNetTables:SetTableValue('units', tostring('_' .. hEntity:GetEntityIndex()), data)
	end
end

function CustomEntitiesLegacy:GetBeenHurt(hEntity)
	return hEntity.been_hurt
end

function CustomEntitiesLegacy:SetBeenHurt(hEntity, bBeenHurt)
	if bBeenHurt then
		hEntity.been_hurt = BEEN_HURT

	else
		hEntity.been_hurt = NOT_HURT
	end

	CustomEntitiesLegacy:SendDataToClient(hEntity)
end

function CustomEntitiesLegacy:AutoUpgradeAbilities(hEntity)
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

function CustomEntitiesLegacy:GetEnergyPerCell(hEntity)
	return hEntity.energy_per_cell
end

function CustomEntitiesLegacy:SetEnergyPerCell(hEntity, iEnergy)
	hEntity.energy_per_cell = iEnergy
end

function CustomEntitiesLegacy:GetAlliance(hEntity)
	if not hEntity then
		return GameRules.Addon.alliances["0"]
	end
	local playerID = hEntity:GetPlayerOwnerID()

	if playerID == -1 then
		return false
	end

	local player_object = GameRules.Addon:FindPlayerById(playerID)
	
	if player_object then
		return player_object.alliance
	end

	return nil
end

function CustomEntitiesLegacy:GetEnergy(hEntity)
	return hEntity.energy
end

function CustomEntitiesLegacy:GetThreshold(hEntity)
	return hEntity.threshold
end

function CustomEntitiesLegacy:GetAllModifiersWithType(hEntity, iType)
	return hEntity.modifiers[MODIFIER_OBJECT_NAMES[iType]]
end

function CustomEntitiesLegacy:GetShield(hEntity)
	local shield = 0

	for key, value in pairs(CustomEntitiesLegacy:GetAllModifiersWithType(hEntity, MODIFIER_TYPES.SHIELD)) do
		local hModifier = hEntity:FindModifierByName(value)

		if hModifier ~= nil then
			if not hModifier:IsNull() then
				shield = shield + hModifier:GetStackCount()
			end
		end
	end

	return shield
end

function CustomEntitiesLegacy:GetStatus(hEntity)
	local status = {} 
	
	for key, value in pairs(CustomEntitiesLegacy:GetAllModifiersWithType(hEntity, MODIFIER_TYPES.STATUS)) do
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

function CustomEntitiesLegacy:GetRecast(hEntity)
	local recast = {} 
	
	for key, value in pairs(CustomEntitiesLegacy:GetAllModifiersWithType(hEntity, MODIFIER_TYPES.RECAST)) do
		local hModifier = hEntity:FindModifierByName(value)
		recast[value] = hModifier:GetRecastData()

	end

	return recast
end

function CustomEntitiesLegacy:GetStackbars(hEntity)
	return hEntity.stackbars_modifiers
end

function CustomEntitiesLegacy:GetCharges(hEntity)
	return hEntity.charges_modifiers
end

function CustomEntitiesLegacy:GetCooldown(hEntity)
	return hEntity.cooldown_modifiers
end

function CustomEntitiesLegacy:GetAbilities(hEntity)
	local abilities = {}

	for i = 0, 8 do
		local ability = hEntity:GetAbilityByIndex(i)
		if ability then
			table.insert(abilities, {
				name = ability:GetName(),
				level = ability:GetLevel(),
			})
		end
	end

	return abilities
end

function CustomEntitiesLegacy:SetHealthCustom(hEntity, fHealth)
	hEntity:SetHealth(fHealth)
	CustomEntitiesLegacy:SendDataToClient(hEntity)
	
	local alliance = CustomEntitiesLegacy:GetAlliance(hEntity)
	if alliance then
		alliance:SendDataToClient()
	end
end 

function CustomEntitiesLegacy:SetManaCustom(hEntity, fMana, bInformClient)
	hEntity:SetMana(fMana)
	if bInformClient then
		CustomEntitiesLegacy:SendDataToClient(hEntity)
	end
end


function CustomEntitiesLegacy:AddModifierTracker(hEntity, sName, iType)
	table.insert(hEntity.modifiers[MODIFIER_OBJECT_NAMES[iType]], sName)
end

function CustomEntitiesLegacy:RemoveModifierTracker(hEntity, sName, iType)
	for key, value in pairs(hEntity.modifiers[MODIFIER_OBJECT_NAMES[iType]]) do
		if value == sName then
			hEntity.modifiers[MODIFIER_OBJECT_NAMES[iType]][key] = nil
		end
	end
end

function CustomEntitiesLegacy:GetDirection(hEntity)
	if CustomEntitiesLegacy:IsFeared(hEntity) then
		local fear_modifier_name = CustomEntitiesLegacy:GetAllModifiersWithType(hEntity, MODIFIER_TYPES.FEAR)[1]
		local fear_origin = hEntity:FindModifierByName(fear_modifier_name):GetAbsOrigin()
		local direction = (fear_origin - hEntity:GetAbsOrigin()):Normalized()
		
		return direction * -1
	end

	if CustomEntitiesLegacy:IsMoveForced(hEntity) then
		if hEntity.direction.x == 0 and hEntity.direction.y == 0 then 
			local forward_vector = hEntity:GetForwardVector()
			return Vector(forward_vector.x, forward_vector.y)
		end	
	end
	return hEntity.direction
end

function CustomEntitiesLegacy:IsFeared(hEntity)
	return CustomEntitiesLegacy:HasModifiersFromType(hEntity, MODIFIER_TYPES.FEAR)
end

function CustomEntitiesLegacy:IsChanneling(hEntity)
	return CustomEntitiesLegacy:HasModifiersFromType(hEntity, MODIFIER_TYPES.CHANNELING)
end

function CustomEntitiesLegacy:IsMoveForced(hEntity)
	return CustomEntitiesLegacy:HasModifiersFromType(hEntity, MODIFIER_TYPES.MOVE_FORCE)
end

function CustomEntitiesLegacy:IsAnimating(hEntity)
	return CustomEntitiesLegacy:HasModifiersFromType(hEntity, MODIFIER_TYPES.ANIMATION)
end

function CustomEntitiesLegacy:IsCountering(hEntity)
	if CustomEntitiesLegacy:HasModifiersFromType(hEntity, MODIFIER_TYPES.COUNTER) then
		return true
	end
end

function CustomEntitiesLegacy:HasModifiersFromType(hEntity, iType)
	local tModifiers = CustomEntitiesLegacy:GetAllModifiersWithType(hEntity, iType)
	return tModifiers and #tModifiers > 0
end

function CustomEntitiesLegacy:IsDisplacing(hEntity)
	return CustomEntitiesLegacy:HasModifiersFromType(hEntity, MODIFIER_TYPES.DISPLACEMENT)
end

function CustomEntitiesLegacy:IsCasting(hEntity)
	return hEntity:HasModifier('modifier_casting')
end

function CustomEntitiesLegacy:CanWalk(hEntity)
	return not (hEntity:IsStunned() or 
	hEntity:IsCommandRestricted() or 
	hEntity:IsRooted() or
	hEntity:IsNightmared() or
	not hEntity:IsAlive())
end

function CustomEntitiesLegacy:StrongPurge(hEntity)
    hEntity:Purge(false, true, false, true, false)
end

function CustomEntitiesLegacy:AddStatus(hEntity, tData)
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

function CustomEntitiesLegacy:AddRecast(hEntity, tData)
	local recast = {
		key = tData.key or "NO KEY",
		modifier_name = tData.modifier_name,
		ability_name = tData.ability_name,
	}
	hEntity.recast_modifiers[recast.modifier_name] = recast
end

function CustomEntitiesLegacy:AddStackbars(hEntity, sModifierName)
	hEntity.stackbars_modifiers = sModifierName 
end

function CustomEntitiesLegacy:AddCharges(hEntity, sModifierName)
	hEntity.charges_modifiers = sModifierName 
end

function CustomEntitiesLegacy:AddCooldown(hEntity, sModifierName) 
	hEntity.cooldown_modifiers = sModifierName 
end

function CustomEntitiesLegacy:SetCollisionDirection(hEntity, iCollisionDirection)
	if hEntity:IsRealHero() then
		hEntity.collision_direction = iCollisionDirection
	end
end

function CustomEntitiesLegacy:InterruptCastPoint(hEntity)
	hEntity:RemoveModifierByName("modifier_casting")
end

function CustomEntitiesLegacy:DeactivateNonPriorityAbilities(hEntity)
	if IsServer() then
		for i = 0, 10 do
			local ability = hEntity:GetAbilityByIndex(i)
			
			if ability then
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
end

function CustomEntitiesLegacy:SetAllAbilitiesActivated(hEntity, bMode)
	if IsServer() then
		for i = 0, 13 do
			local ability = hEntity:GetAbilityByIndex(i)
			if ability then
				hEntity:GetAbilityByIndex(i):SetActivated(bMode)
			end
		end
	end
end

function CustomEntitiesLegacy:GetCollisionDirection(hEntity)
	return hEntity.collision_direction
end

function CustomEntitiesLegacy:SafeGetModifier(hEntity, sModifierName, hCaster)
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

function CustomEntitiesLegacy:TrueHeal(hEntity, iHeal)
	local base_health = hEntity:GetHealth()
    CustomEntitiesLegacy:SetHealthCustom(hEntity, base_health + iHeal)

    local new_treshold = CustomEntitiesLegacy:GetThreshold(hEntity) + iHeal
	if new_treshold > GameRules.Addon.max_treshold then
		CustomEntitiesLegacy:SetThreshold(hEntity, GameRules.Addon.max_treshold)
	else
		CustomEntitiesLegacy:SetThreshold(hEntity, new_treshold)
    end

	if hEntity:GetHealth() < hEntity:GetMaxHealth() then
		SendOverheadHealMessage(hEntity, iHeal)
	end
end

function CustomEntitiesLegacy:GetMeeleExtraRadius(hEntity)
	local modifier = CustomEntitiesLegacy:SafeGetModifier(hEntity, "modifier_upgrade_item_broom_handle")

	if modifier then
		return modifier:GetExtraRadius()
	end
	
	return 0
end

function CustomEntitiesLegacy:HideHealthBar(hEntity)
	hEntity:AddNewModifier(hEntity, nil, "modifier_hide_bar", {})
end

function CustomEntitiesLegacy:UnhideHealthBar(hEntity)
	hEntity:RemoveModifierByName("modifier_hide_bar")
end