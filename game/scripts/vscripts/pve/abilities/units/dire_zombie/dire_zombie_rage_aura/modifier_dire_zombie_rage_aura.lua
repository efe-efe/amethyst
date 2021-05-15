modifier_dire_zombie_rage_aura = class({})

function modifier_dire_zombie_rage_aura:OnCreated(params)
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
    }
end

function modifier_dire_zombie_rage_aura:GetModifierPreAttack_BonusDamage()
    return self:GetAbility():GetSpecialValueFor("damage_bonus")
end
