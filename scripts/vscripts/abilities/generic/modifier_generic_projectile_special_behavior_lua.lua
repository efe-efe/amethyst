modifier_generic_projectile_special_behavior_lua = class({})


function modifier_generic_projectile_special_behavior_lua:OnDestroy( kv )
    if IsServer() then
	end
end


--------------------------------------------------------------------------------
-- Status Effects
function modifier_generic_projectile_special_behavior_lua:CheckState()
	local state = {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}

	return state
end
