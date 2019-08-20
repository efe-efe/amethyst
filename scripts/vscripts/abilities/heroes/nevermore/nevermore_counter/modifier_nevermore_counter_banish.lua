modifier_nevermore_counter_banish = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_nevermore_counter_banish:IsHidden()
	return false
end

function modifier_nevermore_counter_banish:IsDebuff()
	return false
end

function modifier_nevermore_counter_banish:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_nevermore_counter_banish:CheckState()
	local state = {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_SILENCED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_nevermore_counter_banish:OnCreated( kv )
	if IsServer() then
		self:GetParent():AddNoDraw()

		-- create particle
		local particle_cast = "particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_v2_ground01.vpcf"
		self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
		ParticleManager:SetParticleControl( self.effect_cast, 1, self:GetParent():GetOrigin() )
		ParticleManager:SetParticleControl( self.effect_cast, 2, self:GetParent():GetOrigin() )
		ParticleManager:SetParticleControl( self.effect_cast, 3, Vector(150, 0, 0) )

	end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_nevermore_counter_banish:OnDestroy( kv )
	if IsServer() then
		self:GetParent():RemoveNoDraw()
		ParticleManager:DestroyParticle( self.effect_cast, false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
	end
end
