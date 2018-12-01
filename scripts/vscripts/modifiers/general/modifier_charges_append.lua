function AppendCharges( event )
	local hero = event.caster
    local ability = event.ability
    local m_max_count = ability:GetSpecialValueFor("max_charges")
    local m_start_count = ability:GetSpecialValueFor("start_charges")
    local m_replenish_time = ability:GetSpecialValueFor("replenish_time")

    DebugPrint(m_max_count .. " " .. m_start_count .. " " .. m_start_count )
    
    hero:AddNewModifier(hero, ability, "modifier_charges", {
        max_count = m_max_count,
        start_count = m_start_count,
        replenish_time = m_replenish_time
    })
end