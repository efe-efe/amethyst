modifier_generic_stunned = class({})

function modifier_generic_stunned:IsDebuff() return true end
function modifier_generic_stunned:IsStunDebuff() return true end

function modifier_generic_stunned:OnCreated()
	if IsServer() then
		self:GetParent():InterruptCastPoint()
	end
end

function modifier_generic_stunned:CheckState()
	return {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_STUNNED] = true,
	}
end

function modifier_generic_stunned:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end

function modifier_generic_stunned:GetOverrideAnimation(params)
	return ACT_DOTA_DISABLED
end

function modifier_generic_stunned:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_generic_stunned:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_generic_stunned:GetStatusLabel() return "Stun" end
function modifier_generic_stunned:GetStatusPriority() return 4 end
function modifier_generic_stunned:GetStatusStyle() return "Stun" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_generic_stunned)
Modifiers.Animation(modifier_generic_stunned)