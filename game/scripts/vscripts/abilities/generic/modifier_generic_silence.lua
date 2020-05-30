modifier_generic_silence = class({})

function modifier_generic_silence:IsDebuff() return true end
function modifier_generic_silence:IsStunDebuff() return false end
function modifier_generic_silence:IsPurgable() return true end

function modifier_generic_silence:OnCreated()
	if IsServer() then
		self:GetParent():InterruptCastPoint()
		SafeDestroyModifier("modifier_channeling", self:GetParent())

		self:PlayEffects()
	end
end

function modifier_generic_silence:OnDestroy()
	if IsServer() then
		self:StopEffects()
	end
end

function modifier_generic_silence:PlayEffects()
    local particle_cast = "particles/generic_gameplay/screen_silence_indicator.vpcf"
    self.effect_cast = ParticleManager:CreateParticleForPlayer(particle_cast, PATTACH_EYES_FOLLOW, self:GetParent(), self:GetParent():GetPlayerOwner())
end

function modifier_generic_silence:StopEffects()
	ParticleManager:DestroyParticle(self.effect_cast, false)
    ParticleManager:ReleaseParticleIndex( self.effect_cast )
end

function modifier_generic_silence:GetEffectName()
	return "particles/generic_gameplay/generic_silenced.vpcf"
end
function modifier_generic_silence:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_generic_silence:CheckState()
	return { 
        [MODIFIER_STATE_SILENCED] = true
    }
end

function modifier_generic_silence:GetStatusLabel() return "Silence" end
function modifier_generic_silence:GetStatusPriority() return 5 end
function modifier_generic_silence:GetStatusStyle() return "Silence" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_generic_silence)