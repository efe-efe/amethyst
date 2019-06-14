modifier_axe_special_attack_debuff_lua = class({})

function modifier_axe_special_attack_debuff_lua:OnCreated()
    if IsServer() then

        --local attacks_per_second = self:GetParent():GetAttacksPerSecond()
        --local attack_speed = ( 1 / attacks_per_second )
        --local ability = self:GetParent():GetAbilityByIndex(0)
        --local cast_point = ability:GetCastPoint()

        --local think_interval = 0.3--self:GetAbility():GetSpecialValueFor( "think_interval" )
        -- Start Interval
        self:StartIntervalThink( 0.1 )   
        self:OnIntervalThink()
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

    if ability:IsFullyCastable() and not parent:IsSilenced() then
        parent:CastAbilityOnPosition(caster:GetOrigin(), ability, parent:GetPlayerOwnerID())
    end
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
