modifier_wisp_mobility_thinker = class({})

--------------------------------------------------------------------------------

function modifier_wisp_mobility_thinker:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_wisp_mobility_thinker:OnCreated( kv )
    if IsServer() then
        self.caster = self:GetParent()
		self:PlayEffects()
	end
end

function modifier_wisp_mobility_thinker:OnDestroy( kv )
	if IsServer() then
		ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
        
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_wisp_mobility_thinker:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/econ/items/wisp/wisp_relocate_marker_ti7.vpcf"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetParent() )
end