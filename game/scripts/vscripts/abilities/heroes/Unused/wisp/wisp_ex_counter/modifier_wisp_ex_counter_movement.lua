modifier_wisp_ex_counter_movement = class({})
LinkLuaModifier( "modifier_wisp_ex_counter_thinker", "abilities/heroes/wisp/wisp_ex_counter/modifier_wisp_ex_counter_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Classifications
function modifier_wisp_ex_counter_movement:IsHidden()
	return true
end

function modifier_wisp_ex_counter_movement:IsDebuff()
	return true
end

function modifier_wisp_ex_counter_movement:IsStunDebuff()
	return false
end

function modifier_wisp_ex_counter_movement:IsPurgable() return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_wisp_ex_counter_movement:OnCreated( kv )
	if IsServer() then
        -- references
		self.distance = kv.r
		self.direction = Vector(kv.x,kv.y,0):Normalized()
		self.speed = 1500 -- special value
		self.origin = self:GetParent():GetOrigin()
		self.radius = self:GetAbility():GetSpecialValueFor("radius")
		self.delay_time = self:GetAbility():GetSpecialValueFor("delay_time")

		-- apply motion controller
		if self:ApplyHorizontalMotionController() == false then
			self:Destroy()
        end
	end
end

function modifier_wisp_ex_counter_movement:OnRefresh( kv )
	if IsServer() then
        -- references
		self.distance = kv.r
		self.direction = Vector(kv.x,kv.y,0):Normalized()
		self.speed = 1800 -- special value
		self.origin = self:GetParent():GetOrigin()

		-- apply motion controller
		if self:ApplyHorizontalMotionController() == false then 
			self:Destroy()
		end
	end	
end

function modifier_wisp_ex_counter_movement:OnDestroy( kv )
	if IsServer() then
		local caster = self:GetCaster()
		caster:InterruptMotionControllers( true )
		
		CreateModifierThinker(
            caster, --hCaster
            self:GetAbility(), --hAbility
            "modifier_thinker_indicator", --modifierName
            { 
                thinker = "modifier_wisp_ex_counter_thinker",
                show_all = 1,
                radius = self.radius,
                delay_time = self.delay_time,
            }, --paramTable
            caster:GetOrigin(), --vOrigin
            caster:GetTeamNumber(), --nTeamNumber
            false --bPhantomBlocker
		)
	end
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_wisp_ex_counter_movement:UpdateHorizontalMotion( me, dt )
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

function modifier_wisp_ex_counter_movement:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_wisp_ex_counter_movement:CheckState()
	local state = {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end
