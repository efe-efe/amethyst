phantom_extra = class({})
LinkLuaModifier("modifier_phantom_extra", "abilities/heroes/phantom/phantom_extra/modifier_phantom_extra", LUA_MODIFIER_MOTION_NONE)

function phantom_extra:OnCastPointEnd()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(
        caster,
        self,
        "modifier_phantom_extra",
        { duration = duration }
    )

    self:PlayEffects()
end


function phantom_extra:PlayEffects()
    local caster = self:GetCaster()

    -- Create Particles
    local particle_cast = "particles/econ/events/ti5/blink_dagger_end_sparkles_end_lvl2_ti5.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, caster )
	ParticleManager:SetParticleControl( effect_cast, 3, caster:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	phantom_extra,
	{ activity = ACT_DOTA_TELEPORT_END, rate = 0.7 },
	{ movement_speed = 100 }
)