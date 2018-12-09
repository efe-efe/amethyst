function AppendCharges( kv )
	local hero = kv.caster
    local ability = kv.ability
    local m_max_count = ability:GetSpecialValueFor("max_charges")
    local m_start_count = ability:GetSpecialValueFor("start_charges")
    local m_replenish_time = ability:GetSpecialValueFor("replenish_time")
    
    hero:AddNewModifier(hero, ability, "modifier_charges", {
        max_count = m_max_count,
        start_count = m_start_count,
        replenish_time = m_replenish_time,
        sync_replenish = true
    })
end