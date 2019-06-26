spectre_second_attack = class({})
LinkLuaModifier( "modifier_generic_pseudo_cast_point_lua", "abilities/generic/modifier_generic_pseudo_cast_point_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function spectre_second_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	self.point = self:GetCursorPosition()
	local cast_point = self:GetCastPoint()
	
	-- Animation and pseudo cast point
	self:Animate(self.point)
	caster:AddNewModifier(
		caster, 
		self, 
		"modifier_generic_pseudo_cast_point_lua", 
		{ duration = cast_point }
	)
end

--------------------------------------------------------------------------------
-- Ability Start
function spectre_second_attack:OnEndPseudoCastPoint()
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
	local projectile_direction = (Vector( self.point.x-origin.x, self.point.y-origin.y, 0 )):Normalized()

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

	self:PlayEffects_a()

	-- Put CD on the alternate version of the ability
	local ex_version = caster:FindAbilityByName("spectre_ex_second_attack")
	ex_version:StartCooldown(self:GetCooldown(0))

	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- Cast
function spectre_second_attack:PlayEffects_a()
	-- Get Resources
	local sound_cast = "Hero_Nevermore.Raze_Flames"
	local particle_cast = "particles/units/heroes/hero_spectre/spectre_death_mist.vpcf"

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOn( sound_cast, self:GetCaster() )
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


function spectre_second_attack:Animate(point)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local angles = caster:GetAngles()

	local direction = (point - origin)
	local directionAsAngle = VectorToAngles(direction)
	caster:SetAngles(angles.x, directionAsAngle.y, angles.z)
	StartAnimation(caster, {duration=1.5, activity=ACT_DOTA_CAST_ABILITY_1, rate=0.25})
end




