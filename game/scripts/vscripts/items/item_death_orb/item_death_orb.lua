item_death_orb = class({})

function item_death_orb:OnSpellStart()
    local charges = self:GetCurrentCharges()
    local caster = self:GetCaster()
    local heal = 24

    caster:GiveMana(charges)
    SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, caster, charges, nil )

    if charges == 100 then
        PseudoHeal(caster:GetHealth(), heal, caster)
    end
end