modifier_dire_zombie_rage_aura = class({})

function modifier_dire_zombie_rage_aura:OnCreated(params)
    self.speed_buff_pct = 25
    self.as_speed = 100
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
    return self.speed_buff_pct
end

function modifier_dire_zombie_rage_aura:GetModifierPreAttack_BonusDamage()
    return self:GetAbility():GetSpecialValueFor("damage_bonus")
end
