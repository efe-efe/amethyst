CustomAbilitiesLegacy = class({})


function CustomAbilitiesLegacy:LinkUpgrades(hAbility, sLinkedAbilityName)
    local caster = hAbility:GetCaster()
    local linkedAbility = caster:FindAbilityByName(sLinkedAbilityName)
    if linkedAbility:GetLevel() == 0 then
        linkedAbility:UpgradeAbility(true)
    end
end

function CustomAbilitiesLegacy:GetCursorPosition(hAbility)
	local caster = hAbility:GetCaster();
	local playerId = caster:GetPlayerOwnerID();

	if IsInToolsMode() then
		playerId = Entities:GetLocalPlayer():GetPlayerID();
	end

	if not playerId then
		return Vector(0, 0, 0)
	end

	local position = GameRules.Addon:GetCursorPositionForPlayer(playerId)
	return position
end

function CustomAbilitiesLegacy:IsNotTalentNorAttribute(hAbility)
	return (hAbility:GetAbilityType() ~= 2 and hAbility:GetName() ~= "special_bonus_attributes")
end

function CustomAbilitiesLegacy:GetEnergyCost(hAbility)
	return CustomAbilitiesLegacy:GetValueFromKV(hAbility, "AbilityEnergyCost") and CustomAbilitiesLegacy:GetValueFromKV(hAbility, "AbilityEnergyCost")  or 0
end

function CustomAbilitiesLegacy:GetValueFromKV(hAbility, sKey)
	local ability_key_values = hAbility:GetAbilityKeyValues()
	local value = nil

	if ability_key_values then
		local m_value = ability_key_values[sKey]

		if m_value then
			if type(m_value) == 'number' then
				value = m_value
			else
				value = tonumber(string.split(m_value, ' ')[hAbility:GetLevel()])
			end
		end
	end

	return value
end

function CustomAbilitiesLegacy:HasBehavior(hAbility, nBehavior)
	local abilityBehavior = tonumber(tostring(hAbility:GetBehavior()))
	return bit.band(abilityBehavior, nBehavior) == nBehavior
end