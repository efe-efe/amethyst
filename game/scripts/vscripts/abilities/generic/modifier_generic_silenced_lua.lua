modifier_generic_silenced_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_silenced_lua:IsDebuff()
	return true
end

function modifier_generic_silenced_lua:IsStunDebuff()
	return false
end

function modifier_generic_silenced_lua:IsPurgable()
	return true
end

function modifier_generic_silenced_lua:OnCreated()
	if IsServer() then
        ProgressBars:AddProgressBar(self:GetParent(), self:GetName(), {
            style = "Generic",
            text = "silenced",
            progressBarType = "duration",
            priority = 0,
		})
		self:PlayEffects()

		SafeDestroyModifier("modifier_channeling", self:GetParent())
	end
end
function modifier_generic_silenced_lua:OnDestroy()
	if IsServer() then
		self:StopEffects()
	end
end
--------------------------------------------------------------------------------
-- Modifier State
function modifier_generic_silenced_lua:CheckState()
	local state = {
		--[MODIFIER_STATE_SILENCED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics and animations
function modifier_generic_silenced_lua:PlayEffects()
    local particle_cast = "particles/generic_gameplay/screen_silence_indicator.vpcf"
    self.effect_cast = ParticleManager:CreateParticleForPlayer(particle_cast, PATTACH_EYES_FOLLOW, self:GetParent(), self:GetParent():GetPlayerOwner())
end

function modifier_generic_silenced_lua:StopEffects()
	ParticleManager:DestroyParticle(self.effect_cast, false)
    ParticleManager:ReleaseParticleIndex( self.effect_cast )
end

function modifier_generic_silenced_lua:GetEffectName()
	return "particles/generic_gameplay/generic_silenced.vpcf"
end

function modifier_generic_silenced_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
