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
        -- Start Interval
    end
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_nevermore_souls:OnRefresh()
    self.damage_per_stack = self:GetAbility():GetSpecialValueFor( "damage_per_stack" )
    self.max_stacks = self:GetAbility():GetSpecialValueFor( "max_stacks" )

    if IsServer() then
	    self:IncrementStackCount()
        -- Start Interval
    end
end

function modifier_nevermore_souls:OnStackCountChanged( old )
	if IsServer() then
		if self:GetStackCount() < 1 then
			self:Destroy()
		end
		if self:GetStackCount() > self.max_stacks then
			self:SetStackCount(self.max_stacks)
		end
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
