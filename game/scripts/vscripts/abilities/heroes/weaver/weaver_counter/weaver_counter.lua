weaver_counter = class({})
LinkLuaModifier( "modifier_weaver_counter", "abilities/heroes/weaver/weaver_counter/modifier_weaver_counter", LUA_MODIFIER_MOTION_NONE )

function weaver_counter:OnCastPointEnd() 
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(
        caster,
        self,
        "modifier_weaver_counter",
        { duration = duration }
    )
    
    self:PlayEffects()

    local ability = caster:FindAbilityByName("sniper_second_attack")
    local ability_ex = caster:FindAbilityByName("sniper_ex_second_attack")
    ability:EndCooldown()
    ability_ex:EndCooldown()
end

function weaver_counter:PlayEffects()
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()

    -- Cast Sound
    local sound_cast = "Hero_Weaver.Shukuchi"
    EmitSoundOn( sound_cast , caster )

    -- Cast particle
    local particle_cast_a="particles/econ/items/vengeful/vs_ti8_immortal_shoulder/vs_ti8_immortal_magic_missle_end_smoke.vpcf"
    local particle_cast_b="particles/econ/items/riki/riki_head_ti8/riki_smokebomb_ti8_start_ring.vpcf"

    local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_WORLDORIGIN, nil )
    local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, nil )

    ParticleManager:SetParticleControl( effect_cast_a, 3, Vector(origin.x, origin.y, origin.z + 64) )
    ParticleManager:SetParticleControl( effect_cast_b, 0, origin)
    
	ParticleManager:ReleaseParticleIndex( effect_cast_a )
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	weaver_counter,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 1.5 },
	{ movement_speed = 100 }
)