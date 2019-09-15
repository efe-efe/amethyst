modifier_sky_counter_movement = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sky_counter_movement:IsHidden()
	return true
end

function modifier_sky_counter_movement:IsDebuff()
	return true
end

function modifier_sky_counter_movement:IsStunDebuff()
	return false
end

function modifier_sky_counter_movement:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sky_counter_movement:OnCreated( kv )
	if IsServer() then
        -- references
		self.distance = kv.r
		self.direction = Vector(kv.x,kv.y,0):Normalized()
		self.speed = 900 -- special value
		self.origin = self:GetParent():GetOrigin()

		-- apply motion controller
		if self:ApplyHorizontalMotionController() == false then
			self:Destroy()
        end
	end
end

function modifier_sky_counter_movement:OnRefresh( kv )
	if IsServer() then
        -- references
		self.distance = kv.r
		self.direction = Vector(kv.x,kv.y,0):Normalized()
		self.speed = 300 -- special value
		self.origin = self:GetParent():GetOrigin()

		-- apply motion controller
		if self:ApplyHorizontalMotionController() == false then 
			self:Destroy()
		end
	end	
end

function modifier_sky_counter_movement:OnDestroy( kv )
	if IsServer() then
		self:GetParent():InterruptMotionControllers( true )
	end
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_sky_counter_movement:UpdateHorizontalMotion( me, dt )
	local pos = self:GetParent():GetOrigin()
	
	-- stop if already past distance
	if (pos-self.origin):Length2D()>=self.distance then
		self:Destroy()
		return
	end

	-- set position
	local target = pos + self.direction * (self.speed*dt)

	-- change position
	self:GetParent():SetOrigin( target )
end

function modifier_sky_counter_movement:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sky_counter_movement:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_sky_counter_movement:CheckState()
	local state = {
        [MODIFIER_STATE_ROOTED] = true,
	}

	return state
end


--------------------------------------------------------------------------------
-- Graphics & animations
function modifier_sky_counter_movement:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end
