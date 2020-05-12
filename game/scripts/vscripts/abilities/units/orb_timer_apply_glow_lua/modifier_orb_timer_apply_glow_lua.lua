modifier_orb_timer_apply_glow_lua = class ({})
--------------------------------------------------------------------------------
-- Classifications
function modifier_orb_timer_apply_glow_lua:IsHidden() return false
end

function modifier_orb_timer_apply_glow_lua:IsDebuff() return false
end

function modifier_orb_timer_apply_glow_lua:IsPurgable() return false
end
--------------------------------------------------------------------------------
-- Initialize
function modifier_orb_timer_apply_glow_lua:OnCreated( kv )
	self:PlayEffects()
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_orb_timer_apply_glow_lua:OnDestroy( kv )
	self:StopEffects()
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_orb_timer_apply_glow_lua:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
	}

	return state
end

function modifier_orb_timer_apply_glow_lua:PlayEffects()
	local particle_cast = "particles/dev/new_heroes/new_hero_aoe_ring_embers.vpcf"

	-- Create Particles
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(20, 1, 1) )
	ParticleManager:SetParticleControl( self.effect_cast, 15, Vector(148, 0, 59) )

end

function modifier_orb_timer_apply_glow_lua:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end