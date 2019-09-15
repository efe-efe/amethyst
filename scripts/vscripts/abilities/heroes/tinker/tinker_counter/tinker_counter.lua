tinker_counter = class({})
LinkLuaModifier( "modifier_generic_pre_silence_lua", "abilities/generic/modifier_generic_pre_silence_lua", LUA_MODIFIER_MOTION_NONE )

function tinker_counter:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("tinker_ex_counter")
end

--------------------------------------------------------------------------------
-- Ability Phase Start
function tinker_counter:OnAbilityPhaseStart()
	-- effects
	local sound_cast = "Hero_Tinker.LaserAnim"
	EmitSoundOn( sound_cast, self:GetCaster() )

	return true -- if success
end

--------------------------------------------------------------------------------
-- Ability Start
function tinker_counter:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=cast_point+0.1, activity=ACT_DOTA_TELEPORT_END, translate="bot", rate=1.0})
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { 
		duration = cast_point,
		movement_speed = 10,
		fixed_range = 1,
		show_all = 1,
	})
end

function tinker_counter:Refract( source, targets, jumps )
	-- load data
	local jump_range = self:GetSpecialValueFor("bounce_range")

	-- Find Units in Radius
	local enemies = FindUnitsInRadius(
		source:GetTeamNumber(),	-- int, your team number
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

	if next_target ~= nil then
		-- load data
		local origin = targets[jumps]:GetOrigin()
		local point = next_target:GetOrigin()
		local duration = self:GetSpecialValueFor("duration")
		local damage = self:GetAbilityDamage()

		local projectile_name = ""
		local projectile_start_radius = self:GetSpecialValueFor("hitbox")
		local projectile_end_radius = self:GetSpecialValueFor("hitbox")
		local projectile_distance = self:GetSpecialValueFor("projectile_range")
		local projectile_speed = 8000
		local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, -80 )):Normalized()

		-- Projectile
		local projectile = {
			EffectName = projectile_name,
			vSpawnOrigin = origin,
			fDistance = projectile_distance,
			fStartRadius = projectile_start_radius,
			fEndRadius = projectile_end_radius,
			Source = source,
			fExpireTime = 8.0,
			vVelocity = projectile_direction * projectile_speed,
			UnitBehavior = PROJECTILES_NOTHING,
			bMultipleHits = true,
			bIgnoreSource = true,
			TreeBehavior = PROJECTILES_NOTHING,
			bCutTrees = true,
			bTreeFullCollision = false,
			WallBehavior = PROJECTILES_DESTROY,
			GroundBehavior = PROJECTILES_NOTHING,
			fGroundOffset = 80,
			nChangeMax = 1,
			bRecreateOnChange = true,
			bZCheck = false,
			bGroundLock = true,
			bProvidesVision = true,
			iVisionRadius = 200,
			iVisionTeamNumber = source:GetTeam(),
			bFlyingVision = false,
			bIsSlowable = false,
			bIsReflectable = false,
			fVisionTickTime = .1,
			fVisionLingerDuration = 1,
			draw = false,
			fRehitDelay = 1.0,
			UnitTest = function(_self, unit) 
				return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() and unit ~= targets[jumps]
			end,
			OnUnitHit = function(_self, unit) 

				-- Count targets
				local counter = 0
				for k, v in pairs(_self.rehit) do
					counter = counter + 1
				end

				if counter > 0 then return end

				-- precache damage
				local damage = {
					victim = unit,
					attacker = source,
					damage = damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
					ability = self
				}
				
				ApplyDamage( damage )

				unit:AddNewModifier(
					source, -- player source
					self, -- ability source
					"modifier_generic_pre_silence_lua", -- modifier name
					{ duration = duration } -- kv
				)

				table.insert( targets, next_target )
				self:Refract( source, targets, jumps+1 )

				self:PlayEffects_a(targets[jumps], next_target)
				_self.Destroy()
			end,
			OnFinish = function(_self, pos)
				self:PlayEffects_b(targets[jumps], pos)
			end,
		}
		Projectiles:CreateProjectile(projectile)
	end
end


function tinker_counter:OnEndPseudoCastPoint( point )
	-- load data
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	local damage = self:GetAbilityDamage()
	local mana_gain = self:GetSpecialValueFor("mana_gain")/100

	-- Projectile data
	local projectile_name = ""
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = 8000

	-- Dinamyc data
	local origin = caster:GetOrigin()
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, -80 )):Normalized()

	-- Projectile
	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin =  {unit=caster, attach="attach_attack1", offset=Vector(0,0,0)},
		fDistance = projectile_distance,
		fStartRadius = projectile_start_radius,
		fEndRadius = projectile_end_radius,
		Source = caster,
		fExpireTime = 8.0,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		bMultipleHits = true,
		bIgnoreSource = true,
		TreeBehavior = PROJECTILES_NOTHING,
		bCutTrees = true,
		bTreeFullCollision = false,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		nChangeMax = 1,
		bRecreateOnChange = true,
		bZCheck = false,
		bGroundLock = true,
		bProvidesVision = true,
		iVisionRadius = 200,
		iVisionTeamNumber = caster:GetTeam(),
		bFlyingVision = false,
		bIsSlowable = false,
		fVisionTickTime = .1,
		fVisionLingerDuration = 1,
		draw = false,
		fRehitDelay = 1.0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
		OnUnitHit = function(_self, unit)
			-- precache damage
			local damage = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self
			}
			
			ApplyDamage( damage )

			unit:AddNewModifier(
				_self.Source, -- player source
				self, -- ability source
				"modifier_generic_pre_silence_lua", -- modifier name
				{ duration = duration } -- kv
			)

			-- Give Mana
			local mana_gain_final = _self.Source:GetMaxMana() * mana_gain
			_self.Source:GiveMana(mana_gain_final)

			-- get targets
			local targets = {}
			table.insert( targets, unit )
			self:Refract( _self.Source, targets, 1 )

			self:PlayEffects_a(_self.Source, unit)
		end,
		OnFinish = function(_self, pos)
			if next(_self.rehit) == nil then
				self:PlayEffects_b(_self.Source, pos)
			end
		end,
	}
	Projectiles:CreateProjectile(projectile)
		    
	-- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("tinker_ex_counter")
	alternate_version:StartCooldown(self:GetCooldown(0))
end

--------------------------------------------------------------------------------
-- Graphics & animation
function tinker_counter:PlayEffects_a( source, target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_tinker/tinker_laser.vpcf"
	local sound_cast = "Hero_Tinker.Laser"
	local sound_target = "Hero_Tinker.LaserImpact"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, source )

	local attach = "attach_attack1"
	if source:ScriptLookupAttachment( "attach_attack2" )~=0 then attach = "attach_attack2" end
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		9,
		source,
		PATTACH_POINT_FOLLOW,
		attach,
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
	EmitSoundOn( sound_target, target )
end

function tinker_counter:PlayEffects_b( source, point )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_tinker/tinker_laser.vpcf"
	local sound_cast = "Hero_Tinker.Laser"
	local sound_target = "Hero_Tinker.LaserImpact"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, source )

	local attach = "attach_attack1"
	if source:ScriptLookupAttachment( "attach_attack2" )~=0 then attach = "attach_attack2" end
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		9,
		source,
		PATTACH_POINT_FOLLOW,
		attach,
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 1, point )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, source )
	EmitSoundOnLocationWithCaster( point, sound_target, source )
end