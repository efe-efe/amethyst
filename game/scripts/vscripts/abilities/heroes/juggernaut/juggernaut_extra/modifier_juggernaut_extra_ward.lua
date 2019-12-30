modifier_juggernaut_extra_ward = class({})

function modifier_juggernaut_extra_ward:OnCreated()
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self.heal_per_second = self:GetAbility():GetSpecialValueFor("heal_per_second")
    if IsServer() then

        self:PlayEffectsOnCreated()
        self:PlayEffectsAoe()
        self:StartIntervalThink( 0.1 )

        self.counter = 0.0

        if IsServer() then 
            self:GetParent():AddStatusBar({
                label = "Ward", modifier = self, priority = 3, 
            })
        end
    end
end

function modifier_juggernaut_extra_ward:OnDestroy()
    if IsServer() then
        ParticleManager:DestroyParticle(self.effect_cast, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast)

        self:GetParent():Kill(nil, self:GetParent())

        self:GetAbility():StartCooldown(self:GetAbility():GetCooldown(0))

        if self:GetCaster():HasModifier("modifier_juggernaut_extra_recast") then
            self:GetCaster():RemoveModifierByName("modifier_juggernaut_extra_recast")
        end
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_juggernaut_extra_ward:OnIntervalThink()
    self.counter = self.counter + 0.1

    if self.counter >= 1.0 then

        local allies = self:GetCaster():FindUnitsInRadius(
            self:GetParent():GetOrigin(), 
            self.radius, 
            DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER
        )
    
        -- Print units
        for _,ally in pairs(allies) do		
            ally:Heal(self.heal_per_second, self:GetCaster())
        end

        self.counter = 0.0
    end

    self:PlayEffectsAoe()
end

function modifier_juggernaut_extra_ward:PlayEffectsOnCreated()
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

end

function modifier_juggernaut_extra_ward:PlayEffectsAoe()
    local particle_cast = "particles/aoe_marker.vpcf"

    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin())
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 2, Vector( 1, 255, 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 3, Vector(0.1, 0, 0) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end