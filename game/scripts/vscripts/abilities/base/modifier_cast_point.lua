modifier_cast_point = class({})

local COOLDOWN_BY_CANCEL = 0.5

--------------------------------------------------------------------------------
-- Classifications
function modifier_cast_point:IsHidden()
	return true
end

function modifier_cast_point:IsDebuff()
	return true
end

function modifier_cast_point:IsStunDebuff()
	return false
end

function modifier_cast_point:IsPurgable()
	return false
end

---------------------------------------------------------------------------------
-- Initializer
function modifier_cast_point:OnCreated(params)
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	
	self.canceled_by_player = false

	if IsServer() then
		self.movement_speed = params.movement_speed
		self.show_all = params.show_all
		self.no_target = params.no_target
		self.radius = params.radius
		self.hide_indicator = params.hide_indicator
		self.cancelable = params.cancelable
		
		self.disable_all = params.disable_all == 1 and true or false
		self.public = params.public
		self.cancel_on_damage = params.cancel_on_damage

		local fixed_range = params.fixed_range

		if self.hide_indicator ~= nil then
			self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_target_indicator", { 
				duration = self:GetDuration(),
				fixed_range = fixed_range,
				radius = self.radius,
				public = self.public
			})
		end

		GameMode:InitializeCastPoint( self.parent, self:GetDuration(), self:GetName() )

		self:StartCast()
		self:StartIntervalThink( 0.01 )
	end
end

--------------------------------------------------------------------------------
-- When refreshed
function modifier_cast_point:OnRefresh(params)
	-- Stop previous Ability first
	if IsServer() then
		self:StopCast()
	end

	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	self.canceled_by_player = false

	if IsServer() then
		self:SetDuration(params.duration, true)
		self.movement_speed = params.movement_speed
		self.show_all = params.show_all
		self.no_target = params.no_target
		self.radius = params.radius
		self.hide_indicator = params.hide_indicator
		self.cancelable = params.cancelable
		
		self.disable_all = params.disable_all == 1 and true or false
		self.public = params.public
		self.cancel_on_damage = params.cancel_on_damage

		local fixed_range = params.fixed_range

		if self.hide_indicator ~= nil then
			self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_target_indicator", { 
				duration = self:GetDuration(),
				fixed_range = fixed_range,
				radius = self.radius,
				public = self.public
			})
		end

		self:StartCast()
		self:StartIntervalThink( 0.01 )
	end
end

function modifier_cast_point:StartCast()
	if IsServer() then
		self.ability:EndCooldown()
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

		if self.disable_all then
			if self.cancelable == 1 then
				self.parent:DeactivateNonPriorityAbilities()
			else
				self.parent:DeactivateAllAbilitiesWithExeption(self.ability)
			end
		end
	end
end

function modifier_cast_point:StopCast()
	if IsServer() then
		self.ability:SetInAbilityPhase(false)
		if self.disable_all then
			self.parent:SetAllAbilitiesActivated( true )
		end
		if self.ability.OnStopPseudoCastPoint ~= nil then
			self.ability:OnStopPseudoCastPoint()
		end
		if self.canceled_by_player == true then
			if not self.ability:IsBasicAttack() then
				self.ability:StartCooldown(COOLDOWN_BY_CANCEL)
			end
		end
		SafeDestroyModifier("modifier_target_indicator", self.parent, self.parent)
	end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_cast_point:OnDestroy(params)
	if IsServer() then
		--Destroyed before it duration ends
		if self:GetRemainingTime() >= 0.05 then
			GameRules.EndAnimation(self.parent)
			self:StopCast()
		else
			if self.ability.OnCastPointEnd ~= nil then
				if self.ability:HasCharges() then
					local charges_modifier_name = self.ability:GetIntrinsicModifierName()
					local charges_modifier = self.ability:GetCaster():FindModifierByName(charges_modifier_name)
					
					if charges_modifier ~= nil then
						if charges_modifier.OnSpellCast ~= nil then
							charges_modifier:OnSpellCast()
						else
							print("[PSEUDO CAST POINT ERROR] Charges don't have OnSpellCast funcion")
						end
					end
				else
					self.ability:StartCooldown(self.ability:GetCooldown(0))
				end

				self.ability:PayManaCost()

				self.ability:SetInAbilityPhase( false )
				if self.disable_all then
					self.parent:SetAllAbilitiesActivated( true )
				end

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
function modifier_cast_point:OnIntervalThink()
	if 	self.parent:IsStunned() or 
		self.parent:IsNightmared() or
		self.parent:IsSilenced() or
		self.parent:HasFear() or
		self.parent:HasModifier("modifier_generic_displacement") or
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
function modifier_cast_point:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_EVENT_ON_ORDER,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_cast_point:GetModifierMoveSpeedBonus_Percentage()
	if self.movement_speed ~= nil and self.movement_speed ~= 0 then
		return - (100 - self.movement_speed)
	end
end

function modifier_cast_point:OnOrder(params)
	if params.unit==self.parent and self.cancelable == 1 then
		if 	params.order_type == DOTA_UNIT_ORDER_HOLD_POSITION or
			params.order_type == DOTA_UNIT_ORDER_CAST_POSITION or
			params.order_type == DOTA_UNIT_ORDER_CAST_TARGET or
			params.order_type == DOTA_UNIT_ORDER_CAST_TARGET_TREE or
			params.order_type == DOTA_UNIT_ORDER_CAST_NO_TARGET
		then
			self.canceled_by_player = true
			self:Destroy()
		end
	end
end

function modifier_cast_point:OnTakeDamage( params )
	if IsServer() then
        if params.unit~=self:GetCaster() then return end
		if self.cancel_on_damage ~= 1 then return end
        self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_cast_point:CheckState()
    if self.movement_speed == 0 then
        return { [MODIFIER_STATE_ROOTED] = true }
    else
        return {}
    end
end

function modifier_cast_point:OnKeyReleased( key )
	if self.ability.CastOnRelease and self.ability.CastOnRelease() == true then
		self:SetDuration(0.0, true)
		SafeDestroyModifier("modifier_target_indicator", self.parent, self.parent)
		--[[if self:GetAbility().OnKeyReleased and self:GetAbility().GetKey() == key then
			self:GetAbility():OnKeyReleased()
		end]]
	end
end

