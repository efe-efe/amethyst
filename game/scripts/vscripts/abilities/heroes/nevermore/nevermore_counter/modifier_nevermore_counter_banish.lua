modifier_nevermore_counter_banish = class({})

function modifier_nevermore_counter_banish:OnDestroy()
    if IsServer() then
        local point = ClampPosition(self:GetParent():GetAbsOrigin(), CustomAbilitiesLegacy:GetCursorPosition(self:GetAbility()), self:GetAbility():GetCastRange(Vector(0,0,0), nil), nil)
        local delay = self:GetAbility():GetSpecialValueFor("delay_time")

        CreateModifierThinker(
            self:GetParent(), --hCaster
            self:GetAbility(), --hAbility
            "modifier_nevermore_counter_thinker", --modifierName
            { duration = delay + 0.2 },
            point, --vOrigin
            self:GetParent():GetTeamNumber(), --nTeamNumber
            false --bPhantomBlocker
       )
    
        self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_nevermore_counter_banish_no_indicator", { duration = delay })
    end
end

function modifier_nevermore_counter_banish:CheckState()
    return {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Banish(modifier_nevermore_counter_banish)