function CDOTABaseAbility:HasBehavior(behavior)
	local abilityBehavior = tonumber(tostring(self:GetBehavior()))
	return bit.band(abilityBehavior, behavior) == behavior
end

function CDOTABaseAbility:GetCursorPosition( )
	return GameMode.mouse_positions[self:GetCaster():GetPlayerID()]
end

function CDOTABaseAbility:GetAlternateName()
	local splitted = string.split(self:GetName(), "_")
	local alternate_name = ""

	if splitted[2] == "ex" then
		for k,v in pairs(splitted) do
			if k ~= 2 then
				alternate_name =  alternate_name .. v
				if k < #splitted then
					alternate_name =  alternate_name .. "_"
				end
			end
		end
	else
		alternate_name = splitted[1] .. "_ex_"
		for k,v in pairs(splitted) do
			if k > 1 then
				alternate_name =  alternate_name .. v
				if k < #splitted then
					alternate_name =  alternate_name .. "_"
				end
			end
		end
	end

	return alternate_name
end

function CDOTABaseAbility:IsBasicAttack()
	if string.ends(self:GetName(), "_ex_basic_attack") then
		return false
	elseif string.ends(self:GetName(), "basic_attack") then
		return true
	else
		return false
	end
end

function CalcRange(origin, point, max_range, min_range)
	local direction = (point - origin):Normalized()
	local distance = (point - origin):Length2D()
	local output_point = point
	
	if max_range then
		if distance > max_range then
			output_point = origin + direction * max_range
		end
	end

	if min_range then
		if distance < min_range then
			output_point = origin + direction * min_range
		end
	end

	return output_point
end