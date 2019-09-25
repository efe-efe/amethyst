phoenix_basic_attack = class({})
LinkLuaModifier( "modifier_phoenix_basic_attack", "abilities/heroes/phoenix/phoenix_basic_attack/modifier_phoenix_basic_attack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function phoenix_basic_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = caster:GetAttackAnimationPoint()
	self:SetActivated(false)

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=1.5, activity=ACT_DOTA_ATTACK, rate=1.5})
	caster:AddNewModifier(caster, self , "modifier_cast_point", { duration = cast_point})
end

function phoenix_basic_attack:OnCastPointEnd( pos )
	local caster = self:GetCaster()
	self:SetActivated(true)

	-- Projectile data
	local projectile_name = "particles/mod_units/heroes/hero_phoenix/phoenix_base_attack.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )

	-- Extra data
	local duration = self:GetSpecialValueFor("duration")

	-- Dynamic data
	local origin = caster:GetOrigin()
	local projectile_direction = (Vector( pos.x-origin.x, pos.y-origin.y, 0 )):Normalized()

	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = origin + Vector(0, 0, 80),
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

			-- perform the actual attack
			_self.Source:PerformAttack(
				unit, -- handle hTarget 
				true, -- bool bUseCastAttackOrb, 
				true, -- bool bProcessProcs,
				true, -- bool bSkipCooldown
				false, -- bool bIgnoreInvis
				false, -- bool bUseProjectile
				false, -- bool bFakeAttack
				true -- bool bNeverMiss
			)

			unit:AddNewModifier(
				_self.Source,
				self,
				"modifier_phoenix_basic_attack",
				{ duration = duration }
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
end

function phoenix_basic_attack:OnStopPseudoCastPoint()
	self:SetActivated(true)
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Projectile starts
function phoenix_basic_attack:PlayEffects_a()
	-- Create Sound
	local sound_cast = "Hero_Phoenix.Attack"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

-- On Projectile impacts
function phoenix_basic_attack:PlayEffects_b( pos )
	local caster = self:GetCaster()

	-- Create Sound
	local sound_cast = "Hero_Phoenix.ProjectileImpact"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Cast Particle
	local particle_cast = "particles/mod_units/heroes/hero_phoenix/phoenix_base_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 1, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

--------------------------------------------------------------------------------
-- On First Upgrade Effects
function phoenix_basic_attack:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	end
end
