item_death_orb = class({})

function item_death_orb:OnSpellStart()
    local charges = self:GetCurrentCharges()
    local caster = self:GetCaster()
    local heal = 24

    CustomEntitiesLegacy:GiveManaAndEnergy(caster, charges, true, true)

    if charges == 100 then
        CustomEntitiesLegacy:TrueHeal(caster, heal)
    end
end