troll_ultimate = class({})
LinkLuaModifier("modifier_troll_ultimate", "abilities/heroes/troll/troll_ultimate/modifier_troll_ultimate", LUA_MODIFIER_MOTION_NONE)

function troll_ultimate:OnSpellStart()
    local caster = self:GetCaster()

    caster:AddNewModifier(
        caster,
        self,
        "modifier_troll_ultimate",
        { duration = 10.0 }
    )

    self:PlayEffects()
end


function troll_ultimate:PlayEffects()
    local caster = self:GetCaster()

    -- Create Particles
    local particle_cast = "particles/units/heroes/hero_demonartist/demonartist_spiritwalk_buff_start_rope.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, caster )
	ParticleManager:SetParticleControl( effect_cast, 3, caster:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

