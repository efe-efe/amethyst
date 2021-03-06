sniper_counter = class({})
LinkLuaModifier("modifier_sniper_counter", "abilities/heroes/sniper/sniper_counter/modifier_sniper_counter", LUA_MODIFIER_MOTION_NONE)

function sniper_counter:OnSpellStart() 
    local duration = self:GetSpecialValueFor("duration")

    self:GetCaster():AddNewModifier(
        self:GetCaster(),
        self,
        "modifier_sniper_counter",
        { duration = duration }
    )

    self:RefreshAbility('sniper_second_attack')
    self:RefreshAbility('sniper_ex_second_attack')
    self:PlayEffects()

    EFX("particles/items2_fx/smoke_of_deceit.vpcf", PATTACH_WORLDORIGIN, self:GetCaster(), {
        cp0 = self:GetCaster():GetAbsOrigin(),
        cp1 = Vector(500, 500, 500),
        release = true,
    })
end

function sniper_counter:RefreshAbility(sAbilityName)
    local ability = self:GetCaster():FindAbilityByName(sAbilityName)
    if ability then
        ability:EndCooldown()
    end
end

function sniper_counter:PlayEffects()
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()

    EmitSoundOn("DOTA_Item.SmokeOfDeceit.Activate" , caster)

    local particle_cast ="particles/sniper/sniper_counter.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 3, Vector(origin.x, origin.y, origin.z + 64))
    ParticleManager:SetParticleControl(effect_cast, 0, origin)

    particle_cast = "particles/econ/items/riki/riki_head_ti8/riki_smokebomb_ti8_start_ring.vpcf"
    effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end