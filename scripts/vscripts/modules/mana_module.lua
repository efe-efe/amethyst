function GainMana( event )
    --DebugPrint("[DOTARITE] Gaining Mana")
	local hero = event.caster
    local ability = event.ability
    local mana_gain = ability:GetSpecialValueFor("mana_gain")
    
	if hero:IsRealHero() then
        local mana_gain_final = hero:GetMaxMana() * mana_gain
        hero:GiveMana(mana_gain_final)
    end
end