modifier_generic_sleep_lua = class({})

-- Classifiactions
--------------------------------------------------------------------------------
function modifier_generic_sleep_lua:IsDebuff()
	return true
end

function modifier_generic_sleep_lua:IsStunDebuff()
	return true
end

--------------------------------------------------------------------------------
function modifier_generic_sleep_lua:CheckState()
	local state = {
		[MODIFIER_STATE_NIGHTMARED] = true,
		--[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_sleep_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_generic_sleep_lua:OnTakeDamage( params )
	if not IsServer() then return end
		-- filter
		if params.unit==self:GetParent() then
			self:Destroy()
		end
end

--------------------------------------------------------------------------------
-- Graphics

function modifier_generic_sleep_lua:GetEffectName()
	return "particles/generic_gameplay/generic_sleep.vpcf"
end

function modifier_generic_sleep_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_generic_sleep_lua:GetOverrideAnimation()
	return ACT_DOTA_DISABLED
end

function modifier_generic_sleep_lua:GetTexture()
	return "modifier_generic_sleep_lua"
end