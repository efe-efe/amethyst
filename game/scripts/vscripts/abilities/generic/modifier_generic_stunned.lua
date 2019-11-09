modifier_generic_stunned = class({})

function modifier_generic_stunned:IsDebuff()
	return true
end

function modifier_generic_stunned:IsStunDebuff()
	return true
end

function modifier_generic_stunned:OnCreated()
	if IsServer() then
		self:GetParent():AddStatusBar({
			label = "Stun", modifier = self, priority = 4, stylename="Stun"
		}) 
		
		SafeDestroyModifier("modifier_cast_point_old", self:GetParent(), self:GetParent())
		SafeDestroyModifier("modifier_cast_point", self:GetParent(), self:GetParent())
	end
end

--------------------------------------------------------------------------------

function modifier_generic_stunned:CheckState()
	local state = {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		--[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------

function modifier_generic_stunned:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_generic_stunned:GetOverrideAnimation( params )
	return ACT_DOTA_DISABLED
end

--------------------------------------------------------------------------------
function modifier_generic_stunned:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_generic_stunned:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end