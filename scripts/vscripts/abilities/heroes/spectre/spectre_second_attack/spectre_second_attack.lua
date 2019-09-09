spectre_second_attack = class({})

function spectre_second_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("spectre_ex_second_attack")
end

--------------------------------------------------------------------------------
-- Ability Start
function spectre_second_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	
	self:PlayEffects_a()
	
	-- Animation and pseudo cast point
	StartAnimation(caster, {
		duration = cast_point + 0.1, 
		activity = ACT_DOTA_CAST_ABILITY_1, 
		rate = 0.25
	})

	caster:AddNewModifier(
		caster, 
		self, 
		"modifier_generic_pseudo_cast_point", 
		{ 
			duration = cast_point,
			can_walk = 0,
			fixed_range = 1,
		}
	)
end

--------------------------------------------------------------------------------
-- Ability Start
function spectre_second_attack:OnEndPseudoCastPoint( point )
	local caster = self:GetCaster()

	-- load data
	local projectile_name = "particles/mod_units/heroes/hero_bane/bane_projectile.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	
	local damage = self:GetAbilityDamage()
	local mana_gain = self:GetSpecialValueFor("mana_gain")/100
	
	-- Dynamic data
	local origin = caster:GetOrigin()
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	local projectile = {
		EffectName = 			projectile_name,
		vSpawnOrigin = 			caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance = 			projectile_distance,
		fStartRadius = 			projectile_start_radius,
		fEndRadius = 			projectile_end_radius,
		Source = 				caster,
		vVelocity = 			projectile_direction * projectile_speed,
		UnitBehavior = 			PROJECTILES_DESTROY,
		WallBehavior = 			PROJECTILES_DESTROY,
		TreeBehavior = 			PROJECTILES_NOTHING,
		GroundBehavior = 		PROJECTILES_NOTHING,
		bMultipleHits = 		true,
		bIgnoreSource = 		true,
		bCutTrees = 			true,
		bTreeFullCollision = 	false,
		fGroundOffset = 		80,
		nChangeMax = 			1,
		bRecreateOnChange = 	true,
		bZCheck = 				false,
		bGroundLock = 			true,
		bProvidesVision = 		true,
		iVisionRadius = 		200,
		iVisionTeamNumber = 	caster:GetTeam(),
		bFlyingVision = 		false,
		fVisionTickTime = 		.1,
		fVisionLingerDuration = 1,
		fRehitDelay = 1.0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}

			ApplyDamage( damage_table )

			-- Give Mana
			local mana_gain_final = caster:GetMaxMana() * mana_gain
			caster:GiveMana(mana_gain_final)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects_b(pos)
		end,
	}
	EmitSoundOn( "Hero_Nevermore.Raze_Flames", self:GetCaster() )

	-- Put CD on the alternate version of the ability
	local ex_version = caster:FindAbilityByName("spectre_ex_second_attack")
	ex_version:StartCooldown(self:GetCooldown(0))

	-- Cast projectile
	Projectiles:CreateProjectile(projectile)

	StartAnimation(caster, {duration=0.2, activity=ACT_DOTA_CAST_ABILITY_1, rate=2.0})
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- Cast
function spectre_second_attack:PlayEffects_a()
	EmitSoundOn( "Hero_Spectre.Haunt", self:GetCaster())
	-- Get Resources
	local particle_cast = "particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_sunder_ti8_swirl_rope.vpcf"

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 15, Vector(128, 32, 108) )
	ParticleManager:SetParticleControl( effect_cast, 16, Vector(1, 0, 0) )

	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- Impact
function spectre_second_attack:PlayEffects_b( pos )
	local caster = self:GetCaster()

	-- Create Sound
    local sound_cast = "Hero_Nevermore.RequiemOfSouls.Damage"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Create Particles
	local particle_cast_a = "particles/econ/items/death_prophet/death_prophet_ti9/death_prophet_silence_ti9_ground_smoke.vpcf"
	local particle_cast_b = "particles/mod_units/heroes/hero_bane/bane_projectile_explosion.vpcf"
	
	local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_ABSORIGIN, caster )
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN, caster )
	
	ParticleManager:SetParticleControl( effect_cast_a, 0, pos )
	ParticleManager:SetParticleControl( effect_cast_b, 0, pos )

	ParticleManager:ReleaseParticleIndex( effect_cast_a )
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
end




