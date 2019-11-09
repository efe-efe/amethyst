modifier_spectre_ultimate_recast = class({})

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_ultimate_recast:OnCreated( params )
    if IsServer() then
        self.params = params

        local recast_ability = self:GetParent():AddAbility( "spectre_ultimate_recast" )
        recast_ability:SetLevel( 1 )

        local counter = 0
        while self.params["illusion_" .. counter] ~= nil do
            recast_ability:AddIllusion(self.params["illusion_" .. counter])
            counter = counter + 1
        end

        self:GetParent():SwapAbilities(
            "spectre_ultimate", 
            "spectre_ultimate_recast", 
            false, 
            true
        )

        self:GetParent():AddRecastVisual({
            key = "F",
            modifier = self,
            abilityName = self:GetAbility():GetName(),
        })
	end
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_ultimate_recast:OnDestroy( kv )
    if IsServer() then
        self:GetParent():SwapAbilities(
            "spectre_ultimate", 
            "spectre_ultimate_recast", 
            true, 
            false
        )
        self:GetParent():FindAbilityByName("spectre_ultimate_recast"):CleanIllusions()
        self:GetParent():RemoveAbility( "spectre_ultimate_recast" )
	end
end

function modifier_spectre_ultimate_recast:PlayEffectsAoe()
    local particle_cast = "particles/aoe_marker.vpcf"

    local effect_cast = ParticleManager:CreateParticleForPlayer( particle_cast, PATTACH_WORLDORIGIN, nil, self:GetParent():GetPlayerOwner() )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin())
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self:GetAbility():GetCastRange(Vector(0,0,0), nil), 1, 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 2, Vector( 255, 1, 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 3, Vector(0.1, 0, 0) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end
