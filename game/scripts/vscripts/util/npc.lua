function CDOTA_BaseNPC:GiveManaPercent( percentage )
    self:GiveMana(self:GetMaxMana() * percentage/100)
end