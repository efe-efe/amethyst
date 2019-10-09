modifier_generic_fading_slow = class({})

-- Clasifications
--------------------------------------------------------------------------------
function modifier_generic_fading_slow:IsDebuff()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_fading_slow:OnCreated( kv )
    local duration = self:GetDuration()
    self.max_fading_slow = self:GetAbility():GetSpecialValueFor("fading_slow")
    self.fading_slow = -self:GetAbility():GetSpecialValueFor("fading_slow")

    local tick = 1/4
    local ticks_number = duration / tick
    self.counter = 0
    self.speed_per_tick = self.max_fading_slow / ticks_number
    self.effect_name = kv.effect_name or false
    
    self:StartIntervalThink( tick )

    if IsServer() then 
        ProgressBars:AddProgressBar(self:GetParent(), self:GetName(), {
            style = "Generic",
            text = "fading slow",
            progressBarType = "duration",
            priority = 2,
        })
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_generic_fading_slow:OnIntervalThink()
    local new_fading_slow = self.fading_slow + self.speed_per_tick * self.counter

    if new_fading_slow > 0 then
        self.fading_slow = 0
        return
    end
    self.fading_slow = new_fading_slow
    self.counter = self.counter + 1
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_fading_slow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_generic_fading_slow:GetModifierMoveSpeedBonus_Percentage()
    return self.fading_slow
end

--------------------------------------------------------------------------------
--Graphics
function modifier_generic_fading_slow:GetEffectName()
    if self.effect_name == false then
        return "particles/generic_gameplay/rune_haste.vpcf"
    else
        return self.effect_name
    end
end

function modifier_generic_fading_slow:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_generic_fading_slow:GetTexture()
	return "modifier_generic_fading_slow"
end

