modifier_generic_fading_haste = class({})

function modifier_generic_fading_haste:IsDebuff() return false end

function modifier_generic_fading_haste:OnCreated(params)
    if IsServer() then
        local duration = self:GetDuration()
        local tick = 1/8
        local ticks_number = duration / tick

        self.speed_per_tick = params.max_haste_pct / ticks_number

        self:SetStackCount(params.max_haste_pct)
        self:StartIntervalThink(tick)
    end
end

function modifier_generic_fading_haste:OnIntervalThink()
    local new_fading_haste = self:GetStackCount() - self.speed_per_tick

    if new_fading_haste < 0 then
        self:SetStackCount(0)
        return
    end
    self:SetStackCount(new_fading_haste)
end

function modifier_generic_fading_haste:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE, }
end

function modifier_generic_fading_haste:GetModifierMoveSpeedBonus_Percentage()
    return self:GetStackCount()
end

function modifier_generic_fading_haste:GetEffectName()
    return "particles/generic_gameplay/rune_haste.vpcf"
end

function modifier_generic_fading_haste:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_generic_fading_haste:GetTexture()
	return "modifier_generic_fading_haste"
end

function modifier_generic_fading_haste:GetStatusLabel() return "Fading Haste" end
function modifier_generic_fading_haste:GetStatusPriority() return 3 end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_generic_fading_haste)