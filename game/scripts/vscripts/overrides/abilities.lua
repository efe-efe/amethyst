
function CDOTABaseAbility:GetMaxAbilityCharges()
	return GetCurrentLevelValue(self, 'AbilityCharges')
end

function CDOTABaseAbility:GetAbilityChargeRestoreTime()
	return GetCurrentLevelValue(self, 'AbilityChargeRestoreTime')
end

function CDOTABaseAbility:HasBehavior(behavior)
	local abilityBehavior = tonumber(tostring(self:GetBehavior()))
	return bit.band(abilityBehavior, behavior) == behavior
end

function CDOTABaseAbility:GetCursorPosition()
	local caster = self:GetCaster();
	local playerId = caster:GetPlayerOwnerID();

	if IsInToolsMode() then
		playerId = Entities:GetLocalPlayer():GetPlayerID();
	end

	local position = GameRules.GameMode.players[playerId].cursor_position

	return position
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

function CDOTABaseAbility:IsType(type)
	if string.ends(self:GetName(), "_ex_" .. type) then
		return false
	elseif string.ends(self:GetName(), type) then
		return true
	else
		return false
	end
end