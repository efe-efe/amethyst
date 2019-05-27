modifier_skywrath_mage_second_attack_charges_lua = class({})

modifier_skywrath_mage_second_attack_charges_lua.cooldowns = {}

--------------------------------------------------------------------------------
-- Classifications
function modifier_skywrath_mage_second_attack_charges_lua:IsHidden()
	return false
end

function modifier_skywrath_mage_second_attack_charges_lua:IsDebuff()
	return false
end

function modifier_skywrath_mage_second_attack_charges_lua:IsPurgable()
	return false
end

function modifier_skywrath_mage_second_attack_charges_lua:DestroyOnExpire()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_skywrath_mage_second_attack_charges_lua:OnCreated( kv )
	-- references
	self.max_charges = self:GetAbility():GetSpecialValueFor( "max_charges" ) -- special value
	self.reduction = 0.0

	self.cooldowns[self:GetParent()] = {0.0, 0.0, 0.0}

	if IsServer() then
		self:SetStackCount( self.max_charges )
		self:CalculateCharge()
	end
end

function modifier_skywrath_mage_second_attack_charges_lua:OnRefresh( kv )
	-- references
	self.max_charges = self:GetAbility():GetSpecialValueFor( "max_charges" ) -- special value

	if IsServer() then
		self:CalculateCharge()
	end
end

function modifier_skywrath_mage_second_attack_charges_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_skywrath_mage_second_attack_charges_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}

	return funcs
end

function modifier_skywrath_mage_second_attack_charges_lua:OnAbilityFullyCast( params )
	if IsServer() then
		if params.unit~=self:GetParent() or params.ability~=self:GetAbility() then
			return
		end

		local loop = true
		while loop do
			-- find modifier
			local reducer = self:GetParent():FindModifierByNameAndCaster("modifier_skywrath_mage_second_attack_reducer_lua", self:GetParent())
			
			if reducer~=nil then
				if not reducer:IsNull() then
					self.reduction = self.reduction + 1.0
					if self.reduction > self:GetAbility():GetCooldown( -1 ) then
						self.reduction = self:GetAbility():GetCooldown( -1 )
					end
					reducer:Destroy()
				end
			end

			if reducer==nil then
				self.cooldowns[self:GetParent()][self:GetStackCount()] = self.reduction
				self.reduction = 0.0
				loop = false
			else
				if reducer:IsNull() then
					self.cooldowns[self:GetParent()][self:GetStackCount()] = self.reduction
					self.reduction = 0.0
					loop = false
				end
			end
		end

		self:DecrementStackCount()
		self:CalculateCharge()
	end
end
--------------------------------------------------------------------------------
-- Interval Effects
function modifier_skywrath_mage_second_attack_charges_lua:OnIntervalThink()
	self:IncrementStackCount()
	self:StartIntervalThink(-1)
	self:CalculateCharge()
end

--Called When:
--	The ability is casted
--	One stack CD expires
function modifier_skywrath_mage_second_attack_charges_lua:CalculateCharge()
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
