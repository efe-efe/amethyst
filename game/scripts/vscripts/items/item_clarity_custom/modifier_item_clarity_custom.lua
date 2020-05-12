modifier_item_clarity_custom = class({})

function modifier_item_clarity_custom:OnCreated()
    self.think_interval = self:GetAbility():GetSpecialValueFor("think_interval")
    self.mana_per_tick = self:GetAbility():GetSpecialValueFor("mana_per_tick")
    
    if IsServer() then
        self:StartIntervalThink( self.think_interval )
    end
end

function modifier_item_clarity_custom:OnIntervalThink()
    self:GetParent():GiveMana(self.mana_per_tick)
end

function modifier_item_clarity_custom:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

function modifier_item_clarity_custom:GetModifierIncomingDamage_Percentage( params )
	if IsServer() then
		self:Destroy()	
        return 0
	end
end

function modifier_item_clarity_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_clarity_custom:GetStatusEffectName()
	return "particles/items_fx/healing_clarity.vpcf"
end


