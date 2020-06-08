item_mango_custom = class({})

function item_mango_custom:OnSpellStart()
    self:GetCaster():GiveMana(self:GetSpecialValueFor("mana"))
    self:PlayEffects()
    self:SpendCharge()
end

function item_mango_custom:PlayEffects()
    EmitSoundOn("DOTA_Item.Mango.Activate", self:GetCaster() )

    local particle_cast = "particles/items3_fx/mango_active.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end