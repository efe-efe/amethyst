modifier_visible = class({})

function modifier_visible:IsHidden()        return true end
function modifier_visible:IsDebuff()        return	false	end
function modifier_visible:IsPurgable() 		return	false	end
function modifier_visible:RemoveOnDeath() 	return	false	end