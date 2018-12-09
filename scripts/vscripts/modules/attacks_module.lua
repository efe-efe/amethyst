function SetAttackRange(kv)
    local hero = kv.caster
	local ability = kv.ability
	--local range = ability:GetAttackRange()

	hero:AddNewModifier(
		hero,
		ability,
		"modifier_set_attack_range",
		{
            range = range
        }
	)
end
