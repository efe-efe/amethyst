phantom_ex_basic_attack = class({})
LinkLuaModifier("modifier_phantom_ex_basic_attack", "abilities/heroes/phantom/phantom_ex_basic_attack/modifier_phantom_ex_basic_attack", LUA_MODIFIER_MOTION_NONE)

function phantom_ex_basic_attack:OnCastPointEnd()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(
        caster,
        self,
        "modifier_phantom_ex_basic_attack",
        { duration = duration }
    )

    self:PlayEffects()
end


function phantom_ex_basic_attack:PlayEffects()
    local caster = self:GetCaster()

    -- Create Particles
    local particle_cast = "particles/econ/events/ti5/blink_dagger_end_sparkles_end_lvl2_ti5.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, caster )
	ParticleManager:SetParticleControl( effect_cast, 3, caster:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	phantom_ex_basic_attack,
	{ activity = ACT_DOTA_TELEPORT_END, rate = 0.7 },
	{ movement_speed = 100 }
)