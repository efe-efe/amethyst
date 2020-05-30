modifier_banish = class({})

function modifier_banish:isHidden() return true end

function modifier_banish:OnCreated(params)
    if IsServer() then
        if params.disable == nil then
            self:SetStackCount(1)
        else
            self:SetStackCount(0)
        end
        self:GetParent():AddNoDraw()
    end
end

function modifier_banish:OnDestroy()
    if IsServer() then
        self:GetParent():RemoveNoDraw()
    end
end

function modifier_banish:CheckState()
    local state = {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = self:GetStackCount() == 1 and true or false,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
    }

    return state
end

function modifier_banish:IsStunDebuff()
    return true
end