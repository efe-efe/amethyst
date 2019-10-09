function CDOTA_BaseNPC:GiveManaPercent( percentage )
    self:GiveMana(self:GetMaxMana() * percentage/100)
end

function CDOTA_BaseNPC:IsSilenced()
    return self:HasModifier("modifier_generic_silenced_lua")
end

function CDOTA_BaseNPC:IsStunned()
    return self:HasModifier("modifier_generic_stunned")
end

function CDOTA_BaseNPC:StrongPurge()
    self:Purge(false, true, false, true, false)
end
