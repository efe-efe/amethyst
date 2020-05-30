modifier_nevermore_special_attack_movement = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_nevermore_special_attack_movement:IsHidden()
	return true
end

function modifier_nevermore_special_attack_movement:IsPurgable() return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_nevermore_special_attack_movement:OnCreated( kv )
	if IsServer() then
		-- references
		self.distance = 600
		self.direction = Vector(0,0,1):Normalized()
		self.speed = 800
		 -- special value
		self.origin = self:GetParent():GetOrigin()
		self.elapsedTime = 0

		self:PlayEffects()

		--Attepmt to repair the instant stop bug
		local order = 
		{
			OrderType = DOTA_UNIT_ORDER_STOP,
			UnitIndex = self:GetParent():entindex()
		}
		ExecuteOrderFromTable(order)

		if self:GetParent():HasModifier("modifier_cast_point_old") then
			SafeDestroyModifier("modifier_cast_point_old", self:GetParent(), self:GetParent())
		end

		if self:ApplyVerticalMotionController() == false then
			self:Destroy()
		end
		
		ProgressBars:AddProgressBar(self:GetParent(), self:GetName(), {
            style = "Generic",
            text = "flying",
            progressBarType = "duration",
            priority = 1,
        })
	end
end

function modifier_nevermore_special_attack_movement:OnRefresh( kv )
end

function modifier_nevermore_special_attack_movement:OnDestroy( kv )
	if IsServer() then
		--Quits the animation
		local order = 
		{
			OrderType = DOTA_UNIT_ORDER_STOP,
			UnitIndex = self:GetParent():entindex()
		}
		ExecuteOrderFromTable(order)
		self:GetParent():InterruptMotionControllers( true )
		self:StopEffects()
	end
end


function modifier_nevermore_special_attack_movement:UpdateVerticalMotion( me, dt )
	local pos = self:GetParent():GetOrigin()

	if self.elapsedTime > self:GetDuration() * 0.8 then	
		if self.direction.z > 0 then
			self.direction  = self.direction * -1
		end
	end

	-- set position
	local target = pos + self.direction * ( self.speed * dt )

	self.elapsedTime = self.elapsedTime + dt

	--print("===========================" .. self.elapsedTime .. "===========================")
	--print(pos)
	--print(target)
	--print(self.direction)
	--print("================================================================")
	-- stop if already past distance
	if target.z >= self.distance then
		self:GetParent():SetOrigin( Vector( target.x, target.y, self.distance ))
		return
	end

	-- change position
	self:GetParent():SetOrigin( target )
end

function modifier_nevermore_special_attack_movement:OnVerticalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_nevermore_special_attack_movement:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}

	return funcs
end

-- Status Effects
function modifier_nevermore_special_attack_movement:CheckState()
	local state = {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_SILENCED] = true,
	}

	return state
end

function modifier_nevermore_special_attack_movement:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end

function modifier_nevermore_special_attack_movement:GetOverrideAnimationRate()
	return 0.8
end


function modifier_nevermore_special_attack_movement:PlayEffects( )
	local caster = self:GetCaster()
	local targetOrigin = self:GetParent():GetOrigin()

	-- Create Sound
	local sound_cast = "Hero_Nevermore.Shadowraze"
	EmitSoundOnLocationWithCaster( targetOrigin, sound_cast, caster )


	-- Create particle
	local particle_cast = "particles/mod_units/heroes/hero_nevermore/invoker_tornado_ti6_funnel.vpcf"
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( self.effect_cast, 0, targetOrigin )
	ParticleManager:SetParticleControl( self.effect_cast, 3, targetOrigin )
end


function modifier_nevermore_special_attack_movement:StopEffects()
    ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex(self.effect_cast )
end