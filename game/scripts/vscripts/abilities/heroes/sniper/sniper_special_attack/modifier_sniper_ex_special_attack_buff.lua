
modifier_sniper_ex_special_attack_buff = class({})

function modifier_sniper_ex_special_attack_buff:OnCreated(params)
	self.ms_pct = self:GetAbility():GetSpecialValueFor("ms_pct")
	self.extra_damage = self:GetAbility():GetSpecialValueFor("extra_damage")

	if IsServer() then 
		self:StartIntervalThink(0.1)  

		self.efx = ParticleManager:CreateParticle("particles/sniper/sniper_ex_special_attack_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	end
end

function modifier_sniper_ex_special_attack_buff:OnDestroy()
	if IsServer() then 
		ParticleManager:DestroyParticle(self.efx, false)
		ParticleManager:ReleaseParticleIndex(self.efx)
	end
end

function modifier_sniper_ex_special_attack_buff:OnIntervalThink()
	if self:GetParent() == self:GetCaster() then
		self:GetParent():FindModifierByName('modifier_sniper_basic_attack_charges'):RefreshCharges()
	end
end

function modifier_sniper_ex_special_attack_buff:DeclareFunctions()
	return { 
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}
end

function modifier_sniper_ex_special_attack_buff:GetModifierPreAttack_BonusDamage()
	if self:GetAbility():GetLevel() >= 2 then
		return self.extra_damage
	end
end

function modifier_sniper_ex_special_attack_buff:GetModifierMoveSpeedBonus_Percentage()
    return self.ms_pct
end