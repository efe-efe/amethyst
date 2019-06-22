modifier_phoenix_second_attack_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phoenix_second_attack_debuff:IsHidden()
	return false
end

function modifier_phoenix_second_attack_debuff:IsDebuff()
	return true
end

function modifier_phoenix_second_attack_debuff:IsStunDebuff()
	return false
end

function modifier_phoenix_second_attack_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initialization
function modifier_phoenix_second_attack_debuff:OnCreated()
    self.damage_per_second = self:GetAbility():GetSpecialValueFor( "damage_per_second" )

	if IsServer() then
		self:SetStackCount(1)
		self:StartIntervalThink( 1.0 )
		self:OnIntervalThink()
	end
end

--------------------------------------------------------------------------------
-- Initialization
function modifier_phoenix_second_attack_debuff:OnRefresh()

    self.damage_per_second = self:GetAbility():GetSpecialValueFor( "damage_per_second" )
	
	if IsServer() then
		self:IncrementStackCount()
		self:StartIntervalThink( 1.0 )
		self:OnIntervalThink()
	end
end

function modifier_phoenix_second_attack_debuff:OnStackCountChanged( old )
	if IsServer() then
		if self:GetStackCount()<1 then
			self:Destroy()
		end
	end
end

-- On Think
--------------------------------------------------------------------------------
function modifier_phoenix_second_attack_debuff:OnIntervalThink()
	if IsServer() then
		local damage = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = self.damage_per_second + 2 * self:GetStackCount(),
			damage_type = DAMAGE_TYPE_PURE,
		}

		ApplyDamage( damage )
	end
end