modifier_generic_sleep = class({})

-- Classifiactions
--------------------------------------------------------------------------------
function modifier_generic_sleep:IsDebuff()
	return true
end

function modifier_generic_sleep:IsStunDebuff()
	return true
end

function modifier_generic_sleep:OnCreated(params)
	if IsServer() then 
		self:GetParent():AddStatusBar({
			label = "Sleep", modifier = self, priority = 3, stylename="Sleep"
		}) 
		self:GetParent():InterruptCastPoint()
	end
end

--------------------------------------------------------------------------------
function modifier_generic_sleep:CheckState()
	local state = {
		[MODIFIER_STATE_NIGHTMARED] = true,
		--[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_sleep:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_generic_sleep:OnTakeDamage(params)
	if not IsServer() then return end
		-- filter
		if params.unit==self:GetParent() then
			self:Destroy()
		end
end

--------------------------------------------------------------------------------
-- Graphics

function modifier_generic_sleep:GetEffectName()
	return "particles/generic_gameplay/generic_sleep.vpcf"
end

function modifier_generic_sleep:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_generic_sleep:GetOverrideAnimation()
	return ACT_DOTA_DISABLED
end

function modifier_generic_sleep:GetTexture()
	return "modifier_generic_sleep"
end