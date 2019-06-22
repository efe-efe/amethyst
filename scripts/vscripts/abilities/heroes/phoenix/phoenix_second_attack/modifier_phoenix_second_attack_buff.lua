modifier_phoenix_second_attack_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phoenix_second_attack_buff:IsHidden()
	return false
end

function modifier_phoenix_second_attack_buff:IsDebuff()
	return false
end

function modifier_phoenix_second_attack_buff:IsStunDebuff()
	return false
end

function modifier_phoenix_second_attack_buff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initialization
function modifier_phoenix_second_attack_buff:OnCreated()
    self.heal_per_second = self:GetAbility():GetSpecialValueFor( "heal_per_second" )

	if IsServer() then
		self:SetStackCount(1)
		self:StartIntervalThink( 1.0 )
		self:OnIntervalThink()
	end
end

--------------------------------------------------------------------------------
-- Initialization
function modifier_phoenix_second_attack_buff:OnRefresh()

    self.heal_per_second = self:GetAbility():GetSpecialValueFor( "heal_per_second" )
	
	if IsServer() then
		self:IncrementStackCount()
		self:StartIntervalThink( 1.0 )
		self:OnIntervalThink()
	end
end

-- On Think
--------------------------------------------------------------------------------
function modifier_phoenix_second_attack_buff:OnIntervalThink()
	if IsServer() then
		self:GetParent():Heal(self.heal_per_second +  2 * self:GetStackCount(), self:GetCaster())
	end
end