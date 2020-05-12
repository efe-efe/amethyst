modifier_generic_projectile_special_behavior = class({})


function modifier_generic_projectile_special_behavior:OnDestroy( kv )
	if IsServer() then
		self:GetParent():Kill(nil, nil)
	end
end


--------------------------------------------------------------------------------
-- Status Effects
function modifier_generic_projectile_special_behavior:CheckState()
	local state = {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}

	return state
end
