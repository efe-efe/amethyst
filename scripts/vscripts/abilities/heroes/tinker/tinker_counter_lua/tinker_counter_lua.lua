tinker_counter_lua = class({})
LinkLuaModifier( "modifier_generic_pseudo_cast_point_lua", "abilities/generic/modifier_generic_pseudo_cast_point_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_pre_silence_lua", "abilities/generic/modifier_generic_pre_silence_lua", LUA_MODIFIER_MOTION_NONE )

function tinker_counter_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Phase Start
function tinker_counter_lua:OnAbilityPhaseStart()
	-- effects
	local sound_cast = "Hero_Tinker.LaserAnim"
	EmitSoundOn( sound_cast, self:GetCaster() )

	return true -- if success
end

--------------------------------------------------------------------------------
-- Ability Start
function tinker_counter_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
    local point = self:GetCursorPosition()
	local cast_point = self:GetCastPoint()

	-- load data
	local duration = 1.0--self:GetSpecialValueFor("duration")
	local damage = self:GetSpecialValueFor("damage")
	local radius = self:GetSpecialValueFor("radius")

	-- precache damage
	local damage = {
		-- victim = hTarget,
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self
	}

	-- Animation and pseudo cast point
	self:Animate(point)
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point_lua", { duration = cast_point})
	-- After cast point
	Timers:CreateTimer(cast_point, function()
		
		-- find enemies
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),	-- int, your team number
			point,	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			0,	-- int, flag filter
			FIND_CLOSEST,	-- int, order filter
			false	-- bool, can grow cache
		)

		-- effects
		if #enemies > 0 then
			
			-- get targets
			local targets = {}
			local i = 0
			while enemies[i] == nil do i = i + 1 end

			if enemies[i]:TriggerSpellAbsorb( self ) then return end


			local is_slower = enemies[i]:FindModifierByName("modifier_generic_projectile_slower_lua")
			if is_slower ~= nil then
				if not is_slower:IsNull() then
					self:PlayEffects_b( point )
					return
				end
			end

			table.insert( targets, enemies[i] )
	
			self:Refract( targets, 1 )

			for _,target in pairs(targets) do
				-- apply damage
				damage.victim = target
				ApplyDamage( damage )

				target:AddNewModifier(
					caster, -- player source
					self, -- ability source
					"modifier_generic_pre_silence_lua", -- modifier name
					{ duration = duration } -- kv
				)
			end
			self:PlayEffects_a( targets )
		else
			self:PlayEffects_b( point )
		end
	end)
end

function tinker_counter_lua:Refract( targets, jumps )
	-- load data
	local jump_range = self:GetSpecialValueFor("bounce_range")

	-- Find Units in Radius
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		targets[jumps]:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		jump_range,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		FIND_CLOSEST,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- check for valid closest not-yet-affected next target 
	local next_target = nil
	for _,enemy in pairs(enemies) do

		local is_slower = enemy:FindModifierByName("modifier_generic_projectile_slower_lua")
		if is_slower ~= nil then
			if not is_slower:IsNull() then
				return
			end
		end

		local candidate = true
		for _,target in pairs(targets) do
			if enemy==target then
				candidate = false
				break
			end
		end
		if candidate then
			next_target = enemy
			break
		end
	end

	-- recursive
	if next_target then
		table.insert( targets, next_target )
		self:Refract( targets, jumps + 1 )
	end
end

--------------------------------------------------------------------------------
function tinker_counter_lua:PlayEffects_a( targets )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_tinker/tinker_laser.vpcf"
	local sound_cast = "Hero_Tinker.Laser"
	local sound_target = "Hero_Tinker.LaserImpact"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )

	local attach = "attach_attack1"
	if self:GetCaster():ScriptLookupAttachment( "attach_attack2" )~=0 then attach = "attach_attack2" end
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		9,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		attach,
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		targets[1],
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
	EmitSoundOn( sound_target, targets[1] )

	if #targets>1 then
		for i=2,#targets do
			-- Create Particle
			local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
			ParticleManager:SetParticleControlEnt(
				effect_cast,
				9,
				targets[i-1],
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				Vector(0,0,0), -- unknown
				true -- unknown, true
			)
			ParticleManager:SetParticleControlEnt(
				effect_cast,
				1,
				targets[i],
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				Vector(0,0,0), -- unknown
				true -- unknown, true
			)
			ParticleManager:ReleaseParticleIndex( effect_cast )

			-- create sound
			EmitSoundOn( sound_target, targets[i] )
		end
	end
end


--------------------------------------------------------------------------------
function tinker_counter_lua:PlayEffects_b( point )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_tinker/tinker_laser.vpcf"
	local sound_cast = "Hero_Tinker.Laser"
	local sound_target = "Hero_Tinker.LaserImpact"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )

	local attach = "attach_attack1"
	if self:GetCaster():ScriptLookupAttachment( "attach_attack2" )~=0 then attach = "attach_attack2" end
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		9,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		attach,
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 1, point )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
	EmitSoundOnLocationWithCaster( point, sound_target, self:GetCaster() )
end

function tinker_counter_lua:Animate(point)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local angles = caster:GetAngles()

	local direction = (point - origin)
	local directionAsAngle = VectorToAngles(direction)
	caster:SetAngles(angles.x, directionAsAngle.y, angles.z)
	StartAnimation(caster, {duration=1.0, activity=ACT_DOTA_TELEPORT_END, translate="bot", rate=1.0})
end

