modifier_wisp_ex_second_attack_movement_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_wisp_ex_second_attack_movement_lua:IsHidden()
	return false
end

function modifier_wisp_ex_second_attack_movement_lua:IsDebuff()
	return true
end

function modifier_wisp_ex_second_attack_movement_lua:IsStunDebuff()
	return false
end

function modifier_wisp_ex_second_attack_movement_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_wisp_ex_second_attack_movement_lua:OnCreated( kv )
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

function modifier_wisp_ex_second_attack_movement_lua:OnRefresh( kv )
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

function modifier_wisp_ex_second_attack_movement_lua:OnDestroy( kv )
	if IsServer() then
		self:GetParent():InterruptMotionControllers( true )
	end
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_wisp_ex_second_attack_movement_lua:UpdateHorizontalMotion( me, dt )
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

function modifier_wisp_ex_second_attack_movement_lua:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end
