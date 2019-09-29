modifier_generic_fading_slow_lua = class({})

-- Clasifications
--------------------------------------------------------------------------------
function modifier_generic_fading_slow_lua:IsDebuff()
	return true
end

function modifier_generic_fading_slow_lua:IsStunDebuff()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_fading_slow_lua:OnCreated( kv )
    self.duration = self:GetDuration()
    self.fading_slow = -self:GetAbility():GetSpecialValueFor("fading_slow")
    self.speed_per_tick = self.fading_slow / self.duration

    if IsServer() then 
        self:StartIntervalThink( 0.5 )

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
function modifier_generic_fading_slow_lua:OnIntervalThink()
    local new_fading_slow = self.fading_slow - self.speed_per_tick / 2

    if new_fading_slow > 0 then
        self.fading_slow = 0
        return
    end
    self.fading_slow = new_fading_slow
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_fading_slow_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_generic_fading_slow_lua:GetModifierMoveSpeedBonus_Percentage()
    return self.fading_slow
end

--------------------------------------------------------------------------------
--Graphics

function modifier_generic_fading_slow_lua:GetEffectName()
	return "particles/generic_gameplay/rune_haste.vpcf"
end

function modifier_generic_fading_slow_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_generic_fading_slow_lua:GetTexture()
	return "modifier_generic_fading_slow_lua"
end