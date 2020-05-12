modifier_generic_fading_slow = class({})

function modifier_generic_fading_slow:IsDebuff() return true end

function modifier_generic_fading_slow:OnCreated( params )
    if IsServer() then
        local duration = self:GetDuration()
        local tick = 1/8
        local ticks_number = duration / tick

        self.speed_per_tick = params.max_slow_pct / ticks_number

        self:SetStackCount(params.max_slow_pct)
        self:StartIntervalThink( tick )
    end
end

function modifier_generic_fading_slow:OnIntervalThink()
    local new_fading_slow = self:GetStackCount() - self.speed_per_tick

    if new_fading_slow < 0 then
        self:SetStackCount(0)
        return
    end
    self:SetStackCount(new_fading_slow)
end

function modifier_generic_fading_slow:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE, }
end

function modifier_generic_fading_slow:GetModifierMoveSpeedBonus_Percentage()
    return -self:GetStackCount()
end

function modifier_generic_fading_slow:GetEffectName()
    return "particles/generic_gameplay/rune_haste.vpcf"
end

function modifier_generic_fading_slow:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_generic_fading_slow:GetTexture()
	return "modifier_fading_slow"
end

function modifier_generic_fading_slow:GetStatusLabel() return "Fading slow" end
function modifier_generic_fading_slow:GetStatusPriority() return 2 end
function modifier_generic_fading_slow:GetStatusStyle() return "Slow" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_generic_fading_slow)