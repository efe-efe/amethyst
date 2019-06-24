modifier_wisp_ultimate = class({})

--------------------------------------------------------------------------------
function modifier_wisp_ultimate:IsDebuff()
	return false
end

function modifier_wisp_ultimate:IsHidden()
	return true
end

function modifier_wisp_ultimate:IsPurgable()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_wisp_ultimate:OnCreated( kv )
    if IsServer() then
		self:PlayEffects()
		self:GetParent():AddNoDraw()
	end
end

function modifier_wisp_ultimate:OnRefresh( kv )
	
end

function modifier_wisp_ultimate:OnDestroy( kv )
	if IsServer() then
		self:GetParent():RemoveNoDraw()
		self:StopEffects()
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_wisp_ultimate:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end

function modifier_wisp_ultimate:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/econ/items/wisp/wisp_relocate_marker_ti7_endpoint.vpcf"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
end

function modifier_wisp_ultimate:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end
