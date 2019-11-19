weaver_ultimate = class({})
LinkLuaModifier( "modifier_weaver_ultimate", "abilities/heroes/weaver/weaver_ultimate/modifier_weaver_ultimate", LUA_MODIFIER_MOTION_NONE )

function weaver_ultimate:GetIntrinsicModifierName()
    return "modifier_weaver_ultimate"
end

function weaver_ultimate:OnCastPointEnd() 
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    local origin = caster:GetOrigin()

    local modifier = caster:FindModifierByName("modifier_weaver_ultimate")
    if 
        modifier.origins == nil or
        modifier.counter == nil or 
        modifier.origins[modifier.counter] == nil 
    then
        FindClearSpaceForUnit(caster, origin, true)
        self:PlayEffects(origin, origin)
    else
        FindClearSpaceForUnit(caster, modifier.origins[modifier.counter], true)
        self:PlayEffects(origin, modifier.origins[modifier.counter])
    end

end

function weaver_ultimate:PlayEffects(origin, target)
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()

    -- Cast Sound
    local sound_cast = "Hero_Weaver.TimeLapse"
    EmitSoundOn( sound_cast , caster )

    -- Cast particle
    local particle_cast = "particles/units/heroes/hero_weaver/weaver_timelapse.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
    ParticleManager:SetParticleControl( effect_cast, 0, origin)
    ParticleManager:SetParticleControl( effect_cast, 2, target)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	weaver_ultimate,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 1.5 },
	{ movement_speed = 100 }
)