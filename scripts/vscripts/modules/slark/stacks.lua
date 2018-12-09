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