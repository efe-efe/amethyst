modifier_spectre_basic_attack_charged_visuals = class({})

--------------------------------------------------------------------------------

function modifier_spectre_basic_attack_charged_visuals:IsDebuff()
	return false
end

function modifier_spectre_basic_attack_charged_visuals:IsHidden()
	return true
end

function modifier_spectre_basic_attack_charged_visuals:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_basic_attack_charged_visuals:OnCreated( kv )
    if IsServer() then
        -- effects
        self:PlayEffects()
    end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_spectre_basic_attack_charged_visuals:OnDestroy( kv )
    if IsServer() then
        -- effects
        self:StopEffects()
    end
end

--------------------------------------------------------------------------------
-- Visuals
function modifier_spectre_basic_attack_charged_visuals:PlayEffects()
    if IsServer() then
        -- Get Resources
        local particle_cast = "particles/units/heroes/hero_magnataur/magnataur_empower.vpcf"
        local origin = self:GetParent():GetOrigin()
        self.effect_cast = ParticleManager:CreateParticle( 
            particle_cast, 
            PATTACH_CUSTOMORIGIN, 
            nil
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
    end
end


function modifier_spectre_basic_attack_charged_visuals:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end
