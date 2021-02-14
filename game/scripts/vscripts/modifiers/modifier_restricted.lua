modifier_restricted = class({})

function modifier_restricted:IsHidden()         return true end
function modifier_restricted:IsDebuff()         return	false	end
function modifier_restricted:IsPurgable() 		return	false	end
function modifier_restricted:RemoveOnDeath() 	return	false	end

function modifier_restricted:CheckState()
	return {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end