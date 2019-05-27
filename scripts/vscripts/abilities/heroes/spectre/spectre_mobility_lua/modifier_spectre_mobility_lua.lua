modifier_spectre_mobility_lua = class({})

--------------------------------------------------------------------------------
function modifier_spectre_mobility_lua:IsDebuff()
	return false
end

function modifier_spectre_mobility_lua:IsHidden()
	return true
end

function modifier_spectre_mobility_lua:IsPurgable()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_mobility_lua:OnCreated( kv )
    if IsServer() then
		self:PlayEffects()
		self:GetParent():AddNoDraw()
	end
end

function modifier_spectre_mobility_lua:OnRefresh( kv )
	
end

function modifier_spectre_mobility_lua:OnDestroy( kv )
	if IsServer() then
		self:GetParent():RemoveNoDraw()
		self:StopEffects()
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_spectre_mobility_lua:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end

function modifier_spectre_mobility_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/econ/items/spectre/spectre_transversant_soul/spectre_ti7_crimson_spectral_dagger_path_owner.vpcf"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
end

function modifier_spectre_mobility_lua:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end
