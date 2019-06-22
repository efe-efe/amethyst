nevermore_ex_special_attack = class({})
LinkLuaModifier("modifier_nevermore_ex_special_attack", "abilities/heroes/nevermore/nevermore_ex_special_attack/modifier_nevermore_ex_special_attack", LUA_MODIFIER_MOTION_NONE)

function nevermore_ex_special_attack:OnSpellStart()
    local caster = self:GetCaster()

    caster:AddNewModifier(
        caster,
        self,
        "modifier_nevermore_ex_special_attack",
        {}
    )

    self:PlayEffects()
    
    -- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("nevermore_special_attack")
	alternate_version:StartCooldown(self:GetCooldown(0))
end


function nevermore_ex_special_attack:PlayEffects()
    local caster = self:GetCaster()

    -- Create Particles
    local particle_cast = "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_loadout_ribbon.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, caster:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

