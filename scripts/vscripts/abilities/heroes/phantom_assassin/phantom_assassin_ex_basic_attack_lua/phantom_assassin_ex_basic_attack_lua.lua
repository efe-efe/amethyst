phantom_assassin_ex_basic_attack_lua = class({})

LinkLuaModifier("modifier_phantom_assassin_ex_basic_attack_lua", "abilities/heroes/phantom_assassin/phantom_assassin_ex_basic_attack_lua/modifier_phantom_assassin_ex_basic_attack_lua", LUA_MODIFIER_MOTION_NONE)

function phantom_assassin_ex_basic_attack_lua:OnSpellStart()
    local caster = self:GetCaster()

    caster:AddNewModifier(
        caster,
        self,
        "modifier_phantom_assassin_ex_basic_attack_lua",
        {}
    )

    self:PlayEffects()
end


function phantom_assassin_ex_basic_attack_lua:PlayEffects()
    local caster = self:GetCaster()

    -- Create Particles
    local particle_cast = "particles/units/heroes/hero_demonartist/demonartist_spiritwalk_buff_start_rope.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, caster )
	ParticleManager:SetParticleControl( effect_cast, 3, caster:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

