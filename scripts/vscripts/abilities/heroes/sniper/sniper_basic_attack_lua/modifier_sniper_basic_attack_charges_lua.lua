modifier_sniper_basic_attack_charges_lua = class({})

--- Misc 
function modifier_sniper_basic_attack_charges_lua:IsHidden()
    return false
end

function modifier_sniper_basic_attack_charges_lua:DestroyOnExpire()
    return false
end

function modifier_sniper_basic_attack_charges_lua:IsPurgable()
    return false
end

function modifier_sniper_basic_attack_charges_lua:RemoveOnDeath()
    return false
end

function modifier_sniper_basic_attack_charges_lua:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ABILITY_EXECUTED,
    }
    return funcs
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sniper_basic_attack_charges_lua:OnCreated( kv )
    --Initializers
    if IsServer() then
        
        self.max_charges = self:GetAbility():GetSpecialValueFor("max_charges")
        self.replenish_time = self:GetAbility():GetSpecialValueFor("replenish_time")

        self:SetStackCount(self.max_charges)
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_sniper_basic_attack_charges_lua:OnIntervalThink()
	self:SetStackCount(self.max_charges)
	self:StartIntervalThink(-1)
end

function modifier_sniper_basic_attack_charges_lua:CalculateCharge()
	if self:GetStackCount()>=self.max_charges then
		-- stop charging
		self:SetDuration( -1, false )
		self:StartIntervalThink( -1 )
	else
		-- if not charging
		if self:GetRemainingTime() <= 0.05 then
			self:StartIntervalThink( self.replenish_time )
			self:SetDuration( self.replenish_time, true )
		end

		-- set on cooldown if no charges
		if self:GetStackCount()==0 then
			self:GetAbility():StartCooldown( self:GetRemainingTime() )
		end
	end
end
