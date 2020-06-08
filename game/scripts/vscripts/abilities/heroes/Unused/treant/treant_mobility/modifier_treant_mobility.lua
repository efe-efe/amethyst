modifier_treant_mobility = class({}) 

function modifier_treant_mobility:OnCreated()
    if IsServer() then

        EmitSoundOn("Hero_Treant.LivingArmor.Cast", self:GetCaster())

        local particle_cast = "particles/econ/items/earthshaker/earthshaker_arcana/earthshaker_arcana_blink_start_v2.vpcf"
        -- Create Particles
        local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetOrigin())
        ParticleManager:SetParticleControl(effect_cast, 1, self:GetCaster():GetOrigin())
        ParticleManager:SetParticleControl(effect_cast, 3, self:GetCaster():GetOrigin())
        ParticleManager:ReleaseParticleIndex(effect_cast)

		self:GetParent():AddNoDraw()
        self:StartIntervalThink(0.03)
    end
end

function modifier_treant_mobility:OnDestroy()
    if IsServer() then
        self:GetParent():RemoveNoDraw()
    end
end

function modifier_treant_mobility:OnIntervalThink()
    self:PlayEffects()   
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_treant_mobility:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_SILENCED] = true,
	}

	return state
end

function modifier_treant_mobility:PlayEffects()
    local caster = self:GetCaster()
    local particle_cast = "particles/units/heroes/hero_treant/treant_overgrowth_vine_bushes.vpcf"
   
	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, caster:GetOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)

    particle_cast = "particles/units/heroes/hero_furion/furion_wrath_of_nature_growth_fallback_low.vpcf"
    -- Create Particles
	effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, caster:GetOrigin())
    ParticleManager:SetParticleControl(effect_cast, 4, caster:GetOrigin() + Vector(0,0,128))
    ParticleManager:ReleaseParticleIndex(effect_cast)
end
