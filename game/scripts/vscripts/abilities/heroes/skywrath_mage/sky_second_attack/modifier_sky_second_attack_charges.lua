modifier_sky_second_attack_charges = class({})

modifier_sky_second_attack_charges.cooldowns = {}

--------------------------------------------------------------------------------
-- Classifications
function modifier_sky_second_attack_charges:IsHidden()
	return false
end

function modifier_sky_second_attack_charges:IsDebuff()
	return false
end

function modifier_sky_second_attack_charges:IsPurgable()
	return false
end

function modifier_sky_second_attack_charges:DestroyOnExpire()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_sky_second_attack_charges:OnCreated( kv )
	-- references
	self.max_charges = self:GetAbility():GetSpecialValueFor( "max_charges" ) -- special value
	self.reduction = 0.0

	self.cooldowns[self:GetParent()] = {0.0, 0.0, 0.0}

	if IsServer() then
		self:SetStackCount( self.max_charges )
		self:CalculateCharge()
	end
end

function modifier_sky_second_attack_charges:OnRefresh( kv )
	-- references
	self.max_charges = self:GetAbility():GetSpecialValueFor( "max_charges" ) -- special value

	if IsServer() then
		self:CalculateCharge()
	end
end

function modifier_sky_second_attack_charges:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_sky_second_attack_charges:OnIntervalThink()
	self:IncrementStackCount()
	self:StartIntervalThink(-1)
	self:CalculateCharge()
end

--Called When:
--	The ability is casted
--	One stack CD expires
function modifier_sky_second_attack_charges:CalculateCharge()
	self:GetAbility():EndCooldown()
	if self:GetStackCount()>=self.max_charges then
		-- stop charging
		self:SetDuration( -1, false )
		self:StartIntervalThink( -1 )
	else
		-- if not charging
		if self:GetRemainingTime() <= 0.05 then
			-- start charging
			local charge_time = self:GetAbility():GetCooldown( -1 ) - self.cooldowns[self:GetParent()][self:GetStackCount() + 1]
			self:StartIntervalThink( charge_time )
			self:SetDuration( charge_time, true )
		end

		-- set on cooldown if no charges
		if self:GetStackCount()==0 then
			self:GetAbility():StartCooldown( self:GetRemainingTime() )
		end
	end
end
