modifier_spectre_ultimate = class({})

function modifier_spectre_ultimate:OnCreated(params)
    self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")

    if IsServer() then
        self.damage_table = {
            victim = self:GetParent(),
            attacker = self:GetCaster(),
            damage = self:GetAbility():GetSpecialValueFor("ability_damage"),
            damage_type = DAMAGE_TYPE_PURE
        }

        if self:GetCaster():IsAlly(self:GetParent()) then
            self:SetStackCount(1)
        else
            self:SetStackCount(2)
        end
    end
end

function modifier_spectre_ultimate:OnDestroy()
    if IsServer() then
        if self:IsDebuff() then
            if self:GetStackCount() == 2 then
                EmitSoundOn("Hero_Spectre.DaggerImpact", self:GetParent())
                self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_spectre_special_attack_debuff", { 
                    duration = 5.0
                })
                self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_fading_slow", { 
                    duration = 5.0,
                    max_slow_pct = 50
                })

                if IsServer() then
                    ApplyDamage(self.damage_table)
                end
            end
        end
    end
end

function modifier_spectre_ultimate:IsDebuff()
    return self:GetStackCount() >= 2
end

function modifier_spectre_ultimate:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_BONUS_VISION_PERCENTAGE,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end

function modifier_spectre_ultimate:GetBonusVisionPercentage()
    if self:IsDebuff() then
        return -80
    end
    return 0
end

function modifier_spectre_ultimate:GetModifierPreAttack_BonusDamage()
    if not self:IsDebuff() then
        return self.bonus_damage
    end
end
