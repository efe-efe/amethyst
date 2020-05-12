modifier_ancient_basic_attack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_ancient_basic_attack:IsHidden() return false
end

function modifier_ancient_basic_attack:IsDebuff() return false
end

function modifier_ancient_basic_attack:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_ancient_basic_attack:OnCreated()
    self.ms_pct_per_stack = self:GetAbility():GetSpecialValueFor( "ms_pct_per_stack" )
    self.max_stacks = self:GetAbility():GetSpecialValueFor( "max_stacks" )
    self.duration = self:GetAbility():GetSpecialValueFor("duration")

    if IsServer() then
        self:SetStackCount(1)
        self:StartIntervalThink(self.duration)
		self:GetParent():AddStacksVisual({ modifier = self })
        -- Start Interval
    end
end

function modifier_ancient_basic_attack:OnRefresh()
    self.ms_pct_per_stack = self:GetAbility():GetSpecialValueFor( "ms_pct_per_stack" )
    self.max_stacks = self:GetAbility():GetSpecialValueFor( "max_stacks" )
    self.duration = self:GetAbility():GetSpecialValueFor("duration")

    if IsServer() then
	    self:IncrementStackCount()
        self:StartIntervalThink(self.duration)
        -- Start Interval
    end
end

function modifier_ancient_basic_attack:OnDestroy()
    if IsServer() then
		
    end
end

function modifier_ancient_basic_attack:OnIntervalThink()
    self:DecrementStackCount()
end

function modifier_ancient_basic_attack:OnStackCountChanged( old )
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
function modifier_ancient_basic_attack:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}

	return funcs
end

function modifier_ancient_basic_attack:GetModifierMoveSpeedBonus_Percentage()
    return self.ms_pct_per_stack * self:GetStackCount()
end
