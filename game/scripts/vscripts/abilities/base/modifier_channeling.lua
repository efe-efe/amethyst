modifier_channeling = class({})

function modifier_channeling:OnCreated(params)
    if IsServer() then
        self.movement_speed = params.movement_speed
        local style = params.style or "Generic"
        local title = params.title or "channeling"
        local channeling_tick = params.channeling_tick or 1.0
        local immediate = params.immediate and true or false

        self:GetParent():SetAllAbilitiesActivated( false )

        self:StartIntervalThink(channeling_tick)
        if immediate then
            self:OnIntervalThink()
        end

        ProgressBars:AddProgressBar(self:GetParent(), self:GetName(), {
            style = style,
            text = title,
            progressBarType = "duration",
            priority = 0,
        })
    end
end

function modifier_channeling:OnDestroy()
    if IsServer() then
        if self:GetAbility().OnChannelingEnd then
            self:GetAbility():OnChannelingEnd()
        end
        self:GetParent():SetAllAbilitiesActivated( true )
    end
end


function modifier_channeling:OnIntervalThink()
    self:GetAbility():OnChannelingTick()
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