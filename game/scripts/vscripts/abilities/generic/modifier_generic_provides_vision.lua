modifier_generic_provides_vision = class({})

--------------------------------------------------------------------------------

function modifier_generic_provides_vision:IsDebuff()
	return false
end

function modifier_generic_provides_vision:IsHidden()
	return true
end

function modifier_generic_provides_vision:IsPurgable()
	return false
end

function modifier_generic_provides_vision:OnCreated(params)
	if IsServer() then
		self:StartIntervalThink(0.05)
	end
end

function modifier_generic_provides_vision:OnIntervalThink()
	AddFOWViewer( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), self:GetParent():GetCurrentVisionRange(), 0.05, true )
end
