modifier_spectre_extra = class({})

--------------------------------------------------------------------------------
function modifier_spectre_extra:IsDebuff()
	return false
end

function modifier_spectre_extra:IsHidden()
	return true
end

function modifier_spectre_extra:IsPurgable()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_extra:OnCreated( kv )
    if IsServer() then
		self:PlayEffects()
		self:GetParent():AddNoDraw()
	end
end

function modifier_spectre_extra:OnRefresh( kv )
	
end

function modifier_spectre_extra:OnDestroy( kv )
	if IsServer() then
		self:GetParent():RemoveNoDraw()
		self:StopEffects()
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_spectre_extra:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end

function modifier_spectre_extra:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/econ/items/spectre/spectre_transversant_soul/spectre_ti7_crimson_spectral_dagger_path_owner.vpcf"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
end

function modifier_spectre_extra:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end