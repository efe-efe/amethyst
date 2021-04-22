CustomAbilities = class({})

function CustomAbilities:GetCursorPosition(hAbility)
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

function CustomAbilities:IsNotTalentNorAttribute(hAbility)
	return (hAbility:GetAbilityType() ~= 2 and hAbility:GetName() ~= "special_bonus_attributes")
end

function CustomAbilities:GetEnergyCost(hAbility)
	return CustomAbilities:GetValueFromKV(hAbility, "AbilityEnergyCost") and CustomAbilities:GetValueFromKV(hAbility, "AbilityEnergyCost")  or 0
end

function CustomAbilities:GetValueFromKV(hAbility, sKey)
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

function CustomAbilities:HasBehavior(hAbility, nBehavior)
	local abilityBehavior = tonumber(tostring(hAbility:GetBehavior()))
	return bit.band(abilityBehavior, nBehavior) == nBehavior
end