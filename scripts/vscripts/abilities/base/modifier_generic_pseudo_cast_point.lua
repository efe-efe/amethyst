modifier_generic_pseudo_cast_point = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_pseudo_cast_point:IsHidden()
	return true
end

function modifier_generic_pseudo_cast_point:IsDebuff()
	return true
end

function modifier_generic_pseudo_cast_point:IsStunDebuff()
	return false
end

function modifier_generic_pseudo_cast_point:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_generic_pseudo_cast_point:OnCreated(params)
	self.ability = self:GetAbility()
	self.can_walk = params.can_walk
	self.movement_speed = params.movement_speed
	self.show_all = params.show_all
	self.no_target = params.no_target
	self.aoe = params.aoe
	self.radius = params.radius
	self.range = self.ability:GetCastRange(Vector(0,0,0), nil)
	self.initialized = false
	self.point = Vector(0,0,0)
	
	if IsServer() then

		if self.can_walk == 0 then
			local order = 
			{
				OrderType = DOTA_UNIT_ORDER_STOP,
				UnitIndex = self:GetParent():entindex()
			}
			ExecuteOrderFromTable(order)
		end

		self.ability:EndCooldown()
		self.ability:SetInAbilityPhase( true )
		self.ability:SetActivated( false )
		self:GetParent():GiveMana(self.ability:GetManaCost(-1))    

		self:StartIntervalThink( 0.01 )
	end
end


--------------------------------------------------------------------------------
-- When refreshed
function modifier_generic_pseudo_cast_point:OnRefresh(params)
	-- Stop previous Ability first
	self.ability:SetInAbilityPhase( false )
	self.ability:SetActivated(true)
	if self.ability.OnStopPseudoCastPoint ~= nil then
		self.ability:OnStopPseudoCastPoint()
	end

	self.ability = self:GetAbility()
	self.can_walk = params.can_walk
	self.movement_speed = params.movement_speed
	self.show_all = params.show_all
	self.no_target = params.no_target
	self.aoe = params.aoe
	self.radius = params.radius
	self.range = self.ability:GetCastRange(Vector(0,0,0), nil)
	self.initialized = false
	self.point = Vector(0,0,0)

	if IsServer() then
		self:StopEffects()

		if self.can_walk == 0 then
			local order = 
			{
				OrderType = DOTA_UNIT_ORDER_STOP,
				UnitIndex = self:GetParent():entindex()
			}
			ExecuteOrderFromTable(order)
		end

		self.ability:EndCooldown()
		self.ability:SetInAbilityPhase( true )
		self.ability:SetActivated(false)
		self:GetParent():GiveMana(self.ability:GetManaCost(-1))    

		self:StartIntervalThink( 0.01 )
	end
end

--------------------------------------------------------------------------------
-- On Orders
function modifier_generic_pseudo_cast_point:OnOrder(params)
	if params.unit==self:GetParent() then
		if 	params.order_type == 10 or
			params.order_type == DOTA_UNIT_ORDER_CAST_POSITION or
			params.order_type == DOTA_UNIT_ORDER_CAST_TARGET or
			params.order_type == DOTA_UNIT_ORDER_CAST_TARGET_TREE or
			params.order_type == DOTA_UNIT_ORDER_CAST_NO_TARGET or
			params.order_type == DOTA_UNIT_ORDER_CAST_TOGGLE
		then
			self:Destroy()
		end

		if self.can_walk == 0 then
			if	params.order_type == DOTA_UNIT_ORDER_MOVE_TO_POSITION or
				params.order_type == DOTA_UNIT_ORDER_MOVE_TO_TARGET or
				params.order_type == DOTA_UNIT_ORDER_ATTACK_MOVE or
				params.order_type == DOTA_UNIT_ORDER_ATTACK_TARGET
			then
				self:Destroy()
			end
		end
	end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_generic_pseudo_cast_point:OnDestroy(params)
	local ability = self.ability

	if IsServer() then
		self:StopEffects()

		local modifier = self:GetParent():FindModifierByName( "modifier_generic_pre_silence_lua" )
		
		-- Safe destroying
		if modifier~=nil then
			if not modifier:IsNull() then
				if ability.OnStopPseudoCastPoint ~= nil then
					ability:OnStopPseudoCastPoint()
					ability:SetInAbilityPhase( false )
					ability:SetActivated(true)
				end
				return
			end
		end

		--Destroyed before it duration ends
		if self:GetRemainingTime() >= 0.05 then
			if ability.OnStopPseudoCastPoint ~= nil then
				ability:OnStopPseudoCastPoint()
			end
			GameRules.EndAnimation(self:GetParent())
			ability:SetInAbilityPhase( false )
			ability:SetActivated(true)
		else
			if ability.OnEndPseudoCastPoint ~= nil then
				ability:StartCooldown(ability:GetCooldown(0))
				ability:PayManaCost()
				ability:SetInAbilityPhase( false )
				ability:SetActivated(true)

				ability:OnEndPseudoCastPoint( self.point )

				if ability.OnRemovePseudoCastPoint ~= nil then
					ability:OnRemovePseudoCastPoint()
				end
			end
		end
	end
	
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_generic_pseudo_cast_point:OnIntervalThink()	
    CustomGameEventManager:Send_ServerToAllClients("getMousePosition", {})
	
	self.point = GameMode.mouse_positions[self:GetParent():GetPlayerID()]
	local direction = (self.point - self:GetParent():GetOrigin()):Normalized()
	local origin = self:GetParent():GetOrigin() + Vector( 0, 0, 96 )
	local distance = (self.point - origin):Length2D()
	
	if self.range > 0 then
		if distance > self.range then
			self.point = origin + Vector(direction.x * self.range, direction.y * self.range, 0)
			self.point.z = GetGroundPosition(self.point, self:GetParent()).z
		end
	end

	if self.no_target ~= 1 then
		if self.initialized == false then
			self:PlayEffects()
			self.initialized = true
		end
		if self.aoe == 1 then
			--DebugDrawCircle(Vector(point.x, point.y,128), Vector(255,0,0), 0, self.radius, true, 0.01)
			--ParticleManager:SetParticleControl( self.effect_cast_aoe, 0, Vector(point.x, point.y, 128))	-- line origin
			ParticleManager:SetParticleControl( self.effect_cast_aoe, 0, Vector(self.point.x, self.point.y, 128))	-- line origin
			ParticleManager:SetParticleControl( self.effect_cast_aoe, 2, Vector(self.point.x, self.point.y, 128))	-- line origin
		end
		ParticleManager:SetParticleControl( self.effect_cast, 7, Vector(self.point.x, self.point.y, 128)) -- aoe
		ParticleManager:SetParticleControl( self.effect_cast, 0, origin)	-- line origin
		ParticleManager:SetParticleControl( self.effect_cast, 2, origin)	-- line end
	end
	
	self:GetParent():SetForwardVector(Vector(direction.x, direction.y, self:GetParent():GetForwardVector().z ))
end


--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_pseudo_cast_point:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
        MODIFIER_EVENT_ON_ORDER
	}

	return funcs
end

function modifier_generic_pseudo_cast_point:GetModifierMoveSpeed_Absolute()
	if self.can_walk == 0 then
		return 1
	end
end

function modifier_generic_pseudo_cast_point:GetModifierMoveSpeedBonus_Percentage()
	if self.can_walk == 0 then
		return -100
	elseif  self.movement_speed ~= nil then
		return - (100 - self.movement_speed)
	end
end

--------------------------------------------------------------------------------
-- Graphics
function modifier_generic_pseudo_cast_point:PlayEffects()
	local particle_cast = "particles/mod_units/range_finder_tower_aoe.vpcf"
	local particle_cast_aoe = "particles/ui_mouseactions/range_finder_aoe.vpcf"

	local origin = self:GetParent():GetOrigin() + Vector( 0, 0, 96 )

	if self.show_all == 1 then
		if self.aoe == 1 then
			self.effect_cast_aoe = ParticleManager:CreateParticle( particle_cast_aoe, PATTACH_WORLDORIGIN, self:GetParent())
			ParticleManager:SetParticleControl( self.effect_cast_aoe, 3, Vector(self.radius, 0, 0)) -- aoe
		end
		self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	else
		if self.aoe == 1 then
			self.effect_cast_aoe = ParticleManager:CreateParticleForPlayer( 
				particle_cast_aoe, 
				PATTACH_WORLDORIGIN, 
				self:GetParent(),
				self:GetParent():GetPlayerOwner()
			)
			ParticleManager:SetParticleControl( self.effect_cast_aoe, 3, Vector(self.radius, 0, 0)) -- aoe
		end
		self.effect_cast = ParticleManager:CreateParticleForPlayer(
			particle_cast, 
			PATTACH_WORLDORIGIN, 
			self:GetParent(), 
			self:GetParent():GetPlayerOwner()
		)
	end
end

function modifier_generic_pseudo_cast_point:StopEffects()
	if self.effect_cast ~= nil then
		ParticleManager:DestroyParticle( self.effect_cast, false ) 
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
	end

	if self.effect_cast_aoe ~= nil then
		ParticleManager:DestroyParticle( self.effect_cast_aoe, false ) 
		ParticleManager:ReleaseParticleIndex( self.effect_cast_aoe )
	end
end