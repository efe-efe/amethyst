modifier_generic_displacement = class({})

local effects = {}
effects[1] = {
	particle = "particles/mod_units/heroes/hero_nevermore/invoker_tornado_ti6_funnel.vpcf",
	control_points = {}
}

effects[1].control_points[0] = "origin"
effects[1].control_points[3] = "origin"

function modifier_generic_displacement:IsHidden() 		return false end
function modifier_generic_displacement:IsPurgable() 	return false end
function modifier_generic_displacement:OnCreated(params)
	if IsServer() then
		self.distance = params.r
		self.direction = Vector(params.x,params.y,0):Normalized()
		self.speed = params.speed -- special value

		self.previous_origin = self:GetParent():GetOrigin()
		self.origin = self:GetParent():GetOrigin()
		self.initial_origin = self:GetParent():GetOrigin()
		
		self.i_frame = params.i_frame == 1 and true or false
		self.colliding = params.colliding == 1 and true or false
		self.collide_with_ent = params.collide_with_ent == 1 and true or false
		self.interrupt = params.interrupt == nil and true or false
		self.damage_on_collision = params.damage_on_collision or nil
		self.called_callback_on_half = false

		self.restricted = params.restricted
		self.effect = params.effect

		if self.restricted == 1 then
			self.restricted = true
		elseif self.restricted == 0 then
			self.restricted = false
		else 
			self.restricted = true
		end
		
		local activity = params.activity or 1
		local rate = params.rate or 1.0
		local translate = params.translate or nil

		self.duration = self.distance/self.speed
		self.peak = params.peak
		self.gravity = -self.peak/(self.duration*self.duration*0.125)
		self.hVelocity = self.speed
		self.vVelocity = (-0.5)*self.gravity*self.duration

		-- sync
		self.elapsedTime = 0
		self.motionTick = {}
		self.motionTick[0] = 0
		self.motionTick[1] = 0
		self.motionTick[2] = 0

		-- apply motion controller
		if self:ApplyVerticalMotionController() == false then 
			self:Destroy()
		end
		
		if self:ApplyHorizontalMotionController() == false then
			self:Destroy()
		end

		if self.i_frame then
			self:GetParent():HideHealthBar()
		end

		if self.effect then
			self:SetStackCount(self.effect)
			self:PlayEffects()
		end

		if self.interrupt then
			self:GetParent():InterruptCastPoint()
		end

		self:SetStackCount(activity)
	end
end

function modifier_generic_displacement:OnDestroy(params)
	if IsServer() then
		self:GetParent():InterruptMotionControllers(true)
		GameRules.EndAnimation(self:GetParent())
		FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetOrigin() , true)

		if self.i_frame then
			self:GetParent():UnhideHealthBar()
		end

		if self:GetAbility().OnDisplacementEnd then
			self:GetAbility():OnDisplacementEnd()
		end

		if self.effect then
			self:StopEffects()
		end
	end
end

function modifier_generic_displacement:SyncTime(iDir, dt)
	local actual_z = GetGroundPosition(self:GetParent():GetOrigin(), self:GetParent()).z

	if not self.called_callback_on_half then
		local distance = (self.initial_origin - self:GetParent():GetOrigin()):Length2D()

		if distance >= self.distance/2 then
			if self:GetAbility().OnDisplacementHalf then
				self:GetAbility():OnDisplacementHalf()
			end
			self.called_callback_on_half = true
		end
	end

	-- check if already synced
	if self.motionTick[1]==self.motionTick[2] then
		self.motionTick[0] = self.motionTick[0] + 1
		self.elapsedTime = self.elapsedTime + dt
	end

	-- sync time
	self.motionTick[iDir] = self.motionTick[0]
	
	-- end motion
	if self.elapsedTime > self.duration and self.motionTick[1]==self.motionTick[2] then
		self:Destroy()
	end
	
	if self.colliding and actual_z - self.previous_origin.z > 32  then
		--Damage
		if self.damage_on_collision then
			local damage_table = {
				victim = self:GetParent(),
				attacker = self:GetCaster(),
				damage = self.damage_on_collision,
				damage_type = DAMAGE_TYPE_PURE,
			}
			ApplyDamage(damage_table)
		end

		self:Destroy()
	end

	if self.collide_with_ent then
		local test_origin = self:GetParent():GetOrigin() + Vector(self.direction.x * 80, self.direction.y * 80, 0)

		local units = self:GetCaster():FindUnitsInRadius(
            test_origin, 
            80, 
            DOTA_UNIT_TARGET_TEAM_BOTH, 
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER
		)

		-- 1 is self
		if #units >= 2 then
			self:Destroy()
		end
	end

	self.previous_origin = self:GetParent():GetOrigin()
end

function modifier_generic_displacement:UpdateHorizontalMotion(me, dt)
	self:SyncTime(1, dt)
	local parent = self:GetParent()
	
	-- set position
	local target = self.direction*self.hVelocity*self.elapsedTime

	-- change position
	parent:SetOrigin(self.origin + target)
end

function modifier_generic_displacement:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

function modifier_generic_displacement:UpdateVerticalMotion(me, dt)
	self:SyncTime(2, dt)
	local parent = self:GetParent()

	-- set relative position
	local target = self.vVelocity * self.elapsedTime + 0.5 * self.gravity * self.elapsedTime * self.elapsedTime

	-- change height
	parent:SetOrigin(Vector(parent:GetOrigin().x, parent:GetOrigin().y, self.origin.z+target))
end

function modifier_generic_displacement:OnVerticalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

function modifier_generic_displacement:CheckState()
	return {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = self.restricted,
		[MODIFIER_STATE_SILENCED] = self.restricted,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_INVULNERABLE] = self.i_frame,
		[MODIFIER_STATE_OUT_OF_GAME] = self.i_frame,
	}
end

function modifier_generic_displacement:PlayEffects()
	local particle_cast = effects[self:GetStackCount()].particle
	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	
	for _,cp in pairs(effects[self:GetStackCount()].control_points) do
		if cp == "origin" then
			ParticleManager:SetParticleControl(self.effect_cast, _, self:GetParent():GetOrigin())
		end
	end
end

function modifier_generic_displacement:StopEffects()
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)    
end

function modifier_generic_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
	}
end

function modifier_generic_displacement:GetOverrideAnimation()
	if self:GetStackCount() == 1 or self:GetStackCount() == 2 then
		return ACT_DOTA_FLAIL
	end
end

function modifier_generic_displacement:GetActivityTranslationModifiers()
	if self:GetStackCount() == 2 then
		return "forcestaff_friendly"
	end
end
