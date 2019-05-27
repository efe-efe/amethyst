skywrath_mage_basic_attack_lua = class({})
LinkLuaModifier( "modifier_generic_pseudo_cast_point_lua", "abilities/generic/modifier_generic_pseudo_cast_point_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function skywrath_mage_basic_attack_lua:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	local point = self:GetCursorPosition()
	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )
	
	-- Projectile data
	local projectile_name = "particles/mod_units/heroes/hero_skywrath_mage/skywrath_mage_base_attack.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	-- Extra data
	local debuff_duration = self:GetSpecialValueFor("debuff_duration")
	local modifier_duration_bonus = self:GetSpecialValueFor("modifier_duration_bonus")

	-- Animation and pseudo cast point
	self:Animate(point)
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point_lua", { duration = cast_point})

	Timers:CreateTimer(cast_point, function()

		-- Dinamyc data
		local origin = caster:GetOrigin()
		local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

		-- Projectile
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
				caster:PerformAttack(
					unit, -- handle hTarget 
					true, -- bool bUseCastAttackOrb, 
					true, -- bool bProcessProcs,
					true, -- bool bSkipCooldown
					false, -- bool bIgnoreInvis
					false, -- bool bUseProjectile
					false, -- bool bFakeAttack
					false -- bool bNeverMiss
				)

				self:PlayEffects_b(_self:GetPosition())
				_self.Destroy()
			end,
			OnFinish = function(_self, pos)
				self:PlayEffects_b(pos)
			end,
		}
		
		self:PlayEffects_a()
		Projectiles:CreateProjectile(projectile)
		self:StartCooldown(attack_speed)
	end)
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function skywrath_mage_basic_attack_lua:PlayEffects_a()
	-- Create Sound
	local sound_cast = "Hero_SkywrathMage.Attack"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function skywrath_mage_basic_attack_lua:PlayEffects_b( pos )
	local caster = self:GetCaster()
	
	-- Create Sound
	local sound_cast = "Hero_SkywrathMage.ProjectileImpact"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Cast Particle
	local particle_cast = "particles/mod_units/heroes/hero_skywrath_mage/skywrath_mage_base_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
end

function skywrath_mage_basic_attack_lua:Animate(point)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local angles = caster:GetAngles()

	local direction = (point - origin)
	local directionAsAngle = VectorToAngles(direction)
	caster:SetAngles(angles.x, directionAsAngle.y, angles.z)
	StartAnimation(caster, {duration=1.5, activity=ACT_DOTA_ATTACK, rate=2.5})
end