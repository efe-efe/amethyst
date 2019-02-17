modifier_wisp_mobility_lua = class({})


--------------------------------------------------------------------------------
-- Classifications
function modifier_wisp_mobility_lua:IsHidden()
	return false
end

function modifier_wisp_mobility_lua:IsDebuff()
	return false
end

function modifier_wisp_mobility_lua:IsPurgable()
	return false
end

function modifier_wisp_mobility_lua:OnCreated( kv )
end

function modifier_wisp_mobility_lua:OnDestroy( )
	if IsServer() then
		-- Swap abilities back to normality
		self:GetCaster():SwapAbilities( 
			self:GetAbility():GetAbilityName(),
			"wisp_mobility_back_lua",
			true,
			false
		)
	end
end