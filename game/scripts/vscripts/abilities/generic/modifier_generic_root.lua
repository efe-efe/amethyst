modifier_generic_root = class({})

--------------------------------------------------------------------------------

function modifier_generic_root:IsDebuff()
	return true
end

function modifier_generic_root:IsStunDebuff()
	return true
end


function modifier_generic_root:OnCreated()
	if IsServer() then
		self:GetParent():AddStatusBar({
			label = "Root", modifier = self, priority = 4, stylename="Root"
		}) 
		
	end
end

--------------------------------------------------------------------------------

function modifier_generic_root:CheckState()
	local state = {
	[MODIFIER_STATE_ROOTED] = true,
	}

	return state
end
--------------------------------------------------------------------------------

function modifier_generic_root:GetEffectName()
	return "particles/econ/items/oracle/oracle_fortune_ti7/oracle_fortune_ti7_purge_root_pnt.vpcf"
end

function modifier_generic_root:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------
