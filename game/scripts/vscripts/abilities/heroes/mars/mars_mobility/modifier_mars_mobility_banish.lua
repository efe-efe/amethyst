modifier_mars_mobility_banish = class({})

function modifier_mars_mobility_banish:OnDestroy()
    if IsServer() then
        local point = Clamp(self:GetParent():GetAbsOrigin(), self:GetAbility():GetCursorPosition(), self:GetAbility():GetCastRange(Vector(0,0,0), nil), nil)
        local delay = self:GetAbility():GetSpecialValueFor("delay_time")

    end
end

function modifier_mars_mobility_banish:CheckState()
    return {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Banish(modifier_mars_mobility_banish) 