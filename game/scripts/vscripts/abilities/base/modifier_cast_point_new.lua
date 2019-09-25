modifier_cast_point_new = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_cast_point_new:IsHidden()
	return true
end

function modifier_cast_point_new:IsDebuff()
	return true
end

function modifier_cast_point_new:IsStunDebuff()
	return false
end

function modifier_cast_point_new:IsPurgable()
	return false
end

---------------------------------------------------------------------------------
-- Initializer
function modifier_cast_point_new:OnCreated(params)
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	
	self.movement_speed = params.movement_speed
	self.show_all = params.show_all
	self.no_target = params.no_target
	self.radius = params.radius
	self.hide_indicator = params.hide_indicator
	
	self.min_range = params.min_range
	self.max_range = params.max_range

	self.disable_all = params.disable_all
	self.placeholder = params.placeholder
	self.cancel_on_damage = params.cancel_on_damage

	if IsServer() then

		if self.hide_indicator ~= nil then
			self.parent:AddNewModifier(self.parent, nil, "modifier_target_indicator", { 
				duration = self:GetDuration(),
				min_range = self.min_range,
				max_range = self.max_range,
				radius = self.radius,
			})
		end

		self:StartCast()
		self:StartIntervalThink( 0.01 )
	end
end

--------------------------------------------------------------------------------
-- When refreshed
function modifier_cast_point_new:OnRefresh(params)
	-- Stop previous Ability first
	if IsServer() then
		self:StopCast()
	end

	--print("REFRESHED")

	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	
	self.movement_speed = params.movement_speed
	self.show_all = params.show_all
	self.no_target = params.no_target
	self.radius = params.radius
	
	self.min_range = params.min_range
	self.max_range = params.max_range

	self.disable_all = params.disable_all
	self.placeholder = params.placeholder
	self.cancel_on_damage = params.cancel_on_damage


	if IsServer() then
		--self:StopEffects()
		if self.hide_indicator ~= nil then
			self.parent:AddNewModifier(self.parent, nil, "modifier_target_indicator", { 
				duration = self:GetDuration(),
				min_range = self.min_range,
				max_range = self.max_range,
				radius = self.radius,
			})
		end

		self:StartCast()
		self:StartIntervalThink( 0.01 )
	end
end

function modifier_cast_point_new:SwapActiveSpells( mode )
	local boolean_mode

	if mode == "disable" then
		boolean_mode = false
	elseif mode == "enable" then
		boolean_mode = true
	end

	if IsServer() then
		for i = 0, 12 do
			local ability = self.parent:GetAbilityByIndex(i)
			if ability then
				if ability:GetAbilityType() ~= 2 then -- To not level up the talents
					if ability ~= self:GetAbility() then
						ability:SetActivated( boolean_mode )
					end
				end
			end
		end
	end
end

function modifier_cast_point_new:StartCast()
	if IsServer() then
		self.ability:EndCooldown()
		self.ability:SetActivated(false)
		self.ability:SetInAbilityPhase(true)
		self.parent:GiveMana(self.ability:GetManaCost(-1)) 
				
		local modifier = self.parent:FindModifierByName("modifier_generic_pre_silence_lua")
		
		-- Safe destroying CHECKEAR 
		if modifier ~= nil then
			if not modifier:IsNull() then
				modifier:Destroy()
				self:Destroy()
				return
			end
		end

		if self.disable_all ~= 0 then
			self:SwapActiveSpells("disable")
		end
	end
end

function modifier_cast_point_new:StopCast()
	if IsServer() then
		self.ability:SetActivated(true)
		self.ability:SetInAbilityPhase(false)
		self:SwapActiveSpells("enable")
		if self.ability.OnStopPseudoCastPoint ~= nil then
			self.ability:OnStopPseudoCastPoint()
		end
		SafeDestroyModifier("modifier_target_indicator", self.parent, self.parent)
	end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_cast_point_new:OnDestroy(params)
	if IsServer() then
		--Destroyed before it duration ends
		if self:GetRemainingTime() >= 0.05 then
			GameRules.EndAnimation(self.parent)
			self:StopCast()
		else
			if self.ability.OnCastPointEnd ~= nil then
				local modifier = nil 

				if self.ability:GetIntrinsicModifierName() == "modifier_generic_charges_one" then
					modifier = self.ability:GetCaster():FindModifierByName("modifier_generic_charges_one")
				elseif self.ability:GetIntrinsicModifierName() == "modifier_generic_charges_two" then
					modifier = self.ability:GetCaster():FindModifierByName("modifier_generic_charges_two")
				end

				if modifier ~= nil then
					if modifier.OnSpellCast ~= nil then
						modifier:OnSpellCast()
					else
						print("[PSEUDO CAST POINT ERROR] Charges don't have OnSpellCast funcion")
					end
				else
					self.ability:StartCooldown(self.ability:GetCooldown(0))
				end

				self.ability:PayManaCost()

				self.ability:SetInAbilityPhase( false )
				self.ability:SetActivated( true )
				self:SwapActiveSpells( "enable" )

				if self.ability.force_position ~= nil then
					self.ability:OnCastPointEnd( self.ability.force_position )
				else
					self.ability:OnCastPointEnd( self.point )
				end

				if self.ability.OnRemovePseudoCastPoint ~= nil then
					self.ability:OnRemovePseudoCastPoint()
				end
			end
		end

		local order = 
		{
			OrderType = DOTA_UNIT_ORDER_STOP,
			UnitIndex = self.parent:entindex()
		}
		ExecuteOrderFromTable(order)
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_cast_point_new:OnIntervalThink()
	if 	self.parent:IsStunned() or 
		self.parent:IsNightmared() or
		self.parent:IsSilenced() or
		not self.parent:IsAlive()
	then
		self:Destroy()
	end
		
    local mouse = GameMode.mouse_positions[self.parent:GetPlayerID()]
	local direction = (mouse - self.parent:GetOrigin()):Normalized()

	self.parent:SetForwardVector(Vector(direction.x, direction.y, self.parent:GetForwardVector().z ))
end


--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_cast_point_new:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_EVENT_ON_ORDER,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_cast_point_new:GetModifierMoveSpeedBonus_Percentage()
	if self.movement_speed ~= nil and self.movement_speed ~= 0 then
		return - (100 - self.movement_speed)
	end
end

function modifier_cast_point_new:OnOrder(params)
	if params.unit==self.parent then
		if 	params.order_type == DOTA_UNIT_ORDER_HOLD_POSITION or
			params.order_type == DOTA_UNIT_ORDER_CAST_POSITION or
			params.order_type == DOTA_UNIT_ORDER_CAST_TARGET or
			params.order_type == DOTA_UNIT_ORDER_CAST_TARGET_TREE or
			params.order_type == DOTA_UNIT_ORDER_CAST_NO_TARGET or
			params.order_type == DOTA_UNIT_ORDER_CAST_TOGGLE
		then
			self:Destroy()
		end
	end
end

function modifier_cast_point_new:OnTakeDamage( params )
	if IsServer() then
        if params.unit~=self:GetCaster() then return end
		if self.cancel_on_damage ~= 1 then return end
        self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_cast_point_new:CheckState()
    if self.movement_speed == 0 then
        return { [MODIFIER_STATE_ROOTED] = true }
    else
        return {}
    end
end
