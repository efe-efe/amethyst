modifier_generic_stunned = class({})

function modifier_generic_stunned:IsDebuff()
	return true
end

function modifier_generic_stunned:IsStunDebuff()
	return true
end

function modifier_generic_stunned:OnCreated()
	if IsServer() then
        ProgressBars:AddProgressBar(self:GetParent(), self:GetName(), {
            style = "Generic",
            text = "stunned",
            progressBarType = "duration",
            priority = 0,
		})
		
		SafeDestroyModifier("modifier_cast_point", self:GetParent(), self:GetParent())
		SafeDestroyModifier("modifier_cast_point_new", self:GetParent(), self:GetParent())
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