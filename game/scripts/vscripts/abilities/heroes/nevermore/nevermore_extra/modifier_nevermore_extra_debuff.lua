modifier_nevermore_extra_debuff = class({})

function modifier_nevermore_extra_debuff:IsHidden() 	return 	false 	end
function modifier_nevermore_extra_debuff:IsDebuff() 	return 	true 	end
function modifier_nevermore_extra_debuff:IsPurgable() 	return 	false 	end

function modifier_nevermore_extra_debuff:OnCreated(params)
	self.slow_pct = -self:GetAbility():GetSpecialValueFor("slow_pct")
	self.think_interval = self:GetAbility():GetSpecialValueFor("think_interval")

    if IsServer() then
        local multiplier = self:GetCaster():FindModifierByName('modifier_nevermore_extra'):GetStackCount()
        local damage_per_think = self:GetAbility():GetSpecialValueFor("damage_per_think")
        local damage_per_soul = self:GetAbility():GetSpecialValueFor("damage_per_soul")
        local damage = damage_per_think + damage_per_soul * multiplier
        
		self.damage_table = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = DAMAGE_TYPE_PURE,
		}

		self:StartIntervalThink(self.think_interval)  
	end
end

function modifier_nevermore_extra_debuff:OnIntervalThink()
	ApplyDamage(self.damage_table)
end

function modifier_nevermore_extra_debuff:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end

function modifier_nevermore_extra_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self.slow_pct
end