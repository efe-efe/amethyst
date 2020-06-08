modifier_treant_mobility_movement = class({})

-- Classifications
function modifier_treant_mobility_movement:IsHidden()
	return true
end

function modifier_treant_mobility_movement:IsPurgable() return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_treant_mobility_movement:OnCreated(kv)
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

function modifier_treant_mobility_movement:OnRefresh(kv)
end

function modifier_treant_mobility_movement:OnDestroy(kv)
	if IsServer() then
		self:GetParent():InterruptMotionControllers(true)

		SafeDestroyModifier("modifier_treant_mobility", self:GetCaster(), self:GetCaster())

		local particle_cast = "particles/econ/items/antimage/antimage_ti7_golden/antimage_blink_start_ti7_golden.vpcf"
        -- Create Particles
        local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetOrigin())
        ParticleManager:SetParticleControl(effect_cast, 1, self:GetCaster():GetOrigin())
        ParticleManager:SetParticleControl(effect_cast, 3, self:GetCaster():GetOrigin())
        ParticleManager:ReleaseParticleIndex(effect_cast)


	end
end

function modifier_treant_mobility_movement:UpdateHorizontalMotion(me, dt)
	local pos = self:GetParent():GetOrigin()
	
	-- stop if already past distance
	if (pos-self.origin):Length2D()>=self.distance then
		self:Destroy()
		return
	end

	-- set position
	local target = pos + self.direction * (self.speed*dt)

	-- change position
	self:GetParent():SetOrigin(target)
end

function modifier_treant_mobility_movement:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

-- Status Effects
function modifier_treant_mobility_movement:CheckState()
	local state = {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end

