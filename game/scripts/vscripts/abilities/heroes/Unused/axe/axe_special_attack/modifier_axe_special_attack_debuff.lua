modifier_axe_special_attack_debuff = class({})

function modifier_axe_special_attack_debuff:OnCreated()
    if IsServer() then

        self.ability = self:GetParent():GetAbilityByIndex(1)

        -- Start Interval
        self:StartIntervalThink(0.1)   
        self:OnIntervalThink()

        ProgressBars:AddProgressBar(self:GetParent(), self:GetName(), {
			style = "Taunt",
			text = "Taunt",
			progressBarType = "duration",
			priority = 1,
		})
    end
end

function modifier_axe_special_attack_debuff:OnDestroy()
    if IsServer() then
        --Quits the animation
        local order = 
        {
            OrderType = DOTA_UNIT_ORDER_STOP,
            UnitIndex = self:GetParent():entindex()
        }
        ExecuteOrderFromTable(order)

        self.ability.force_position = nil
    end
end

--------------------------------------------------------------------------------
function modifier_axe_special_attack_debuff:OnIntervalThink()
    local parent = self:GetParent()
    local caster = self:GetCaster()

    if self.ability:IsFullyCastable() and not parent:IsSilenced() and not self.ability:IsInAbilityPhase() then
        self.ability.force_position = caster:GetOrigin()
        parent:CastAbilityOnPosition(caster:GetOrigin(), self.ability, parent:GetPlayerOwnerID())
    end
    parent:MoveToPosition(caster:GetOrigin())
end


--------------------------------------------------------------------------------
-- Status Effects
function modifier_axe_special_attack_debuff:CheckState()
	local state = {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_axe_special_attack_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_beserkers_call.vpcf"
end
