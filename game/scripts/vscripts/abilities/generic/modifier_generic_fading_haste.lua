modifier_generic_fading_haste = class({})

-- Clasifications
--------------------------------------------------------------------------------
function modifier_generic_fading_haste:IsDebuff()
	return false
end

function modifier_generic_fading_haste:IsHidden()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_fading_haste:OnCreated( kv )
    local duration = self:GetDuration()
    self.max_fading_haste = self:GetAbility():GetSpecialValueFor("fading_haste")
    self.fading_haste = 0

    local tick = 1/4
    local ticks_number = duration / tick
    self.counter = 0
    self.speed_per_tick = self.max_fading_haste / ticks_number
    self.effect_name = kv.effect_name or false
    
    self:StartIntervalThink( tick )

    if IsServer() then 
		self:GetParent():AddStatusBar({
			label = "Fading Haste", modifier = self, priority = 2, 
		}) 
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_generic_fading_haste:OnIntervalThink()
    local new_fading_haste =  self.max_fading_haste - self.speed_per_tick * self.counter

    if new_fading_haste < 0 then
        self.fading_haste = 0
        return
    end

    self.fading_haste = new_fading_haste
    self.counter = self.counter + 1
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_fading_haste:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_generic_fading_haste:GetModifierMoveSpeedBonus_Percentage()
    return self.fading_haste
end

--------------------------------------------------------------------------------
--Graphics
function modifier_generic_fading_haste:GetEffectName()
    if self.effect_name == false then
        return "particles/generic_gameplay/rune_haste.vpcf"
    else
        return self.effect_name
    end
end

function modifier_generic_fading_haste:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_generic_fading_haste:GetTexture()
	return "modifier_generic_fading_haste"
end

