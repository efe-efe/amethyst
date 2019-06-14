modifier_wisp_mobility_thinker_lua = class({})

--------------------------------------------------------------------------------

function modifier_wisp_mobility_thinker_lua:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_wisp_mobility_thinker_lua:OnCreated( kv )
    if IsServer() then
        self.caster = self:GetParent()
		self:PlayEffects()
	end
end

function modifier_wisp_mobility_thinker_lua:OnDestroy( kv )
	if IsServer() then
		ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
        
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_wisp_mobility_thinker_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/econ/items/wisp/wisp_relocate_marker_ti7.vpcf"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetParent() )
end