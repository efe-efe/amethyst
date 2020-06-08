terrorblade_special_attack_blade = class({})

function terrorblade_special_attack_blade:OnCreated()
    if IsServer() then
		local eruption_pfx = ParticleManager:CreateParticle("particles/tiny_prestige_tree_spawn_form.vpcf", PATTACH_CUSTOMORIGIN, self:GetParent())
		ParticleManager:SetParticleControl(eruption_pfx, 0, self:GetParent():GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(eruption_pfx)

        local particle_cast = "particles/units/heroes/hero_dazzle/dazzle_shallow_grave_halo_spiral.vpcf"

        self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        ParticleManager:SetParticleControl(self.effect_cast, 0, self:GetParent():GetAbsOrigin() + Vector(0, 0, 100))
        ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.radius, 1, 1))
        ParticleManager:SetParticleControlEnt(
            self.effect_cast, 
            2, 
            self:GetParent(), 
            PATTACH_POINT_FOLLOW, 
            "attach_hitloc", 
            self:GetParent():GetAbsOrigin(), 
            true
       )

        self:StartIntervalThink(1.0)
    end
end

function terrorblade_special_attack_blade:OnDestroy()
    if IsServer() then
        ParticleManager:DestroyParticle(self.effect_cast, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast)
        self:GetParent():Kill(nil, self:GetParent())
    end
end

-- Status Effects
function terrorblade_special_attack_blade:CheckState()
	local state = {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
	}

	return state
end
