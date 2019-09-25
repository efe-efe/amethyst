modifier_juggernaut_ultimate_movement = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_juggernaut_ultimate_movement:IsHidden()
	return true
end

function modifier_juggernaut_ultimate_movement:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_juggernaut_ultimate_movement:OnCreated( kv )
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

function modifier_juggernaut_ultimate_movement:OnRefresh( kv )
end

function modifier_juggernaut_ultimate_movement:OnDestroy( kv )
	if IsServer() then
		
		--Quits the animation
		local order = 
		{
			OrderType = DOTA_UNIT_ORDER_STOP,
			UnitIndex = self:GetParent():entindex()
		}
		ExecuteOrderFromTable(order)
		self:GetParent():InterruptMotionControllers( true )
	end
end


function modifier_juggernaut_ultimate_movement:UpdateHorizontalMotion( me, dt )
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

function modifier_juggernaut_ultimate_movement:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_juggernaut_ultimate_movement:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}

	return funcs
end
--------------------------------------------------------------------------------
-- Status Effects
function modifier_juggernaut_ultimate_movement:CheckState()
	local state = {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end

--------------------------------------------------------------------------------
--Graphics & Animations
function modifier_juggernaut_ultimate_movement:GetOverrideAnimation()
	return ACT_DOTA_ATTACK_EVENT
end

function modifier_juggernaut_ultimate_movement:GetOverrideAnimationRate()
	return 1.0
end

function modifier_juggernaut_ultimate_movement:GetEffectName()
	return "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger.vpcf"
end