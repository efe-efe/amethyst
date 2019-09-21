spectre_ex_second_attack = class({})
LinkLuaModifier( "modifier_spectre_ex_second_attack", "abilities/heroes/spectre/spectre_ex_second_attack/modifier_spectre_ex_second_attack", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_desolate_lua", "abilities/heroes/spectre/spectre_shared_modifiers/modifier_spectre_desolate_lua/modifier_spectre_desolate_lua", LUA_MODIFIER_MOTION_NONE )

function spectre_ex_second_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("spectre_second_attack")
end

--------------------------------------------------------------------------------
-- Ability Start
function spectre_ex_second_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	
	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=1.5, activity=ACT_DOTA_CAST_ABILITY_1, rate=1.0})
	caster:AddNewModifier(
		caster, 
		self, 
		"modifier_cast_point", 
		{ 
			duration = cast_point,
			can_walk = 0,
			fixed_range = 1,
		}
	)
end

--------------------------------------------------------------------------------
-- End casting
function spectre_ex_second_attack:OnCastPointEnd( point )
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	
	-- load data
	local projectile_name = "particles/mod_units/heroes/hero_dark_willow/dark_willow_base_attack.vpcf"
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
    local projectile_vision = 0
	local damage = self:GetAbilityDamage()
	self.debuff_duration = self:GetSpecialValueFor("debuff_duration")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	-- logic
	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = caster:GetAbsOrigin() + Vector(0,0,80),
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
			-- Hit
			--------------------
			local damage = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}

			ApplyDamage( damage )

			--Blind
			unit:AddNewModifier(
				_self.Source, 
				self, 
				"modifier_spectre_ex_second_attack", 
				{ duration = self.debuff_duration }
			)

			--Desolate
			unit:AddNewModifier(
				_self.Source, 
				self, 
				"modifier_spectre_desolate_lua", 
				{ duration = self.debuff_duration }
			)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects(pos)
		end,
	}

	-- Put CD on the alternate version of the ability
	local alternate_version = caster:FindAbilityByName("spectre_second_attack")
	alternate_version:StartCooldown(self:GetCooldown(0))

	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
end


--Impact
function spectre_ex_second_attack:PlayEffects(pos)
	-- Get Resources
    local sound_cast = "Hero_Nevermore.RequiemOfSouls.Damage"
	local particle_cast = "particles/units/heroes/hero_spectre/spectre_ambient_endcap.vpcf"

	-- Create Sound
	EmitSoundOnLocationWithCaster( pos, sound_cast, self:GetCaster() )

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end




