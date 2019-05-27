modifier_spectre_basic_attack_charged_visuals_lua = class({})

--------------------------------------------------------------------------------

function modifier_spectre_basic_attack_charged_visuals_lua:IsDebuff()
	return false
end

function modifier_spectre_basic_attack_charged_visuals_lua:IsHidden()
	return false
end

function modifier_spectre_basic_attack_charged_visuals_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_basic_attack_charged_visuals_lua:OnCreated( kv )
    if IsServer() then
        -- effects
        self:PlayEffects()
    end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_spectre_basic_attack_charged_visuals_lua:OnDestroy( kv )
    if IsServer() then
        -- effects
        self:StopEffects()
    end
end

--------------------------------------------------------------------------------
-- Visuals
function modifier_spectre_basic_attack_charged_visuals_lua:PlayEffects()
    if IsServer() then
        -- Get Resources

        local particle_cast = "particles/units/heroes/hero_nevermore/nevermore_base_attack_c.vpcf"
        local origin = self:GetParent():GetOrigin()
        self.effect_cast = ParticleManager:CreateParticle( 
            particle_cast, 
            PATTACH_CUSTOMORIGIN, 
            self:GetParent()
        )

        ParticleManager:SetParticleControlEnt( 
            self.effect_cast, 
            0, 
            self:GetParent(), 
            PATTACH_POINT_FOLLOW, 
            "attach_attack1", 
            origin, 
            true 
        )
        ParticleManager:SetParticleControlEnt( 
            self.effect_cast, 
            3, 
            self:GetParent(), 
            PATTACH_POINT_FOLLOW, 
            "attach_attack1", 
            origin, 
            true 
        )
    end
end


function modifier_spectre_basic_attack_charged_visuals_lua:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end
