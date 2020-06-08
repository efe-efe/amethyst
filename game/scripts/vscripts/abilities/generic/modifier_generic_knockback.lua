modifier_generic_knockback = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_knockback:IsHidden()
	return true
end

function modifier_generic_knockback:IsPurgable() return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_knockback:OnCreated(kv)
	if IsServer() then
		-- creation data (default)
			-- kv.distance (0)
			-- kv.duration (0)
			-- kv.x, kv.y, kv.z (xy:-forward vector, z:0)
			
			-- kv.damage (nil)
			-- kv.IsPurgable () // later 

		-- references
		self.distance = kv.distance or 0
		self.duration = kv.duration or 0
		self.flail = kv.flail

		self.stun = kv.stun and true or false
		self.disable = kv.disable and true or false
		self.invulnerable = kv.invulnerable and true or false

		if self.stun then
			self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_stunned", { duration = self.duration })
		end

		if kv.x and kv.y then
			self.direction = Vector(kv.x,kv.y,0):Normalized()
		else
			self.direction = -(self:GetParent():GetForwardVector())
		end
		self.height = kv.z or 0

		-- load data
		self.origin = self:GetParent():GetOrigin()
		self.hVelocity = self.distance/self.duration
		
		-- sync
		self.elapsedTime = 0
		self.motionTick = {}
		self.motionTick[0] = 0
		self.motionTick[1] = 0
		self.motionTick[2] = 0

		-- vertical motion model
		self.gravity = -self.height/(self.duration*self.duration*0.125)
		self.vVelocity = (-0.5)*self.gravity*self.duration

		self.both = 0
		if self.z~=0 then
			self.both = self.both+1
			if self:ApplyVerticalMotionController() == false then 
				self:Destroy()
			end
		end
		if self.distance~=0 then
			self.both = self.both+1
			if self:ApplyHorizontalMotionController() == false then 
				self:Destroy()
			end
		end
	end
end

function modifier_generic_knockback:OnRefresh(kv)
	
end

function modifier_generic_knockback:OnDestroy(kv)
	if IsServer() then
		self:GetParent():InterruptMotionControllers(true)
	end
end

--------------------------------------------------------------------------------
-- Motion effects
function modifier_generic_knockback:SyncTime(iDir, dt)
	-- check if sync is not required
	if self.both<2 then
		self.elapsedTime = self.elapsedTime + dt
		if self.elapsedTime > self.duration then
			self:Destroy()
		end
		return
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
end

function modifier_generic_knockback:UpdateHorizontalMotion(me, dt)
	self:SyncTime(1, dt)
	local parent = self:GetParent()
	
	-- set position
	local target = self.direction*self.hVelocity*self.elapsedTime

	-- change position
	parent:SetOrigin(self.origin + target)
end

function modifier_generic_knockback:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

function modifier_generic_knockback:UpdateVerticalMotion(me, dt)
	self:SyncTime(2, dt)
	local parent = self:GetParent()

	-- set relative position
	local target = self.vVelocity*self.elapsedTime + 0.5*self.gravity*self.elapsedTime*self.elapsedTime

	-- change height
	parent:SetOrigin(Vector(parent:GetOrigin().x, parent:GetOrigin().y, self.origin.z+target))
end

function modifier_generic_knockback:OnVerticalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_knockback:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_generic_knockback:GetOverrideAnimation(params)
	--if self.stun or self.flail then
		return ACT_DOTA_FLAIL
	--end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_generic_knockback:CheckState()
	local state = {
		--[MODIFIER_STATE_STUNNED] = self.stun,
        [MODIFIER_STATE_COMMAND_RESTRICTED] = self.disable,
        [MODIFIER_STATE_NO_HEALTH_BAR] = self.invulnerable,
		[MODIFIER_STATE_INVULNERABLE] = self.invulnerable,
		[MODIFIER_STATE_OUT_OF_GAME] = self.invulnerable,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = self.invulnerable,
	}

	return state
end