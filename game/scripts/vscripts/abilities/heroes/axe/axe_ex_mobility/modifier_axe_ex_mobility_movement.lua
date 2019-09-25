modifier_axe_ex_mobility_movement = class({})
LinkLuaModifier( "modifier_generic_sleep_lua", "abilities/generic/modifier_generic_sleep_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Classifications
function modifier_axe_ex_mobility_movement:IsHidden()
	return true
end

function modifier_axe_ex_mobility_movement:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_axe_ex_mobility_movement:OnCreated( kv )
	if IsServer() then

		self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
		self.damage = self:GetAbility():GetAbilityDamage()
		self.sleep_duration = self:GetAbility():GetSpecialValueFor( "sleep_duration" )

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

		StartAnimation(self:GetParent(), {
			duration = 1.0, 
			activity = ACT_DOTA_CAST_ABILITY_4, 
			rate = 1.0
		})

		-- apply motion controller
		if self:ApplyVerticalMotionController() == false then 
			self:Destroy()
		end
		
		if self:ApplyHorizontalMotionController() == false then
			self:Destroy()
        end
	end
end

function modifier_axe_ex_mobility_movement:OnRefresh( kv )
end

function modifier_axe_ex_mobility_movement:OnDestroy( kv )
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
				damage_type = DAMAGE_TYPE_PURE,
			}

			ApplyDamage( damage )

			enemy:AddNewModifier(
				caster,
				self:GetAbility(),
				"modifier_generic_sleep_lua",
				{ duration = self.sleep_duration }
			)
        end

		self:StopEffects_b()

		--Quits the animation
		local order = 
		{
			OrderType = DOTA_UNIT_ORDER_HOLD_POSITION,
			UnitIndex = self:GetParent():entindex()
		}
		ExecuteOrderFromTable(order)
	end
end

--------------------------------------------------------------------------------
-- Motion effects
function modifier_axe_ex_mobility_movement:SyncTime( iDir, dt )
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

function modifier_axe_ex_mobility_movement:UpdateHorizontalMotion( me, dt )
	self:SyncTime(1, dt)
	local parent = self:GetParent()
	
	-- set position
	local target = self.direction*self.hVelocity*self.elapsedTime

	-- change position
	parent:SetOrigin( self.origin + target )
end

function modifier_axe_ex_mobility_movement:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

function modifier_axe_ex_mobility_movement:UpdateVerticalMotion( me, dt )
	self:SyncTime(2, dt)
	local parent = self:GetParent()

	-- set relative position
	local target = self.vVelocity*self.elapsedTime + 0.5*self.gravity*self.elapsedTime*self.elapsedTime

	-- change height
	parent:SetOrigin( Vector( parent:GetOrigin().x, parent:GetOrigin().y, self.origin.z+target ) )
end

function modifier_axe_ex_mobility_movement:OnVerticalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
--[[ Modifier Effects
function modifier_axe_ex_mobility_movement:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end
function modifier_axe_ex_mobility_movement:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end
]]

--------------------------------------------------------------------------------
-- Status Effects
function modifier_axe_ex_mobility_movement:CheckState()
	local state = {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}

	return state
end


function modifier_axe_ex_mobility_movement:PlayEffects_a()
	if IsServer() then
		-- Create sound
		local sound_cast = "Hero_EarthShaker.Totem"
		EmitSoundOn(sound_cast, self:GetParent())

		-- Create particles	
		local particle_cast_a = "particles/econ/items/earthshaker/earthshaker_arcana/earthshaker_arcana_echoslam_start_v2_special_streak.vpcf"
		local particle_cast_b = "particles/econ/items/earthshaker/earthshaker_arcana/earthshaker_arcana_echoslam_start_debris.vpcf"
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

function modifier_axe_ex_mobility_movement:PlayEffects_b()
	local particle_cast = "particles/generic_gameplay/rune_haste_owner.vpcf"
	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
end


function modifier_axe_ex_mobility_movement:StopEffects_b()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end
