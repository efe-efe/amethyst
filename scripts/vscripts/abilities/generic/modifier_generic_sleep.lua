modifier_generic_sleep = class({})

--------------------------------------------------------------------------------

function modifier_generic_sleep:IsDebuff()
	return true
end

function modifier_generic_sleep:IsStunDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_generic_sleep:CheckState()
	local state = {
	[MODIFIER_STATE_NIGHTMARED] = true,
	[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

function modifier_generic_sleep:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_generic_sleep:GetOverrideAnimation()
	return ACT_DOTA_DISABLED
end

function modifier_generic_sleep:OnTakeDamage( params )
	if not IsServer() then return end
	self:Destroy()
end
--------------------------------------------------------------------------------

function modifier_generic_sleep:GetEffectName()
	return "particles/generic_gameplay/generic_sleep.vpcf"
end

function modifier_generic_sleep:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

--------------------------------------------------------------------------------
