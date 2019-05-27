modifier_phantom_assassin_strike_stack_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phantom_assassin_strike_stack_lua:IsHidden()
	return false
end

function modifier_phantom_assassin_strike_stack_lua:IsDebuff()
	return true
end

function modifier_phantom_assassin_strike_stack_lua:IsStunDebuff()
	return false
end

function modifier_phantom_assassin_strike_stack_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_phantom_assassin_strike_stack_lua:OnCreated( kv )
	-- references
	if IsServer() then
		self:SetStackCount(1)
	end
end

function modifier_phantom_assassin_strike_stack_lua:OnRefresh( kv )
	-- references
	local max_stack = 3--self:GetAbility():GetSpecialValueFor( "stack_limit" )

	if IsServer() then
		if self:GetStackCount()<max_stack then
			self:IncrementStackCount()
		end
	end
end

function modifier_phantom_assassin_strike_stack_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_phantom_assassin_strike_stack_lua:DeclareFunctions()
	local funcs = {
	}

	return funcs
end