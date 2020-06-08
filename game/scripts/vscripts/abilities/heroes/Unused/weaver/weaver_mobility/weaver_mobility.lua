weaver_mobility = class({})
LinkLuaModifier("modifier_weaver_mobility", "abilities/heroes/weaver/weaver_mobility/modifier_weaver_mobility", LUA_MODIFIER_MOTION_NONE)

function weaver_mobility:OnCastPointEnd() 
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(
        caster,
        self,
        "modifier_weaver_mobility",
        { duration = duration }
   )
    
    self:PlayEffects()
end

function weaver_mobility:PlayEffects()
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()

    -- Cast Sound
    local sound_cast = "Hero_Weaver.Shukuchi"
    EmitSoundOn(sound_cast , caster)

    -- Cast particle
    local particle_cast_a="particles/econ/items/vengeful/vs_ti8_immortal_shoulder/vs_ti8_immortal_magic_missle_end_smoke.vpcf"
    local particle_cast_b="particles/econ/items/riki/riki_head_ti8/riki_smokebomb_ti8_start_ring.vpcf"

    local effect_cast_a = ParticleManager:CreateParticle(particle_cast_a, PATTACH_WORLDORIGIN, nil)
    local effect_cast_b = ParticleManager:CreateParticle(particle_cast_b, PATTACH_WORLDORIGIN, nil)

    ParticleManager:SetParticleControl(effect_cast_a, 3, Vector(origin.x, origin.y, origin.z + 64))
    ParticleManager:SetParticleControl(effect_cast_b, 0, origin)
    
	ParticleManager:ReleaseParticleIndex(effect_cast_a)
	ParticleManager:ReleaseParticleIndex(effect_cast_b)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize(
	weaver_mobility,
	nil,
	{ movement_speed = 100 }
)