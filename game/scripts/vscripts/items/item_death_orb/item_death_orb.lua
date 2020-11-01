item_death_orb = class({})

function item_death_orb:OnSpellStart()
    local charges = self:GetCurrentCharges()
    local caster = self:GetCaster()
    local heal = 24

    caster:GiveMana(charges)
    SendOverheadManaMessage(caster, charges)

    if charges == 100 then
        TrueHeal(caster:GetHealth(), heal, caster)
    end
end