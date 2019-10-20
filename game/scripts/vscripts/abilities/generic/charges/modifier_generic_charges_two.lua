modifier_generic_charges_two = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_charges_two:IsHidden()
	return false
end

function modifier_generic_charges_two:IsDebuff()
	return false
end

function modifier_generic_charges_two:IsPurgable()
	return false
end

function modifier_generic_charges_two:DestroyOnExpire()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_charges_two:OnCreated( kv )
	-- references
	self.max_charges = self:GetAbility():GetSpecialValueFor( "max_charges" ) -- special value

	if IsServer() then
		self:SetStackCount( self.max_charges )
		self:CalculateCharge()
	end
end

function modifier_generic_charges_two:OnRefresh( kv )
	-- references
	self.max_charges = self:GetAbility():GetSpecialValueFor( "max_charges" ) -- special value

	if IsServer() then
		self:CalculateCharge()
	end
end

function modifier_generic_charges_two:OnSpellCast( )
	if IsServer() then
		self:DecrementStackCount()
		self:CalculateCharge()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_charges_two:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
	}

	return funcs
end

function modifier_generic_charges_two:OnDeath( params )
	if IsServer() then
		if params.unit ~= self:GetParent() then return end
		self:SetStackCount( self.max_charges )
	end
end


--------------------------------------------------------------------------------
-- Interval Effects
function modifier_generic_charges_two:OnIntervalThink()
	self:IncrementStackCount()
	self:StartIntervalThink(-1)
	self:CalculateCharge()
end

function modifier_generic_charges_two:CalculateCharge()
	self:GetAbility():EndCooldown()
	if self:GetStackCount()>=self.max_charges then
		-- stop charging
		self:SetStackCount( self.max_charges )
		self:SetDuration( -1, false )
		self:StartIntervalThink( -1 )
	else
		-- if not charging
		if self:GetRemainingTime() <= 0.05 then
			-- start charging
			local charge_time = self:GetAbility():GetCooldown( -1 )
			self:StartIntervalThink( charge_time )
			self:SetDuration( charge_time, true )
		end

		-- set on cooldown if no charges
		if self:GetStackCount()==0 then
			self:GetAbility():StartCooldown( self:GetRemainingTime() )
		end
	end
end