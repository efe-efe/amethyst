modifier_channeling = class({})

function modifier_channeling:OnCreated(params)
    if IsServer() then
        if self:GetAbility().OnChannelingStart then
            self:GetAbility():OnChannelingStart()
        end

        self.movement_speed = params.movement_speed
        local style = params.style or ""
        local title = params.title or "Channeling"
        local channeling_tick = params.channeling_tick or 1.0
        local immediate = params.immediate and true or false

        CustomEntitiesLegacy:SetAllAbilitiesActivated(self:GetParent(), false)

        self:StartIntervalThink(channeling_tick)
        if immediate then
            self:OnIntervalThink()
        end

        self:GetParent():AddStatusBar({
			label = title, modifier = self, priority = 6, stylename= style
		})
    end
end

function modifier_channeling:OnDestroy()
    if IsServer() then
        if self:GetAbility().OnChannelingEnd then
            self:GetAbility():OnChannelingEnd()
        end
        CustomEntitiesLegacy:SetAllAbilitiesActivated(self:GetParent(), true)
    end
end


function modifier_channeling:OnIntervalThink()
    if self:GetAbility().OnChannelingTick then
        self:GetAbility():OnChannelingTick()
    end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_channeling:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_EVENT_ON_ORDER,
	}

	return funcs
end

function modifier_channeling:GetModifierMoveSpeedBonus_Percentage()
	if self.movement_speed ~= nil and self.movement_speed ~= 0 then
		return - (100 - self.movement_speed)
	end
end

function modifier_channeling:OnOrder(params)
	if params.unit==self:GetParent() then
		if 	params.order_type == DOTA_UNIT_ORDER_HOLD_POSITION or
			params.order_type == DOTA_UNIT_ORDER_CAST_POSITION or
			params.order_type == DOTA_UNIT_ORDER_CAST_TARGET or
			params.order_type == DOTA_UNIT_ORDER_CAST_TARGET_TREE or
			params.order_type == DOTA_UNIT_ORDER_CAST_NO_TARGET or
			params.order_type == DOTA_UNIT_ORDER_CAST_TOGGLE
		then
			self:Destroy()
		end
	end
end


--------------------------------------------------------------------------------
-- Status Effects
function modifier_channeling:CheckState()
    if self.movement_speed == 0 then
        return { [MODIFIER_STATE_ROOTED] = true }
    else
        return {}
    end
end
