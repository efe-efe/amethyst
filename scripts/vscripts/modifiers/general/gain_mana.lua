function GainMana( event )
    DebugPrint("Gaining Mana")
	local hero = event.caster
    local ability = event.ability
    local mana_gain = ability:GetSpecialValueFor("mana_gain")

    local mana_gain_final = hero:GetMaxMana() * mana_gain
    hero:GiveMana(mana_gain_final)
end