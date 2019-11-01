function PseudoHeal(base, heal, unit)
    unit:SetHealth(base + heal)

    local new_treshold = unit.iTreshold + heal
    if new_treshold > GameMode.iMaxTreshold then
        unit.iTreshold = GameMode.iMaxTreshold
    else
        unit.iTreshold = new_treshold
    end
    SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, unit, heal, nil )
    GameMode:UpdateHeroHealthBar(unit)
end