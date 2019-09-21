modifier_sniper_ultimate_movement = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sniper_ultimate_movement:IsHidden()
	return true
end

function modifier_sniper_ultimate_movement:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sniper_ultimate_movement:OnCreated( kv )
	if IsServer() then
        -- references
		self.distance = kv.r
		self.speed = kv.speed -- special value

		local origin_x = kv.origin_x
		local origin_y = kv.origin_y
		local origin_z = kv.origin_z

		self.direction = Vector(kv.x, kv.y, 0):Normalized()
		self.origin = Vector( origin_x, origin_y, origin_z )

		if self:ApplyHorizontalMotionController() == false then
			self:Destroy()
        end
	end
end

function modifier_sniper_ultimate_movement:OnRefresh( kv )
end

function modifier_sniper_ultimate_movement:OnDestroy( kv )
	if IsServer() then
		self:GetParent():InterruptMotionControllers( true )
	end
end


function modifier_sniper_ultimate_movement:UpdateHorizontalMotion( me, dt )
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

function modifier_sniper_ultimate_movement:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sniper_ultimate_movement:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_sniper_ultimate_movement:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_sniper_ultimate_movement:CheckState()
	local state = {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end

