weaver_ultimate = class({})
LinkLuaModifier("modifier_weaver_ultimate", "abilities/heroes/weaver/weaver_ultimate/modifier_weaver_ultimate", LUA_MODIFIER_MOTION_NONE)

function weaver_ultimate:GetIntrinsicModifierName()
    return "modifier_weaver_ultimate"
end

function weaver_ultimate:OnCastPointEnd() 
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    local origin = caster:GetOrigin()
    local radius = self:GetSpecialValueFor("radius")
    local stun_duration = self:GetSpecialValueFor("stun_duration")
    local damage = self:GetSpecialValueFor("ability_damage")

    local location = nil

    local modifier = caster:FindModifierByName("modifier_weaver_ultimate")
    if 
        modifier.origins == nil or
        modifier.counter == nil or 
        modifier.origins[modifier.counter] == nil 
    then
        location = origin
    else
        location = modifier.origins[modifier.counter]
    end
    
    FindClearSpaceForUnit(caster, location, true)

    local enemies = caster:FindUnitsInRadius(
        caster:GetOrigin(), 
        radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
   )
    
    for _,enemy in pairs(enemies) do
        enemy:AddNewModifier(caster, self, "modifier_generic_stunned", { duration = stun_duration })
        local damage = {
            victim = enemy,
            attacker = caster,
            damage = damage,
            damage_type = DAMAGE_TYPE_PURE,
        }
        ApplyDamage(damage)
    end

    self:PlayEffects(origin, location, radius)
end

function weaver_ultimate:PlayEffects(origin, target, radius)
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()

    -- Cast Sound
    local sound_cast = "Hero_Weaver.TimeLapse"
    EmitSoundOn(sound_cast , caster)

    -- Cast particle
    local particle_cast = "particles/units/heroes/hero_weaver/weaver_timelapse.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControl(effect_cast, 0, origin)
    ParticleManager:SetParticleControl(effect_cast, 2, target)
    ParticleManager:ReleaseParticleIndex(effect_cast)
    
	particle_cast = "particles/call_modified/axe_beserkers_call_owner_shoutmask.vpcf"
    effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControl(effect_cast, 2, Vector(radius, 1, 1))
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize(
	weaver_ultimate,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 1.5 },
	{ movement_speed = 100 }
)