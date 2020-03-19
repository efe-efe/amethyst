function PseudoHeal(base, heal, unit)
    unit:SetHealth(base + heal)

    local new_treshold = unit.iTreshold + heal
    if new_treshold > GameRules.GameMode.iMaxTreshold then
        unit.iTreshold = GameRules.GameMode.iMaxTreshold
    else
        unit.iTreshold = new_treshold
    end

    for i = 0, heal - 1 do
        unit:FindModifierByName("modifier_treshold"):IncrementStackCount()
    end

    SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, unit, heal, nil )
    GameRules.GameMode:UpdateHeroHealthBar(unit)
end