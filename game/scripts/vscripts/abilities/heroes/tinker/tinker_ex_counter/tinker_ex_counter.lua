tinker_ex_counter = class({})
LinkLuaModifier( "modifier_tinker_ex_counter", "abilities/heroes/tinker/tinker_ex_counter/modifier_tinker_ex_counter", LUA_MODIFIER_MOTION_NONE )

function tinker_ex_counter:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("tinker_counter")
end

--------------------------------------------------------------------------------
-- Ability Start
function tinker_ex_counter:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=1.0, activity=ACT_DOTA_TELEPORT_END, translate="bot", rate=1.0})
	caster:AddNewModifier(caster, self , "modifier_cast_point", { 
		duration = cast_point, 
		movement_speed = 10,
		fixed_range = 1,
	})
end

--------------------------------------------------------------------------------
-- Ability Start
function tinker_ex_counter:OnCastPointEnd( point )
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()

	-- load data
	local projectile_name = "particles/mod_units/heroes/hero_oracle/oracle_base_attack.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	
	local damage = self:GetAbilityDamage()
	local duration = self:GetSpecialValueFor("duration")
	
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
		fVisionTickTime = .1,
		fVisionLingerDuration = 1,
		draw = false,
		fRehitDelay = 1.0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
        OnUnitHit = function(_self, unit) 
            
            unit:AddNewModifier(
                caster,
                self,
                "modifier_tinker_ex_counter",
                { duration = duration }
            )

		end,
		OnFinish = function(_self, pos)
			self:PlayEffects_b(pos)
		end,
	}

	self:PlayEffects_a()
	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
	    
	-- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("tinker_counter")
	alternate_version:StartCooldown(self:GetCooldown(0))
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function tinker_ex_counter:PlayEffects_a()
	-- Create Sound
	local sound_cast = "Hero_Tinker.Heat-Seeking_Missile_Dud"
	EmitSoundOn( sound_cast, self:GetCaster()  )
end


function tinker_ex_counter:PlayEffects_b( pos )
	local caster = self:GetCaster()
	
	-- Create Sound
	local sound_cast = "Hero_Wisp.Spirits.Target"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Create Particles
	local particle_cast = "particles/mod_units/heroes/hero_wisp/wisp_guardian_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

