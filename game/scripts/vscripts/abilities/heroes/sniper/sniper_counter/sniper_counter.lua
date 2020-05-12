sniper_counter = class({})
LinkLuaModifier( "modifier_sniper_counter", "abilities/heroes/sniper/sniper_counter/modifier_sniper_counter", LUA_MODIFIER_MOTION_NONE )

function sniper_counter:OnSpellStart() 
    local duration = self:GetSpecialValueFor("duration")

    self:GetCaster():AddNewModifier(
        self:GetCaster(),
        self,
        "modifier_sniper_counter",
        { duration = duration }
    )

    local ability = self:GetCaster():FindAbilityByName("sniper_second_attack")
    ability:EndCooldown()
    self:PlayEffects()
end

function sniper_counter:PlayEffects()
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()

    EmitSoundOn("DOTA_Item.SmokeOfDeceit.Activate" , caster)

    local particle_cast ="particles/econ/items/vengeful/vs_ti8_immortal_shoulder/vs_ti8_immortal_magic_missle_end_smoke.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 3, Vector(origin.x, origin.y, origin.z + 64) )
    ParticleManager:SetParticleControl( effect_cast, 0, origin)

    particle_cast = "particles/econ/items/riki/riki_head_ti8/riki_smokebomb_ti8_start_ring.vpcf"
    effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end