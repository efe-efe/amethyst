modifier_sniper_ex_ultimate_movement_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sniper_ex_ultimate_movement_lua:IsHidden()
	return true
end

function modifier_sniper_ex_ultimate_movement_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sniper_ex_ultimate_movement_lua:OnCreated( kv )
	if IsServer() then
        -- references
		self.distance = kv.r
		self.direction = Vector(kv.x,kv.y,0):Normalized()
		self.speed = kv.speed -- special value
		self.origin = self:GetParent():GetOrigin()

		if self:ApplyHorizontalMotionController() == false then
			self:Destroy()
        end
	end
end

function modifier_sniper_ex_ultimate_movement_lua:OnRefresh( kv )
end

function modifier_sniper_ex_ultimate_movement_lua:OnDestroy( kv )
	if IsServer() then
		self:GetParent():InterruptMotionControllers( true )
	end
end


function modifier_sniper_ex_ultimate_movement_lua:UpdateHorizontalMotion( me, dt )
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

function modifier_sniper_ex_ultimate_movement_lua:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sniper_ex_ultimate_movement_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

-- Status Effects
function modifier_sniper_ex_ultimate_movement_lua:CheckState()
	local state = {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end

function modifier_sniper_ex_ultimate_movement_lua:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end
