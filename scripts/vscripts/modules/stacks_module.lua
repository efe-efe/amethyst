--[[ INFO
	This module expose stacking behaviour functions. Use it when you want to add auto
	expirable stacks on abilities.

	* Disadvantages:
		- The modifier that recives the stacks and runs the logic, needs to be written in lua
		(But not a big deal, considering that stacking logic is not doable in the txt. kv file)
		
		- You need to add an index to this file and the name of your modifier, and then link it
		on your skill via Special Values.
	
	* Bugs
		- The modifier hud doesn't show the duration, since the duration is on the stack modifiers and not
		on the ability modifier itself.

		- If you stack over the max_stacks, the stacks wont change at all, meaning that
		the first stack created wont be replaced.

	* How to use it: 

	Run the script "AddStack" on the event that should trigger the stacks addition (on the kv .txt file).
	Create (on this file) a new entry on the index table
	
	Add the following lines on the "onCreaterd" function of the modifier that depends on the stacks:
		
		if kv.stacks_count then
			self:SetStackCount(kv.stacks_count)
		end

	Special Values supported: 
		(*) max_stacks = Maximum number of stacks
		(*) stacks_duration = Duration of the stacks
		(*) modifier_index = Duration of the stacks

	(*) = Obligatory
]]

function AppendStacks(kv)
	local hero = kv.caster
	local ability = kv.ability
	
	hero:AddNewModifier(
		hero,
		ability,
		"modifier_basic_attack",
		{ }
	)
end


function AddStack(kv)
	local hero = kv.caster
	local ability = kv.ability

	-- First time initializations
	if ability.first_time == nil then
		ability.stacks_count = 0
		ability.original_cast_point = ability:GetCastPoint()
		ability.first_time = false
		ability.modifier = hero:AddNewModifier(
			hero,
			ability,
			"modifier_basic_attack",
			{ }
		)
	end
	
	local max_stacks = ability:GetSpecialValueFor("max_stacks")
	local stacks_duration = ability:GetSpecialValueFor("stacks_duration")
	
	if ability.modifier:GetStackCount() < max_stacks then

		hero:AddNewModifier(
			hero,
			ability,
			"modifier_stack",
			{ duration = stacks_duration }
		)

		ability.modifier:IncrementStackCount()
	end
end

