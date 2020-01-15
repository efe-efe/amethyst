modifier_generic_silenced = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_silenced:IsDebuff()
	return true
end

function modifier_generic_silenced:IsStunDebuff()
	return false
end

function modifier_generic_silenced:IsPurgable()
	return true
end

function modifier_generic_silenced:OnCreated()
	if IsServer() then
		self:GetParent():AddStatusBar({
			label = "Silence", modifier = self, priority = 4, stylename="Silence"
		}) 
		self:GetParent():InterruptCastPoint()
		SafeDestroyModifier("modifier_channeling", self:GetParent())

		self:PlayEffects()
	end
end

function modifier_generic_silenced:OnDestroy()
	if IsServer() then
		self:StopEffects()
	end
end

--------------------------------------------------------------------------------
-- Graphics and animations
function modifier_generic_silenced:PlayEffects()
    local particle_cast = "particles/generic_gameplay/screen_silence_indicator.vpcf"
    self.effect_cast = ParticleManager:CreateParticleForPlayer(particle_cast, PATTACH_EYES_FOLLOW, self:GetParent(), self:GetParent():GetPlayerOwner())
end

function modifier_generic_silenced:StopEffects()
	ParticleManager:DestroyParticle(self.effect_cast, false)
    ParticleManager:ReleaseParticleIndex( self.effect_cast )
end

function modifier_generic_silenced:GetEffectName()
	return "particles/generic_gameplay/generic_silenced.vpcf"
end

function modifier_generic_silenced:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
