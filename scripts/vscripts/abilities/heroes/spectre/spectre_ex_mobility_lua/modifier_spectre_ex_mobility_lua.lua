modifier_spectre_ex_mobility_lua = class({})

--- Misc 
function modifier_spectre_ex_mobility_lua:IsHidden()
    return false
end

function modifier_spectre_ex_mobility_lua:IsPurgable()
    return false
end


--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_ex_mobility_lua:OnCreated( kv )
    --Initializers
    if IsServer() then
        self:PlayEffects()
    end
end


--------------------------------------------------------------------------------
-- Destroyer
function modifier_spectre_ex_mobility_lua:OnDestroy( kv )
    if IsServer() then
        self:StopEffects()
    end
end

-- Graphics & Animations
function modifier_spectre_ex_mobility_lua:PlayEffects( )
	local particle_cast = "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_blade_fury_abyssal.vpcf"

	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( self.effect_cast, 2, self:GetParent():GetOrigin() )
    
end

function modifier_spectre_ex_mobility_lua:StopEffects()
    ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end
