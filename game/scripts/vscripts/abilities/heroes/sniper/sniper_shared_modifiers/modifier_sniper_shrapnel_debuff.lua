
modifier_sniper_shrapnel_debuff = class({})

function modifier_sniper_shrapnel_debuff:IsHidden() 	return 	false 	end
function modifier_sniper_shrapnel_debuff:IsDebuff() 	return 	true 	end
function modifier_sniper_shrapnel_debuff:IsPurgable() 	return 	false 	end

function modifier_sniper_shrapnel_debuff:OnCreated( kv )
	self.slow_pct = -self:GetAbility():GetSpecialValueFor("slow_pct")
	self.damage_per_think = self:GetAbility():GetSpecialValueFor("damage_per_think")
	self.think_interval = self:GetAbility():GetSpecialValueFor("think_interval")

	if IsServer() then 
		self.damage_table = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = self.damage_per_think,
			damage_type = DAMAGE_TYPE_PURE,
		}

		self:StartIntervalThink( self.think_interval )  
	end
end

function modifier_sniper_shrapnel_debuff:OnIntervalThink()
	ApplyDamage( self.damage_table )
end

function modifier_sniper_shrapnel_debuff:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end

function modifier_sniper_shrapnel_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self.slow_pct
end