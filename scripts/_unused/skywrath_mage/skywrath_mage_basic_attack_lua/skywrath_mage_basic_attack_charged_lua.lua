skywrath_mage_basic_attack_charged_lua = class({})
LinkLuaModifier( "modifier_skywrath_mage_basic_attack_charged_timer_lua", "abilities/heroes/skywrath_mage/skywrath_mage_basic_attack_lua/modifier_skywrath_mage_basic_attack_charged_timer_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_silenced_lua", "abilities/generic/modifier_generic_silenced_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skywrath_mage_basic_attack_lua", "abilities/heroes/skywrath_mage/skywrath_mage_basic_attack_lua/modifier_skywrath_mage_basic_attack_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skywrath_mage_basic_attack_charged_visuals_lua", "abilities/heroes/skywrath_mage/skywrath_mage_basic_attack_lua/modifier_skywrath_mage_basic_attack_charged_visuals_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skywrath_mage_basic_attack_charged_debuff_visuals_lua", "abilities/heroes/skywrath_mage/skywrath_mage_basic_attack_lua/modifier_skywrath_mage_basic_attack_charged_debuff_visuals_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_pseudo_cast_point_lua", "abilities/generic/modifier_generic_pseudo_cast_point_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function skywrath_mage_basic_attack_charged_lua:OnSpellStart()
	-- Initialize bariables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	self.point = self:GetCursorPosition()
	self.non_charged_version = caster:FindAbilityByName("skywrath_mage_basic_attack_lua")

	-- Animation and pseudo cast point
	self:Animate(self.point)
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point_lua", { duration = cast_point})
end

function skywrath_mage_basic_attack_charged_lua:OnEndPseudoCastPoint()
	local caster = self:GetCaster()
	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )

	-- Projectile data
	local projectile_name = "particles/mod_units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	-- Extra data
	local silence_duration = self:GetSpecialValueFor("silence_duration")
	local modifier_duration_bonus = self:GetSpecialValueFor("modifier_duration_bonus")

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
			-- Add damage
			_self.Source:AddNewModifier(_self.Source, self, "modifier_skywrath_mage_basic_attack_lua", {})

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

			--Silence enemy
			unit:AddNewModifier(_self.Source, self , "modifier_generic_silenced_lua", { duration = silence_duration})
			unit:AddNewModifier(_self.Source, self , "modifier_skywrath_mage_basic_attack_charged_debuff_visuals_lua", { duration = silence_duration})

			self:PlayEffects_b(_self:GetPosition())
			_self.Destroy()
		end,
		OnFinish = function(_self, pos)
			--Remove the extra attack
			SafeDestroyModifier("modifier_skywrath_mage_basic_attack_lua", _self.Source, _self.Source)
			self:PlayEffects_b(pos)
		end,
	}

	-- Put the non charged ability on the basic attack slot
	caster:SwapAbilities( 
		"skywrath_mage_basic_attack_charged_lua",
		"skywrath_mage_basic_attack_lua",
		false,
		true
	)
	--Adds the timer that swaps the abilities
	caster:AddNewModifier(caster, self , "modifier_skywrath_mage_basic_attack_charged_timer_lua", {duration = self:GetCooldown(0)})
	
	-- Destroy visual modifier
	SafeDestroyModifier("modifier_skywrath_mage_basic_attack_charged_visuals_lua", caster, caster)

	self:PlayEffects_a()
	Projectiles:CreateProjectile(projectile)	
	self:StartCooldown(attack_speed)
	self.non_charged_version:StartCooldown(attack_speed)
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function skywrath_mage_basic_attack_charged_lua:PlayEffects_a()
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

function skywrath_mage_basic_attack_charged_lua:PlayEffects_b( pos )
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

--------------------------------------------------------------------------------
-- On First Upgrade Effects
function skywrath_mage_basic_attack_charged_lua:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		-- Visuals
		caster:AddNewModifier(caster,self,"modifier_skywrath_mage_basic_attack_charged_visuals_lua", {} )
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	end
end

function skywrath_mage_basic_attack_charged_lua:Animate(point)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local angles = caster:GetAngles()

	local direction = (point - origin)
	local directionAsAngle = VectorToAngles(direction)
	caster:SetAngles(angles.x, directionAsAngle.y, angles.z)
	StartAnimation(caster, {duration=1.5, activity=ACT_DOTA_ATTACK, rate=1.5})
end