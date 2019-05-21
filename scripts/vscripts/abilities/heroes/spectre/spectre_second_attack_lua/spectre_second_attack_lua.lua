spectre_second_attack_lua = class({})

--------------------------------------------------------------------------------
-- Ability Start
function spectre_second_attack_lua:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	local ability = self

	-- load data
	local projectile_name = "particles/mod_units/heroes/hero_bane/bane_projectile.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	
	local damage = self:GetSpecialValueFor("damage")
	local mana_gain = self:GetSpecialValueFor("mana_gain")
	local damage_bonus = self:GetSpecialValueFor("damage_bonus")
	
	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance = projectile_distance,
		fStartRadius = projectile_start_radius,
		fEndRadius = projectile_end_radius,
		Source = caster,
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
			local final_damage = damage
			
			local damage = {
				victim = unit,
				attacker = caster,
				damage = final_damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}

			ApplyDamage( damage )

			-- Give Mana
			local mana_gain_final = caster:GetMaxMana() * mana_gain
			caster:GiveMana(mana_gain_final)

			self:PlayEffects_b(_self:GetPosition())
			_self.Destroy()
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects_b(pos)
		end,
	}

	self:PlayEffects_a()

	-- Put CD on the ex version of the ability
	local ex_version = caster:FindAbilityByName("spectre_ex_second_attack_lua")
	ex_version:StartCooldown(self:GetCooldown(0))

	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- Cast
function spectre_second_attack_lua:PlayEffects_a()
	-- Get Resources
	local sound_cast = "Hero_Nevermore.Raze_Flames"
	local particle_cast = "particles/units/heroes/hero_spectre/spectre_death_mist.vpcf"

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOn( sound_cast, self:GetCaster() )
end

-- Impact
function spectre_second_attack_lua:PlayEffects_b( pos )
	local caster = self:GetCaster()

	-- Create Sound
    local sound_cast = "Hero_Nevermore.RequiemOfSouls.Damage"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Create Particles
	local particle_cast_a = "particles/units/heroes/hero_spectre/spectre_ambient_endcap.vpcf"
	local particle_cast_b = "particles/mod_units/heroes/hero_bane/bane_projectile_explosion.vpcf"
	
	local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_ABSORIGIN, caster )
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN, caster )
	
	ParticleManager:SetParticleControl( effect_cast_a, 0, pos )
	ParticleManager:SetParticleControl( effect_cast_b, 0, pos )

	ParticleManager:ReleaseParticleIndex( effect_cast_a )
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
end



