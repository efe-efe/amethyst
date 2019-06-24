modifier_axe_special_attack_buff = class({})

--------------------------------------------------------------------------------
-- Initializer
function modifier_axe_special_attack_buff:OnCreated()
    self.aspd_per_stack = self:GetAbility():GetSpecialValueFor( "aspd_per_stack" )
    self.damage_reduction = -self:GetAbility():GetSpecialValueFor( "damage_reduction" )
    
    if IsServer() then

        local think_interval = 0.3--self:GetAbility():GetSpecialValueFor( "think_interval" )
        -- Start Interval
        self:StartIntervalThink( think_interval )   
    end
end

--------------------------------------------------------------------------------
-- Destructor
function modifier_axe_special_attack_buff:OnDestroy()
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


function modifier_axe_special_attack_buff:OnAttackLanded( params )
	if IsServer() then
		if params.target~=self:GetParent() then return end
		--if self:GetCaster():PassivesDisabled() then return end
		if params.attacker:GetTeamNumber()==params.target:GetTeamNumber() then return end
		--if params.attacker:IsOther() or params.attacker:IsBuilding() then return end

	    self:IncrementStackCount()
	end
end


--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_axe_special_attack_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}

	return funcs
end

function modifier_axe_special_attack_buff:GetModifierIncomingDamage_Percentage( params )
	return self.damage_reduction
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_axe_special_attack_buff:GetModifierAttackSpeedBonus_Constant()
    if self.aspd_per_stack == nil then return 0 end
    return self:GetStackCount() * self.aspd_per_stack + 60
end


--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_axe_special_attack_buff:GetEffectName()
	return "particles/units/heroes/hero_axe/axe_beserkers_call.vpcf"
end

function modifier_axe_special_attack_buff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end


