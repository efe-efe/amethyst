juggernaut_ex_ultimate_ward = class({})

function juggernaut_ex_ultimate_ward:OnCreated()
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self.heal_per_second = self:GetAbility():GetSpecialValueFor("heal_per_second")
    if IsServer() then

		-- Play spawn particle
		local eruption_pfx = ParticleManager:CreateParticle("particles/econ/items/juggernaut/bladekeeper_healing_ward/juggernaut_healing_ward_eruption_dc.vpcf", PATTACH_CUSTOMORIGIN, self:GetParent())
		ParticleManager:SetParticleControl(eruption_pfx, 0, self:GetParent():GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(eruption_pfx)

        local particle_cast = "particles/econ/items/juggernaut/bladekeeper_healing_ward/juggernaut_healing_ward_dc.vpcf"

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

        self:StartIntervalThink( 1.0 )
    end
end

function juggernaut_ex_ultimate_ward:OnDestroy()
    if IsServer() then
        ParticleManager:DestroyParticle(self.effect_cast, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast)

        self:GetParent():Kill(nil, self:GetParent())
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function juggernaut_ex_ultimate_ward:OnIntervalThink()
    local allies = FindUnitsInRadius(
        self:GetCaster():GetTeamNumber(),
        self:GetCaster():GetAbsOrigin(),
        nil,
        self.radius,
        DOTA_UNIT_TARGET_TEAM_FRIENDLY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        0, -- int, flag filter
        0, -- int, order filter
        false -- bool, can grow cache
    )

    -- Print units
    for _,ally in pairs(allies) do		
        ally:Heal(self.heal_per_second, self:GetCaster())
    end

end