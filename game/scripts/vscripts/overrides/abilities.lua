function CDOTABaseAbility:HasBehavior(behavior)
	local abilityBehavior = tonumber(tostring(self:GetBehavior()))
	return bit.band(abilityBehavior, behavior) == behavior
end

function CDOTABaseAbility:IsBasicAttack()
	return self:IsType("basic_attack")
end

function CDOTABaseAbility:IsSecondAttack()
	return self:IsType("second_attack")
end

function CDOTABaseAbility:IsCounter()
	return self:IsType("counter")
end

function CDOTABaseAbility:IsMobility()
	return self:IsType("mobility")
end

function CDOTABaseAbility:IsSpecialAttack()
	return self:IsType("special_attack")
end

function CDOTABaseAbility:IsExtra()
	return self:IsType("extra")
end

function CDOTABaseAbility:IsUltimate()
	return self:IsType("ultimate")
end

function CDOTABaseAbility:HasPriority()
	return false
end

function CDOTABaseAbility:GetEnergyCost()
	return self:GetValueFromKV("AbilityEnergyCost") and self:GetValueFromKV("AbilityEnergyCost")  or 0
end

function CDOTABaseAbility:GetValueFromKV(sKey)
	local ability_key_values = self:GetAbilityKeyValues()
	local value = nil

	if ability_key_values then
		local m_value = ability_key_values[sKey]

		if m_value then
			if type(m_value) == 'number' then
				value = m_value
			else
				value = tonumber(string.split(m_value, ' ')[self:GetLevel()])
			end
		end
	end

	return value
end

function CDOTABaseAbility:IsType(type)
	if string.ends(self:GetName(), "_ex_" .. type) then
		return false
	elseif string.ends(self:GetName(), type) then
		return true
	else
		return false
	end
end