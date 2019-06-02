modifier_axe_special_attack_debuff_lua = class({})

function modifier_axe_special_attack_debuff_lua:OnCreated()
    if IsServer() then

        local think_interval = 0.3--self:GetAbility():GetSpecialValueFor( "think_interval" )
        -- Start Interval
        self:StartIntervalThink( think_interval )   
    end
end

function modifier_axe_special_attack_debuff_lua:OnDestroy()
    if IsServer() then
        --Quits the animation
        local order = 
        {
            OrderType = DOTA_UNIT_ORDER_STOP,
            UnitIndex = self:GetParent():entindex()
        }
        ExecuteOrderFromTable(order)
    end
end

--------------------------------------------------------------------------------
function modifier_axe_special_attack_debuff_lua:OnIntervalThink()
    local parent = self:GetParent()
    local caster = self:GetCaster()
    local ability = parent:GetAbilityByIndex(0)

    parent:CastAbilityOnPosition(caster:GetOrigin(), ability, parent:GetPlayerOwnerID())
    parent:MoveToPosition(caster:GetOrigin())
   
end


--------------------------------------------------------------------------------
-- Status Effects
function modifier_axe_special_attack_debuff_lua:CheckState()
	local state = {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_axe_special_attack_debuff_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_beserkers_call.vpcf"
end
