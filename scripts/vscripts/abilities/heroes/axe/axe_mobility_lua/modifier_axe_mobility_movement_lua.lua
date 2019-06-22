modifier_axe_mobility_movement_lua = class({})
LinkLuaModifier( "modifier_generic_fading_slow_lua", "abilities/generic/modifier_generic_fading_slow_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Classifications
function modifier_axe_mobility_movement_lua:IsHidden()
	return true
end

function modifier_axe_mobility_movement_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_axe_mobility_movement_lua:OnCreated( kv )
	if IsServer() then

		self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
		self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
		self.slow_duration = self:GetAbility():GetSpecialValueFor( "slow_duration" )
		self.mana_gain = self:GetAbility():GetSpecialValueFor( "mana_gain" )

        -- references
		self.distance = kv.r
		self.direction = Vector(kv.x,kv.y,0):Normalized()
		self.speed = kv.speed -- special value
		self.origin = self:GetParent():GetOrigin()

		self.duration = self.distance/self.speed
		self.peak = 100
		self.gravity = -self.peak/(self.duration*self.duration*0.125)
		self.hVelocity = self.speed
		self.vVelocity = (-0.5)*self.gravity*self.duration

		-- sync
		self.elapsedTime = 0
		self.motionTick = {}
		self.motionTick[0] = 0
		self.motionTick[1] = 0
		self.motionTick[2] = 0

		self:PlayEffects_b()

		-- apply motion controller
		if self:ApplyVerticalMotionController() == false then 
			self:Destroy()
		end
		
		if self:ApplyHorizontalMotionController() == false then
			self:Destroy()
        end
	end
end

function modifier_axe_mobility_movement_lua:OnRefresh( kv )
end

function modifier_axe_mobility_movement_lua:OnDestroy( kv )
	if IsServer() then
		local caster = self:GetParent()
		
		caster:InterruptMotionControllers( true )
		self:PlayEffects_a()

		local enemies = FindUnitsInRadius( 
            caster:GetTeamNumber(), -- int, your team number
            caster:GetOrigin(), -- point, center point
            nil, -- handle, cacheUnit. (not known)
            self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
            DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
            0, -- int, flag filter
            0, -- int, order filter
            false -- bool, can grow cache
        )

        -- Print units
		for _,enemy in pairs(enemies) do		
			local damage = {
				victim = enemy,
				attacker = caster,
				damage = self.damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}

			ApplyDamage( damage )

			enemy:AddNewModifier(
				caster,
				self:GetAbility(),
				"modifier_generic_fading_slow_lua",
				{ duration = self.slow_duration }
			)
		end
		
		-- if at least 1 enemy
		if #enemies > 0 then
			-- Give Mana
			local mana_gain_final = self:GetCaster():GetMaxMana() * self.mana_gain
			self:GetCaster():GiveMana(mana_gain_final)    
		end

		self:StopEffects_b()
	end
end

--------------------------------------------------------------------------------
-- Motion effects
function modifier_axe_mobility_movement_lua:SyncTime( iDir, dt )
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
end

function modifier_axe_mobility_movement_lua:UpdateHorizontalMotion( me, dt )
	self:SyncTime(1, dt)
	local parent = self:GetParent()
	
	-- set position
	local target = self.direction*self.hVelocity*self.elapsedTime

	-- change position
	parent:SetOrigin( self.origin + target )
end

function modifier_axe_mobility_movement_lua:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

function modifier_axe_mobility_movement_lua:UpdateVerticalMotion( me, dt )
	self:SyncTime(2, dt)
	local parent = self:GetParent()

	-- set relative position
	local target = self.vVelocity*self.elapsedTime + 0.5*self.gravity*self.elapsedTime*self.elapsedTime

	-- change height
	parent:SetOrigin( Vector( parent:GetOrigin().x, parent:GetOrigin().y, self.origin.z+target ) )
end

function modifier_axe_mobility_movement_lua:OnVerticalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_axe_mobility_movement_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

-- Status Effects
function modifier_axe_mobility_movement_lua:CheckState()
	local state = {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end

--[[
function modifier_axe_mobility_movement_lua:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end
]]

function modifier_axe_mobility_movement_lua:PlayEffects_a()
	if IsServer() then
		-- Create sound
		local sound_cast = "Hero_EarthShaker.Totem"
		EmitSoundOn(sound_cast, self:GetParent())

		-- Create particles	
		local particle_cast_a = "particles/econ/items/earthshaker/earthshaker_arcana/earthshaker_arcana_echoslam_start_special_streak.vpcf"
		local particle_cast_b = "particles/econ/items/earthshaker/earthshaker_arcana/earthshaker_arcana_echoslam_start_v2_debris.vpcf"
		local particle_cast_c = "particles/econ/items/invoker/invoker_apex/invoker_sun_strike_ground_immortal1.vpcf"
		
		
		local effect_cast_a = ParticleManager:CreateParticle(particle_cast_a, PATTACH_WORLDORIGIN, self:GetParent() )
		local effect_cast_b = ParticleManager:CreateParticle(particle_cast_b, PATTACH_WORLDORIGIN, self:GetParent() )
		local effect_cast_c = ParticleManager:CreateParticle(particle_cast_c, PATTACH_WORLDORIGIN, self:GetParent() )
		
		ParticleManager:SetParticleControl( effect_cast_a, 0, self:GetParent():GetOrigin() )
		ParticleManager:SetParticleControl( effect_cast_a, 11, Vector(0,1,0) )
		ParticleManager:SetParticleControl( effect_cast_b, 0, self:GetParent():GetOrigin() )
		ParticleManager:SetParticleControl( effect_cast_c, 0, self:GetParent():GetOrigin() )
		
		ParticleManager:ReleaseParticleIndex( effect_cast_a )
		ParticleManager:ReleaseParticleIndex( effect_cast_b )
		ParticleManager:ReleaseParticleIndex( effect_cast_c )
	end
end

function modifier_axe_mobility_movement_lua:PlayEffects_b()
	local particle_cast = "particles/generic_gameplay/rune_haste_owner.vpcf"
	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
end


function modifier_axe_mobility_movement_lua:StopEffects_b()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end

