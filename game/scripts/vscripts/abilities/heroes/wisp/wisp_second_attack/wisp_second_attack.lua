wisp_second_attack = class ({})

--------------------------------------------------------------------------------
-- Ability Start
function wisp_second_attack:OnSpellStart()
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	caster:AddNewModifier(
		caster,
		self,
		"modifier_cast_point_old",
		{ 
			duration = cast_point, 
			can_walk = 0,
			fixed_range = 1,
		}
	)
end

--------------------------------------------------------------------------------
-- Ability Start
function wisp_second_attack:OnCastPointEnd( pos )
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()

	-- load data
	local projectile_name = "particles/mod_units/heroes/hero_wisp/wisp_guardian.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_direction = (Vector( pos.x-origin.x, pos.y-origin.y, 0 )):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	
	local damage = self:GetAbilityDamage()
	local mana_gain = self:GetSpecialValueFor("mana_gain")/100
	
	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = {unit=caster, attach="attach_attack1", offset=Vector(0,0,0)},
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

			local damage = {
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}

			ApplyDamage( damage )
			
			-- Give Mana
			local mana_gain_final = caster:GetMaxMana() * mana_gain
			caster:GiveMana(mana_gain_final)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects_b(pos)
		end,
	}

	self:PlayEffects_a()
	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function wisp_second_attack:PlayEffects_a()
	-- Create Sound
	local sound_cast = "Hero_Wisp.TeleportOut"
	EmitSoundOn( sound_cast, self:GetCaster()  )

	-- Create Particles
	local particle_cast_a = "particles/econ/items/wisp/wisp_relocate_marker_ti7_out_embers.vpcf"
	local particle_cast_b = "particles/econ/items/wisp/wisp_guardian_explosion_ti7.vpcf"

	local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )

	ParticleManager:ReleaseParticleIndex( effect_cast_a )
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
end


function wisp_second_attack:PlayEffects_b( pos )
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

