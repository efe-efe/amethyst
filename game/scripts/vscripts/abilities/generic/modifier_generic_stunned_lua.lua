modifier_generic_stunned_lua = class({})

--------------------------------------------------------------------------------

function modifier_generic_stunned_lua:IsDebuff()
	return true
end

function modifier_generic_stunned_lua:IsStunDebuff()
	return true
end

function modifier_generic_stunned_lua:OnCreated()
	if IsServer() then
        ProgressBars:AddProgressBar(self:GetParent(), self:GetName(), {
            style = "Generic",
            text = "stunned",
            progressBarType = "duration",
            priority = 0,
        })
	end
end

--------------------------------------------------------------------------------

function modifier_generic_stunned_lua:CheckState()
	local state = {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		--[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------

function modifier_generic_stunned_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_generic_stunned_lua:GetOverrideAnimation( params )
	return ACT_DOTA_DISABLED
end

--------------------------------------------------------------------------------
function modifier_generic_stunned_lua:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_generic_stunned_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end