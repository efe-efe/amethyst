item_health_orb = class({})

function item_health_orb:OnSpellStart()
    local caster = self:GetCaster()
    local heal = 6

    caster:Heal( heal, caster )
    PseudoHeal(caster:GetHealth(), heal, caster)

    EmitSoundOn("DOTA_Item.FaerieSpark.Activate", caster)
end