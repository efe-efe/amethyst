item_mana_orb = class({})

function item_mana_orb:OnSpellStart()
    local mana = 8
    local caster = self:GetCaster()
    CustomEntitiesLegacy:GiveManaAndEnergy(caster, mana, true, true)
    
    EmitSoundOn("DOTA_Item.ClarityPotion.Activate", caster)
    self:SpendCharge()
end