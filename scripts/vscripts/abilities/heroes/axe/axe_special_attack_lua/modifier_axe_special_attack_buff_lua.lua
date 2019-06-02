modifier_axe_special_attack_buff_lua = class({})

function modifier_axe_special_attack_buff_lua:OnCreated()
    if IsServer() then
        self.aspd_per_stack = 20

        local think_interval = 0.3--self:GetAbility():GetSpecialValueFor( "think_interval" )
        -- Start Interval
        self:StartIntervalThink( think_interval )   
    end
end

function modifier_axe_special_attack_buff_lua:OnDestroy()
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


function modifier_axe_special_attack_buff_lua:OnAttackLanded( params )
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
function modifier_axe_special_attack_buff_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}

	return funcs
end

function modifier_axe_special_attack_buff_lua:GetModifierIncomingDamage_Percentage( params )
	return -85
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_axe_special_attack_buff_lua:GetModifierAttackSpeedBonus_Constant()
    if IsServer() then
        if self.aspd_per_stack == nil then return 0 end
        return self:GetStackCount() * self.aspd_per_stack + 60
    end
end


--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_axe_special_attack_buff_lua:GetEffectName()
	return "particles/units/heroes/hero_axe/axe_beserkers_call.vpcf"
end

function modifier_axe_special_attack_buff_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end


