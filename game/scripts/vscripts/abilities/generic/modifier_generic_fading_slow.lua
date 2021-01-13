modifier_generic_fading_slow = class({})

function modifier_generic_fading_slow:OnCreated(params)
	if IsServer() then
		self.max_slow_pct = params.max_slow_pct
	end
end

function modifier_generic_fading_slow:GetEffectName()
    return "particles/generic_gameplay/rune_haste.vpcf"
end

function modifier_generic_fading_slow:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_generic_fading_slow:GetTexture()
	return "modifier_fading_slow"
end

function modifier_generic_fading_slow:GetMaxSlowPercentage()
	if IsServer() then
		return self.max_slow_pct
	end
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.FadingSlow(modifier_generic_fading_slow)