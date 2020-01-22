modifier_spectre_extra_recast = class({})

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_extra_recast:OnCreated( params )
    if IsServer() then
        self.params = params

        local recast_ability = self:GetParent():AddAbility( "spectre_extra_recast" )
        recast_ability:SetLevel( 1 )

        self:GetParent():SwapAbilities(
            "spectre_extra", 
            "spectre_extra_recast", 
            false, 
            true
        )
        
        self:StartIntervalThink(0.1)
        self:OnIntervalThink()

        self:GetParent():AddRecastVisual({
            key = "R",
            modifier = self,
            abilityName = self:GetAbility():GetName(),
        })
	end
end

function modifier_spectre_extra_recast:OnIntervalThink()
    self:PlayEffectsAoe()
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_extra_recast:OnDestroy( kv )
    if IsServer() then
        self:GetParent():SwapAbilities(
            "spectre_extra", 
            "spectre_extra_recast", 
            true, 
            false
        )
        self:GetParent():RemoveAbility( "spectre_extra_recast" )
        
        local counter = 0
        local point = CalcPoint(self:GetParent():GetOrigin(), self:GetAbility():GetCursorPosition(), self:GetAbility():GetCastRange(Vector(0,0,0), nil), nil)

        while self.params["enemy_" .. counter] ~= nil do
            local enemy = EntIndexToHScript(self.params["enemy_" .. counter]) 

            if self:GetRemainingTime() >= 0.05 then
                FindClearSpaceForUnit( enemy, point, true )
            end
            
            enemy:RemoveModifierByName("modifier_spectre_extra")	
            
            counter = counter + 1
        end
	end
end


function modifier_spectre_extra_recast:PlayEffectsAoe()
    local particle_cast = "particles/aoe_marker.vpcf"

    local effect_cast = ParticleManager:CreateParticleForPlayer( particle_cast, PATTACH_WORLDORIGIN, nil, self:GetParent():GetPlayerOwner() )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin())
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self:GetAbility():GetCastRange(Vector(0,0,0), nil), 1, 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 2, Vector( 255, 1, 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 3, Vector(0.1, 0, 0) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end
