item_faerie_custom = class({})

function item_faerie_custom:OnSpellStart()
    self:GetCaster():Heal(self:GetSpecialValueFor("heal"), self:GetCaster())
    self:PlayEffects()
end

function item_faerie_custom:PlayEffects()
    EmitSoundOn( "DOTA_Item.FaerieSpark.Activate", self:GetCaster()  )

    local particle_cast = "particles/items3_fx/fish_bones_active.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end