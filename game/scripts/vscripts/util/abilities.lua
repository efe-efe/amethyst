local SPELLS_HIERARCHY_TABLE = {}

SPELLS_HIERARCHY_TABLE["basic_attack"] = 0
SPELLS_HIERARCHY_TABLE["second_attack"] = 1
SPELLS_HIERARCHY_TABLE["mobility"] = 2
SPELLS_HIERARCHY_TABLE["counter"] = 3
SPELLS_HIERARCHY_TABLE["special_attack"] = 4
SPELLS_HIERARCHY_TABLE["extra"] = 5
SPELLS_HIERARCHY_TABLE["ultimate"] = 6
SPELLS_HIERARCHY_TABLE["ex_basic_attack"] = 7
SPELLS_HIERARCHY_TABLE["ex_second_attack"] = 8
SPELLS_HIERARCHY_TABLE["ex_mobility"] = 9
SPELLS_HIERARCHY_TABLE["ex_counter"] = 10
SPELLS_HIERARCHY_TABLE["ex_special_attack"] = 11
SPELLS_HIERARCHY_TABLE["mount"] = 12

function CDOTABaseAbility:AddCharges(num)
	if IsServer() then
		local charges_modifier_name = self:GetIntrinsicModifierName()

		if charges_modifier_name == nil or charges_modifier_name == "" then
			print("[ADD CHARGE ERROR] Ability don't has charges modifier")
			return
		end
		
		local charges_modifier = self:GetCaster():FindModifierByName(charges_modifier_name)

		if charges_modifier ~= nil then
			local new_charges = charges_modifier:GetStackCount() + num
			local max_charges = self:GetSpecialValueFor("max_charges")
			local extra_charges = self:GetSpecialValueFor("extra_charges")

			if new_charges > (extra_charges + max_charges) then
				new_charges = extra_charges + max_charges
			end
			charges_modifier:SetStackCount(new_charges)
		else
			print("[ADD CHARGE ERROR] Charge modifier doesnt exists")
		end
	end
end

function CDOTABaseAbility:HasCharges()
	return false
end

function CDOTABaseAbility:HasBehavior(behavior)
	local abilityBehavior = tonumber(tostring(self:GetBehavior()))
	return bit.band(abilityBehavior, behavior) == behavior
end

function CDOTABaseAbility:GetCursorPosition()
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

function CDOTABaseAbility:GetRelatedAbility()
	local ability = self:GetCaster():FindAbilityByName( self:GetName() .. "_related" )
	if ability ~= nil then
		return ability
	else 
		return nil
	end
end

function CDOTABaseAbility:IsEx()
	local splitted = string.split(self:GetName(), "_")

	if splitted[2] == "ex" then
		if string.ends(self:GetName(), "_ultimate") then return false end 
		if string.ends(self:GetName(), "_projectile") then return false end 
		if string.ends(self:GetName(), "_recast") then return false end 
		return true
	end
	return false
end

function CDOTABaseAbility:GetAbilityOriginalIndex()
	if self:IsBasicAttack() then return 0 end
	if self:IsSecondAttack() then return 1 end
	if self:IsMobility() then return 2 end
	if self:IsCounter() then return 3 end
	if self:IsSpecialAttack() then return 4 end
	if self:IsExtra() then return 5 end
	if self:IsUltimate() then return 6 end

	local other_ex = nil
	--Find the other EX
	for i = 0, 20 do
		local ability = self:GetCaster():GetAbilityByIndex(i)

		if ability ~= nil then
			if ability ~= self then
				if ability:IsEx() then
					other_ex = ability
				end
			end
		end
	end

	local name_self = ""
	if string.ends(self:GetName(), "_ex_basic_attack") then name_self = "ex_basic_attack" end
	if string.ends(self:GetName(), "_ex_second_attack") then name_self = "ex_second_attack" end
	if string.ends(self:GetName(), "_ex_mobility") then name_self = "ex_mobility" end
	if string.ends(self:GetName(), "_ex_counter") then name_self = "ex_counter" end
	if string.ends(self:GetName(), "_ex_special_attack") then name_self = "ex_special_attack" end

	local name_other = ""
	if string.ends(other_ex:GetName(), "_ex_basic_attack") then name_other = "ex_basic_attack" end
	if string.ends(other_ex:GetName(), "_ex_second_attack") then name_other = "ex_second_attack" end
	if string.ends(other_ex:GetName(), "_ex_mobility") then name_other = "ex_mobility" end
	if string.ends(other_ex:GetName(), "_ex_counter") then name_other = "ex_counter" end
	if string.ends(other_ex:GetName(), "_ex_special_attack") then name_other = "ex_special_attack" end

	if name_self == "" or name_other == "" then return -1 end

	if SPELLS_HIERARCHY_TABLE[name_self] < SPELLS_HIERARCHY_TABLE[name_other] then 
		return 7
	else
		return 8
	end
end


function CDOTABaseAbility:IsBasicAttack()
	return IsType(self, "basic_attack")
end

function CDOTABaseAbility:IsSecondAttack()
	return IsType(self, "second_attack")
end

function CDOTABaseAbility:IsCounter()
	return IsType(self, "counter")
end

function CDOTABaseAbility:IsMobility()
	return IsType(self, "mobility")
end

function CDOTABaseAbility:IsSpecialAttack()
	return IsType(self, "special_attack")
end

function CDOTABaseAbility:IsExtra()
	return IsType(self, "extra")
end

function CDOTABaseAbility:IsUltimate()
	return IsType(self, "ultimate")
end

function CDOTABaseAbility:HasPriority()
	return false
end

function IsType(ability, type)
	if string.ends(ability:GetName(), "_ex_" .. type) then
		return false
	elseif string.ends(ability:GetName(), type) then
		return true
	else
		return false
	end
end


function CalcPoint(origin, point, max_range, min_range)
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

