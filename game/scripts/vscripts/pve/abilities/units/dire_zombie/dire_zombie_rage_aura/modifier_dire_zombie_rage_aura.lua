modifier_dire_zombie_rage_aura = class({})

function modifier_dire_zombie_rage_aura:OnCreated(params)
    self.ms_buff_pct = self:GetAbility():GetSpecialValueFor("ms_buff_pct")
    self.as_speed = self:GetAbility():GetSpecialValueFor("as_speed")
    if IsServer() then
        self.efx = EFX("particles/econ/items/lycan/ti9_immortal/lycan_ti9_immortal_howl_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), {})
    end
end

function modifier_dire_zombie_rage_aura:OnDestroy()
    if IsServer() then
        DEFX(self.efx, false)
    end

end

function modifier_dire_zombie_rage_aura:DeclareFunctions()
    return { 
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }
end

function modifier_dire_zombie_rage_aura:GetModifierAttackSpeedBonus_Constant()
	return self.as_speed
end

function modifier_dire_zombie_rage_aura:GetModifierMoveSpeedBonus_Percentage(params)
    return self.ms_buff_pct
end

function modifier_dire_zombie_rage_aura:GetModifierPreAttack_BonusDamage()
    return self:GetAbility():GetSpecialValueFor("damage_bonus")
end
