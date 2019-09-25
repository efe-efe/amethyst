sky_basic_attack = class({})
LinkLuaModifier( "modifier_sky_basic_attack", "abilities/heroes/skywrath_mage/sky_basic_attack/modifier_sky_basic_attack", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sky_basic_attack_debuff", "abilities/heroes/skywrath_mage/sky_basic_attack/modifier_sky_basic_attack_debuff", LUA_MODIFIER_MOTION_NONE )

function sky_basic_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("sky_ex_basic_attack")
end

--------------------------------------------------------------------------------
--Passive Modifier
function sky_basic_attack:GetIntrinsicModifierName()
	return "modifier_sky_basic_attack"
end

--------------------------------------------------------------------------------
-- Ability Start
function sky_basic_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = caster:GetAttackAnimationPoint()

	--self.charges = caster:FindModifierByName("modifier_sky_basic_attack"):GetStackCount()
    self.silence_duration = self:GetSpecialValueFor("silence_duration")

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=1.5, activity=ACT_DOTA_ATTACK, rate=1.5})
	caster:AddNewModifier(caster, self , "modifier_cast_point", { 
		duration = cast_point,
		placeholder = 0,
		movement_speed = 10
	})
end

function sky_basic_attack:OnCastPointEnd( pos )
	local caster = self:GetCaster()

	-- Projectile data
	local projectile_name = "particles/mod_units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local damage_bonus_charged = self:GetSpecialValueFor("damage_bonus")

	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )

	local modifier = caster:FindModifierByName("modifier_sky_basic_attack")
	local stacks = modifier:GetStackCount() 
	if stacks == 0 then
		projectile_name = "particles/mod_units/heroes/hero_skywrath_mage/skywrath_mage_base_attack.vpcf"
	end

	-- Dynamic data
	local origin = caster:GetOrigin()
	local projectile_direction = (Vector( pos.x-origin.x, pos.y-origin.y, 0 )):Normalized()

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

			--Apply charged weapon effects
			if stacks > 0 then
				--Silence enemy
				unit:AddNewModifier(_self.Source, self , "modifier_generic_silenced_lua", { duration = self.silence_duration})
				unit:AddNewModifier(_self.Source, self , "modifier_sky_basic_attack_debuff", { duration = self.silence_duration})

				local damage = {
					victim = unit,
					attacker = _self.Source,
					damage = damage_bonus_charged,
					damage_type = DAMAGE_TYPE_PHYSICAL,
				}
		
				ApplyDamage( damage )
			end
		end,
		OnFinish = function(_self, pos)
			--Apply charged weapon effects
			if stacks > 0 then
				self:PlayEffects_b(pos)
			else
				self:PlayEffects_d(pos)
			end
		end,
	}
	
	--Remove the extra attack
	if stacks > 0 then
		self:PlayEffects_a()
	else
		self:PlayEffects_c()
	end
	
	modifier:DecrementStackCount()
	modifier:CalculateCharge()
	Projectiles:CreateProjectile(projectile)
	self:StartCooldown(attack_speed)
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- Charged
function sky_basic_attack:PlayEffects_a()
	local caster = self:GetCaster()

	-- Create Sound
	local sound_cast = "Hero_SkywrathMage.ConcussiveShot.Cast"
	EmitSoundOn( sound_cast, self:GetCaster() )

	-- Cast Particle
	local particle_cast = "particles/mod_units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot_cast.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, caster:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, caster:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function sky_basic_attack:PlayEffects_b( pos )
	local caster = self:GetCaster()

	-- Create Sound
	local sound_cast = "Hero_SkywrathMage.ConcussiveShot.Target"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Cast Particle
	local particle_cast = "particles/mod_units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot_impact.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 1, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- Non Charged
function sky_basic_attack:PlayEffects_c()
	-- Create Sound
	local sound_cast = "Hero_SkywrathMage.Attack"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function sky_basic_attack:PlayEffects_d( pos )
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


--------------------------------------------------------------------------------
-- On First Upgrade Effects
function sky_basic_attack:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	end
end
