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
	self.slow_duration = self:GetAbility():GetSpecialValueFor( "slow_duration" )
		
    if IsServer() then
		self:PlayEffects()
		self:GetParent():AddNoDraw()
	end
end

function modifier_spectre_extra:OnDestroy( kv )
	if IsServer() then
		self:GetParent():RemoveNoDraw()

		self:GetParent():AddNewModifier(
			self:GetParent(), -- player source
			self:GetAbility(), -- ability source
			"modifier_generic_fading_slow", -- modifier name
			{ duration = self.slow_duration } -- kv
		)

		self:PlayEffectsOnDestroy()
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

	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_spectre/spectre_death.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 3, self:GetParent():GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_spectre_extra:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end

function modifier_spectre_extra:PlayEffectsOnDestroy()
	EmitSoundOn( "Hero_Spectre.Reality", self:GetParent() )
    local particle_cast = "particles/econ/items/outworld_devourer/od_shards_exile_gold/od_shards_exile_prison_end_gold.vpcf"
    local effect_cast = ParticleManager:CreateParticle( 
            particle_cast, 
            PATTACH_WORLDORIGIN, 
            nil 
        )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end
