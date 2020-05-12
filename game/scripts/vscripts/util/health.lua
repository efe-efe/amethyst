function TrueHeal(base, heal, unit)
    unit:SetHealth(base + heal)

    local new_treshold = unit:GetTreshold() + heal
    if new_treshold > GameRules.GameMode.max_treshold then
        unit:SetTreshold(GameRules.GameMode.max_treshold)
    else
        unit:SetTreshold(new_treshold)
    end

    SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, unit, heal, nil )
end