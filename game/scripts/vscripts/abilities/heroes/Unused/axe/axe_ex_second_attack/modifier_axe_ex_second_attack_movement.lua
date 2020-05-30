modifier_axe_ex_second_attack_movement = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_axe_ex_second_attack_movement:IsHidden()
	return true
end

function modifier_axe_ex_second_attack_movement:IsPurgable() return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_axe_ex_second_attack_movement:OnCreated( kv )
	if IsServer() then
        -- references
		self.distance = kv.r
		self.direction = Vector(kv.x,kv.y,0):Normalized()
		self.speed = kv.speed -- special value
		self.origin = self:GetParent():GetOrigin()

		self.duration = self.distance/self.speed
		self.peak = 100
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
	end
end

function modifier_axe_ex_second_attack_movement:OnRefresh( kv )
end

function modifier_axe_ex_second_attack_movement:OnDestroy( kv )
	if IsServer() then
		self:GetParent():InterruptMotionControllers( true )
	end
end

--------------------------------------------------------------------------------
-- Motion effects
function modifier_axe_ex_second_attack_movement:SyncTime( iDir, dt )
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

function modifier_axe_ex_second_attack_movement:UpdateHorizontalMotion( me, dt )
	self:SyncTime(1, dt)
	local parent = self:GetParent()
	
	-- set position
	local target = self.direction*self.hVelocity*self.elapsedTime

	-- change position
	parent:SetOrigin( self.origin + target )
end

function modifier_axe_ex_second_attack_movement:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

function modifier_axe_ex_second_attack_movement:UpdateVerticalMotion( me, dt )
	self:SyncTime(2, dt)
	local parent = self:GetParent()

	-- set relative position
	local target = self.vVelocity*self.elapsedTime + 0.5*self.gravity*self.elapsedTime*self.elapsedTime

	-- change height
	parent:SetOrigin( Vector( parent:GetOrigin().x, parent:GetOrigin().y, self.origin.z+target ) )
end

function modifier_axe_ex_second_attack_movement:OnVerticalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_axe_ex_second_attack_movement:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

-- Status Effects
function modifier_axe_ex_second_attack_movement:CheckState()
	local state = {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}

	return state
end

function modifier_axe_ex_second_attack_movement:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end
