modifier_generic_pseudo_cast_point_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_pseudo_cast_point_lua:IsHidden()
	return true
end

function modifier_generic_pseudo_cast_point_lua:IsDebuff()
	return true
end

function modifier_generic_pseudo_cast_point_lua:IsStunDebuff()
	return false
end

function modifier_generic_pseudo_cast_point_lua:IsPurgable()
	return true
end


function modifier_generic_pseudo_cast_point_lua:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ORDER,
    }
    return funcs
end

function modifier_generic_pseudo_cast_point_lua:OnOrder(params)
	if params.unit==self:GetParent() then
		if params.order_type == 10 then
			self:Destroy()
		end
	end
end

function modifier_generic_pseudo_cast_point_lua:OnDestroy(params)
	local ability = self:GetAbility()
	--Destroyed before it duration ends
	if self:GetRemainingTime() >= 0.05 then
		if ability.OnStopPseudoCastPoint ~= nil then
			ability:OnStopPseudoCastPoint()
		end
		if IsServer() then
			GameRules.EndAnimation(self:GetParent())
			ability:EndCooldown()
		end
	else
		if ability.OnEndPseudoCastPoint ~= nil then
			if IsServer() then
				ability:OnEndPseudoCastPoint()
			end
		end
	end
end

--------------------------------------------------------------------------------
-- Modifier State
function modifier_generic_pseudo_cast_point_lua:CheckState()
	local state = {
		[MODIFIER_STATE_SILENCED] = true,
	}

	return state
end