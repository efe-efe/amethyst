modifier_item_nullifier_custom = class({})

function modifier_item_nullifier_custom:OnCreated()
    if IsServer() then
        self:GetParent():Purge(true, false, false, false, false)
    end
end

function modifier_item_nullifier_custom:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

function modifier_item_nullifier_custom:GetModifierIncomingDamage_Percentage( params )
    if IsServer() then
        self:GetParent():AddNewModifier(
            self:GetCaster(), 
            self:GetAbility(), 
            "modifier_item_nullifier_custom_slow", 
            { duration = self:GetAbility():GetSpecialValueFor("tick_duration") })

        self:GetParent():Purge(true, false, false, false, false)
        return 0
	end
end

function modifier_item_nullifier_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_nullifier.vpcf"
end
