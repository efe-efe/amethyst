modifier_spectre_banish = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_spectre_banish:IsHidden() return false
end

function modifier_spectre_banish:IsDebuff() return false
end

function modifier_spectre_banish:IsPurgable() return false
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_spectre_banish:CheckState()
	local state = {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_banish:OnCreated( kv )
	if IsServer() then
		self:GetParent():AddNoDraw()
	end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_spectre_banish:OnDestroy( kv )
	if IsServer() then
		self:GetParent():RemoveNoDraw()
	end
end
