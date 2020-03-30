function PseudoHeal(base, heal, unit)
    unit:SetHealth(base + heal)

    local new_treshold = unit:GetTreshold() + heal
    if new_treshold > GameRules.GameMode.max_treshold then
        unit:SetTreshold(GameRules.GameMode.max_treshold)
    else
        unit:SetTreshold(new_treshold)
    end

    for i = 0, heal - 1 do
        unit:FindModifierByName("modifier_treshold"):IncrementStackCount()
    end

    SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, unit, heal, nil )
end