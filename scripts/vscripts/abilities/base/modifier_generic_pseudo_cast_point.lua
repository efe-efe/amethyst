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
	self.parent = self:GetParent()
	self.can_walk = params.can_walk
	self.movement_speed = params.movement_speed
	self.show_all = params.show_all
	self.no_target = params.no_target
	self.radius = params.radius
	self.min_range = params.min_range
	self.disable_all = params.disable_all
	self.range = self.ability:GetCastRange(Vector(0,0,0), nil)
	self.initialized = false
	self.point = Vector(0,0,0)
	
	if IsServer() then
		self:StartCast()
		self:StartIntervalThink( 0.01 )
	end
end

--------------------------------------------------------------------------------
-- When refreshed
function modifier_generic_pseudo_cast_point:OnRefresh(params)
	-- Stop previous Ability first
	if IsServer() then
		self:StopCast()
	end

	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	self.can_walk = params.can_walk
	self.movement_speed = params.movement_speed
	self.show_all = params.show_all
	self.no_target = params.no_target
	self.radius = params.radius
	self.min_range = params.min_range
	self.range = self.ability:GetCastRange(Vector(0,0,0), nil)
	self.initialized = false
	self.disable_all = params.disable_all
	self.point = Vector(0,0,0)


	if IsServer() then
		self:StopEffects()
		self:StartCast()
		self:StartIntervalThink( 0.01 )
	end
end

function modifier_generic_pseudo_cast_point:SwapActiveSpells( mode )
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

function modifier_generic_pseudo_cast_point:StartCast()
	if IsServer() then

		local modifier = self.parent:FindModifierByName("modifier_generic_pre_silence_lua")
		
		-- Safe destroying CHECKEAR 
		if modifier ~= nil then
			if not modifier:IsNull() then
				modifier:Destroy()
				self:Destroy()
				return
			end
		end

		if self.can_walk == 0 then
			local order = 
			{
				OrderType = DOTA_UNIT_ORDER_STOP,
				UnitIndex = self.parent:entindex()
			}
			ExecuteOrderFromTable(order)
		end

		self.ability:EndCooldown()
		self.ability:SetActivated(false)
		self.ability:SetInAbilityPhase(true)
		self.parent:GiveMana(self.ability:GetManaCost(-1)) 
				
		if self.disable_all ~= 0 then
			self:SwapActiveSpells("disable")
		end
	end
end

function modifier_generic_pseudo_cast_point:StopCast()
	if IsServer() then
		self.ability:SetActivated(true)
		self.ability:SetInAbilityPhase(false)
		self:SwapActiveSpells("enable")
		if self.ability.OnStopPseudoCastPoint ~= nil then
			self.ability:OnStopPseudoCastPoint()
		end
	end
end


--------------------------------------------------------------------------------
-- On Orders
function modifier_generic_pseudo_cast_point:OnOrder(params)
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

		if self.can_walk == 0 then
			if	params.order_type == DOTA_UNIT_ORDER_MOVE_TO_POSITION or
				params.order_type == DOTA_UNIT_ORDER_MOVE_TO_TARGET or
				params.order_type == DOTA_UNIT_ORDER_ATTACK_MOVE or
				params.order_type == DOTA_UNIT_ORDER_ATTACK_TARGET
			then
				print("destroying")
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
		--Destroyed before it duration ends
		if self:GetRemainingTime() >= 0.05 then
			GameRules.EndAnimation(self.parent)
			self:StopCast()
		else
			if ability.OnEndPseudoCastPoint ~= nil then
				local modifier = nil 

				if ability:GetIntrinsicModifierName() == "modifier_generic_charges_one" then
					modifier = ability:GetCaster():FindModifierByName("modifier_generic_charges_one")
				elseif ability:GetIntrinsicModifierName() == "modifier_generic_charges_two" then
					modifier = ability:GetCaster():FindModifierByName("modifier_generic_charges_two")
				end

				if modifier ~= nil then
					if modifier.OnSpellCast ~= nil then
						modifier:OnSpellCast()
					else
						print("[PSEUDO CAST POINT ERROR] Charges don't have OnSpellCast funcion")
					end
				else
					ability:StartCooldown(ability:GetCooldown(0))
				end

				ability:PayManaCost()

				ability:SetInAbilityPhase( false )
				ability:SetActivated( true )
				self:SwapActiveSpells( "enable" )

				if ability.force_position ~= nil then
					ability:OnEndPseudoCastPoint( ability.force_position )
				else
					ability:OnEndPseudoCastPoint( self.point )
				end

				if ability.OnRemovePseudoCastPoint ~= nil then
					ability:OnRemovePseudoCastPoint()
				end
			end
		end

		local order = 
		{
			OrderType = DOTA_UNIT_ORDER_STOP,
			UnitIndex = self.parent:entindex()
		}
		ExecuteOrderFromTable(order)

		self:StopEffects()
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_generic_pseudo_cast_point:OnIntervalThink()

	if 	self.parent:IsStunned() or 
		self.parent:IsNightmared() or
		self.parent:IsSilenced() or
		not self.parent:IsAlive()
	then
		self:Destroy()
	end
		
	self.point = GameMode.mouse_positions[self.parent:GetPlayerID()]
	local direction = (self.point - self.parent:GetOrigin()):Normalized()
	local origin = self.parent:GetOrigin() + Vector( 0, 0, 96 )
	local distance = (self.point - origin):Length2D()
	
	if self.range > 0 then
		if distance > self.range then
			self.point = origin + direction * self.range
		end
		if self.min_range ~= nil then
			if distance < self.min_range then
				self.point = origin + direction * self.min_range
			end
		end 
		self.point.z = GetGroundPosition(self.point, self.parent).z
	end

	if self.no_target ~= 1 then
		if self.initialized == false then
			self:PlayEffects()
			self.initialized = true
		end
		if self.radius ~= nil then
			ParticleManager:SetParticleControl( self.effect_cast_aoe, 0, Vector(self.point.x, self.point.y, 128))	-- line origin
			ParticleManager:SetParticleControl( self.effect_cast_aoe, 2, Vector(self.point.x, self.point.y, 128))	-- line origin
		end
		ParticleManager:SetParticleControl( self.effect_cast, 7, Vector(self.point.x, self.point.y, 128)) -- aoe
		ParticleManager:SetParticleControl( self.effect_cast, 0, origin)	-- line origin
		ParticleManager:SetParticleControl( self.effect_cast, 2, origin)	-- line end
	end
	
	--local angles = VectorToAngles(self.point)
	--local parent_angles = self.parent:GetAngles()
	--self.parent:SetAngles(parent_angles.x, angles.y, parent_angles.z)
	--self.parent:FaceTowards(self.point)
	self.parent:SetForwardVector(Vector(direction.x, direction.y, self.parent:GetForwardVector().z ))
end


--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_pseudo_cast_point:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
		MODIFIER_EVENT_ON_ORDER,
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

	local origin = self.parent:GetOrigin() + Vector( 0, 0, 96 )

	if self.show_all == 1 then
		if self.radius ~= nil then
			self.effect_cast_aoe = ParticleManager:CreateParticle( particle_cast_aoe, PATTACH_WORLDORIGIN, self.parent)
			ParticleManager:SetParticleControl( self.effect_cast_aoe, 3, Vector(self.radius, 0, 0)) -- aoe
		end
		self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent)
	else
		if self.radius ~= nil then
			self.effect_cast_aoe = ParticleManager:CreateParticleForPlayer( 
				particle_cast_aoe, 
				PATTACH_WORLDORIGIN, 
				self.parent,
				self.parent:GetPlayerOwner()
			)
			ParticleManager:SetParticleControl( self.effect_cast_aoe, 3, Vector(self.radius, 0, 0)) -- aoe
		end
		self.effect_cast = ParticleManager:CreateParticleForPlayer(
			particle_cast, 
			PATTACH_WORLDORIGIN, 
			self.parent, 
			self.parent:GetPlayerOwner()
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