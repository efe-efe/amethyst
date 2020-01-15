modifier_nevermore_souls = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_nevermore_souls:IsHidden()
	return false
end

function modifier_nevermore_souls:IsDebuff()
	return false
end

function modifier_nevermore_souls:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_nevermore_souls:OnCreated()
    self.damage_per_stack = self:GetAbility():GetSpecialValueFor( "damage_per_stack" )
	self.max_stacks = self:GetAbility():GetSpecialValueFor( "max_stacks" )
	
	if IsServer() then
	    self:SetStackCount(1)
		GameMode:UpdateHeroStacks(self:GetParent(), 1)
    end
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_nevermore_souls:OnRefresh()
	if IsServer() then

		if self:GetStackCount() < self.max_stacks then
			self:IncrementStackCount()
			GameMode:UpdateHeroStacks(self:GetParent(), self:GetStackCount())
		end
    end
end

function modifier_nevermore_souls:OnDestroy()
	if IsServer() then
		GameMode:UpdateHeroStacks(self:GetParent(), 0)
    end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_nevermore_souls:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}

	return funcs
end

function modifier_nevermore_souls:GetModifierPreAttack_BonusDamage()
    return self.damage_per_stack * self:GetStackCount()
end
