item_health_orb = class({})

function item_health_orb:OnSpellStart()
    local caster = self:GetCaster()
    local heal = 3

    caster:Heal(heal, caster)
    TrueHeal(caster:GetHealth(), heal, caster)

    EmitSoundOn("DOTA_Item.FaerieSpark.Activate", caster)
end