modifier_wisp_ex_special_attack_movement = class({})
LinkLuaModifier( "modifier_wisp_ex_special_attack_thinker", "abilities/heroes/wisp/wisp_ex_special_attack/modifier_wisp_ex_special_attack_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Classifications
function modifier_wisp_ex_special_attack_movement:IsHidden()
	return true
end

function modifier_wisp_ex_special_attack_movement:IsDebuff()
	return true
end

function modifier_wisp_ex_special_attack_movement:IsStunDebuff()
	return false
end

function modifier_wisp_ex_special_attack_movement:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_wisp_ex_special_attack_movement:OnCreated( kv )
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

function modifier_wisp_ex_special_attack_movement:OnRefresh( kv )
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

function modifier_wisp_ex_special_attack_movement:OnDestroy( kv )
	if IsServer() then
		
		local origin = self:GetParent():GetOrigin()
		self:GetParent():InterruptMotionControllers( true )
        CreateModifierThinker(
            self:GetParent(), --hCaster
            self:GetAbility(), --hAbility
            "modifier_wisp_ex_special_attack_thinker", --modifierName
            {}, --paramTable
            origin,--vOrigin
            self:GetParent():GetTeamNumber(), --nTeamNumber
            false --bPhantomBlocker
        )
	end
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_wisp_ex_special_attack_movement:UpdateHorizontalMotion( me, dt )
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

function modifier_wisp_ex_special_attack_movement:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end
