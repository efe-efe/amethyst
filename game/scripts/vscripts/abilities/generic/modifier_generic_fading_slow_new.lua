modifier_generic_fading_slow_new = class({})

-- Clasifications
--------------------------------------------------------------------------------
function modifier_generic_fading_slow_new:IsDebuff()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_fading_slow_new:OnCreated( params )
    if IsServer() then
        local duration = self:GetDuration()
        local tick = 1/8
        local ticks_number = duration / tick

        self.speed_per_tick = params.max_slow_pct / ticks_number

        self:SetStackCount(params.max_slow_pct)
        self:StartIntervalThink( tick )
        self:GetParent():AddStatusBar({ label = "Fading slow", modifier = self, priority = 2, stylename="Slow" }) 
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_generic_fading_slow_new:OnIntervalThink()
    local new_fading_slow = self:GetStackCount() - self.speed_per_tick

    if new_fading_slow < 0 then
        self:SetStackCount(0)
        return
    end
    self:SetStackCount(new_fading_slow)
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_fading_slow_new:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_generic_fading_slow_new:GetModifierMoveSpeedBonus_Percentage()
    return -self:GetStackCount()
end

--------------------------------------------------------------------------------
--Graphics
function modifier_generic_fading_slow_new:GetEffectName()
    return "particles/generic_gameplay/rune_haste.vpcf"
end

function modifier_generic_fading_slow_new:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_generic_fading_slow_new:GetTexture()
	return "modifier_generic_fading_slow"
end

