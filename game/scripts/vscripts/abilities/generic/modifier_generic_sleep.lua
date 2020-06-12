modifier_generic_sleep = class({})

function modifier_generic_sleep:IsDebuff() return true end
function modifier_generic_sleep:IsStunDebuff() return true end

function modifier_generic_sleep:OnCreated(params)
	if IsServer() then 
		self:GetParent():InterruptCastPoint()
	end
end

function modifier_generic_sleep:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_NIGHTMARED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end

function modifier_generic_sleep:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_generic_sleep:OnTakeDamage(params)
	if not IsServer() then return end
		if params.unit==self:GetParent() then
			self:Destroy()
		end
end

function modifier_generic_sleep:GetEffectName()
	return "particles/generic_gameplay/generic_sleep.vpcf"
end

function modifier_generic_sleep:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_generic_sleep:GetTexture()
	return "modifier_generic_sleep"
end

function modifier_generic_sleep:GetOverrideAnimation(params)
	return ACT_DOTA_DISABLED
end

function modifier_generic_sleep:GetStatusLabel() return "Sleep" end
function modifier_generic_sleep:GetStatusPriority() return 4 end
function modifier_generic_sleep:GetStatusStyle() return "Sleep" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_generic_sleep)
Modifiers.Animation(modifier_generic_sleep)