
phantom_ex_special_attack = class({})
LinkLuaModifier( "modifier_generic_sleep_lua", "abilities/generic/modifier_generic_sleep_lua", LUA_MODIFIER_MOTION_NONE )

function phantom_ex_special_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("phantom_special_attack")
end

--------------------------------------------------------------------------------
-- Ability Start
function phantom_ex_special_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	
	-- Animation and pseudo cast point
	StartAnimation(caster, {
		duration = cast_point + 0.1, 
		activity = ACT_DOTA_CAST_ABILITY_3, 
		rate = 1.2 
	})
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { 
		duration = cast_point, 
		can_walk = 0 
	})
end


--------------------------------------------------------------------------------
-- Ability Start
function phantom_ex_special_attack:OnEndPseudoCastPoint( point )
	-- Initialize variables
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local sleep_duration = self:GetSpecialValueFor("sleep_duration")
	local damage = self:GetAbilityDamage()

	-- Projectile data
    local projectile_name = "particles/mod_units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger_arcana.vpcf"
	local projectile_start_radius = 50
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

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
		bMultipleHits = false,
		bIgnoreSource = true,
		TreeBehavior = PROJECTILES_NOTHING,
		bCutTrees = true,
		bTreeFullCollision = false,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
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
			local damage = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
			}
	
			ApplyDamage( damage )
	
			-- Add modifier
			unit:AddNewModifier(
				caster, -- player source
				self, -- ability source
				"modifier_generic_sleep_lua", -- modifier name
				{ duration = sleep_duration } -- kv
			)
			
			if unit:IsRealHero() and _self.Source == caster then 
				-- Add modifier
				caster:AddNewModifier(
					caster, -- player source
					self, -- ability source
					"modifier_phantom_assassin_strike_stack_lua", -- modifier name
					{} -- kv
				)
			end
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects_a(pos)
		end,
	}

	self:PlayEffects_b()
	-- Cast projectile
	Projectiles:CreateProjectile(projectile)

	-- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("phantom_special_attack")
	alternate_version:StartCooldown(self:GetCooldown(0))
	
end

--------------------------------------------------------------------------------
-- Effects

-- On Projectile finish
function phantom_ex_special_attack:PlayEffects_a( pos )
	-- Create Sound
	local sound_cast = "Hero_PhantomAssassin.Dagger.Target"
	EmitSoundOnLocationWithCaster( pos, sound_cast, self:GetCaster() )
	
	-- Create Particles
	local particle_cast = "particles/mod_units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- On ability start
function phantom_ex_special_attack:PlayEffects_b( )
	-- Create Sound
	local sound_cast = "Hero_PhantomAssassin.Dagger.Cast"
	EmitSoundOn( sound_cast, self:GetCaster() )
end