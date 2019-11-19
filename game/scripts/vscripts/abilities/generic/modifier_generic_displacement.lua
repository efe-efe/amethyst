modifier_generic_displacement = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_displacement:IsHidden()
	return true
end

function modifier_generic_displacement:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_displacement:OnCreated( params )
	if IsServer() then
        -- references
		self.distance = params.r
		self.direction = Vector(params.x,params.y,0):Normalized()
		self.speed = params.speed -- special value
		self.previous_origin = self:GetParent():GetOrigin()
		self.origin = self:GetParent():GetOrigin()
		self.i_frame = params.i_frame == 1 and true or false
		self.colliding = params.colliding == 1 and true or false
		self.damage_on_collision = params.damage_on_collision or nil
		self.restricted = params.restricted and params.restricted or true
		
		local activity = params.activity or ACT_DOTA_FLAIL
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
		
		StartAnimation(self:GetParent(), {
			duration = 100,
			activity = activity, 
			rate = rate, 
			translate = translate,
		})
	end
end

function modifier_generic_displacement:OnRefresh( params )
end

function modifier_generic_displacement:OnDestroy( params )
	if IsServer() then
		GameRules.EndAnimation(self:GetParent())
		self:GetParent():InterruptMotionControllers( true )
		FindClearSpaceForUnit( self:GetParent(), self:GetParent():GetOrigin() , true )


		if self:GetAbility().OnDisplacementEnd then
			self:GetAbility():OnDisplacementEnd()
		end
	end
end

--------------------------------------------------------------------------------
-- Motion effects
function modifier_generic_displacement:SyncTime( iDir, dt )
	local actual_z = GetGroundPosition(self:GetParent():GetOrigin(), self:GetParent()).z

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
			local damage = {
				victim = self:GetParent(),
				attacker = self:GetCaster(),
				damage = self.damage_on_collision,
				damage_type = DAMAGE_TYPE_PURE,
			}
			ApplyDamage( damage )
		end

		self:Destroy()
	end
	self.previous_origin = self:GetParent():GetOrigin()
end

function modifier_generic_displacement:UpdateHorizontalMotion( me, dt )
	self:SyncTime(1, dt)
	local parent = self:GetParent()
	
	-- set position
	local target = self.direction*self.hVelocity*self.elapsedTime

	-- change position
	parent:SetOrigin( self.origin + target )
end

function modifier_generic_displacement:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

function modifier_generic_displacement:UpdateVerticalMotion( me, dt )
	self:SyncTime(2, dt)
	local parent = self:GetParent()

	-- set relative position
	local target = self.vVelocity*self.elapsedTime + 0.5*self.gravity*self.elapsedTime*self.elapsedTime

	-- change height
	parent:SetOrigin( Vector( parent:GetOrigin().x, parent:GetOrigin().y, self.origin.z+target ) )
end

function modifier_generic_displacement:OnVerticalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

-- Status Effects
function modifier_generic_displacement:CheckState()
	local state = {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = self.restricted,
		[MODIFIER_STATE_SILENCED] = self.restricted,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        --[MODIFIER_STATE_NO_HEALTH_BAR] = self.i_frame,
		[MODIFIER_STATE_INVULNERABLE] = self.i_frame,
		[MODIFIER_STATE_OUT_OF_GAME] = self.i_frame,
	}

	return state
end
