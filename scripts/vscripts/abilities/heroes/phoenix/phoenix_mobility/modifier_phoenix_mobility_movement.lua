modifier_phoenix_mobility_movement = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phoenix_mobility_movement:IsHidden()
	return false
end

function modifier_phoenix_mobility_movement:IsDebuff()
	return false
end

function modifier_phoenix_mobility_movement:IsStunDebuff()
	return false
end

function modifier_phoenix_mobility_movement:IsPurgable()
	return false
end

function modifier_phoenix_mobility_movement:OnDestroy()
	if IsServer() then
		-- Swap abilities back to normality
		self:GetParent():SwapAbilities( 
			"phoenix_mobility",
			"phoenix_mobility_stop",
			true,
			false
		)
	end
end

-- Status Effects
function modifier_phoenix_mobility_movement:CheckState()
	local state = {
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end