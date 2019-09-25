sniper_basic_attack = class({})
LinkLuaModifier( "modifier_sniper_basic_attack_charges", "abilities/heroes/sniper/sniper_basic_attack/modifier_sniper_basic_attack_charges", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
--Passive Modifier
function sniper_basic_attack:GetIntrinsicModifierName()
	return "modifier_sniper_basic_attack_charges"
end

--------------------------------------------------------------------------------
-- Ability Start
function sniper_basic_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = caster:GetAttackAnimationPoint()

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.2, activity=ACT_DOTA_RUN, translate="aggressive", rate=2.0})
	caster:AddNewModifier(
		caster,
		self,
		"modifier_cast_point",
		{ 
			duration = cast_point,
			placeholder = 0,
			movement_speed = 30,
		}
	)
end

function sniper_basic_attack:OnCastPointEnd( pos )
	local caster = self:GetCaster()

	-- Projectile data
	local projectile_name = "particles/mod_units/heroes/hero_sniper/hero_gyrocopter_gyrotechnics/gyro_base_attack.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local modifier = caster:FindModifierByName("modifier_sniper_basic_attack_charges")

	self:SetActivated(true)

	-- Dinamyc data
	local origin = caster:GetOrigin()
	local projectile_direction = (Vector( pos.x-origin.x, pos.y-origin.y, 0 )):Normalized()

	-- Projectile
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
			caster:PerformAttack(
				unit, -- handle hTarget 
				true, -- bool bUseCastAttackOrb, 
				true, -- bool bProcessProcs,
				true, -- bool bSkipCooldown
				false, -- bool bIgnoreInvis
				false, -- bool bUseProjectile
				false, -- bool bFakeAttack
				true -- bool bNeverMiss
			)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects_b(pos)
		end,
	}

	modifier:DecrementStackCount()
	modifier:CalculateCharge()
	
	self:PlayEffects_a()
	Projectiles:CreateProjectile(projectile)
end

function sniper_basic_attack:OnStopPseudoCastPoint()
	self:SetActivated(true)
end

--------------------------------------------------------------------------------
-- Misc
-- Add mana on attack modifier. Only first time upgraded
function sniper_basic_attack:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	end
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On ability start
function sniper_basic_attack:PlayEffects_a()
	-- Create Sound
	local sound_cast = "Hero_Sniper.MKG_attack"	
	EmitSoundOn( sound_cast, self:GetCaster() )
end


-- On Projectile finish
function sniper_basic_attack:PlayEffects_b( pos )
	local caster = self:GetCaster()
	
	-- Create Sound
	local sound_cast = "Hero_Sniper.ProjectileImpact"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Create Particle
	local particle_cast = "particles/mod_units/heroes/hero_sniper/hero_gyrocopter_gyrotechnics/gyro_base_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function sniper_basic_attack:Animate(point)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local angles = caster:GetAngles()

	local direction = (point - origin)
	local directionAsAngle = VectorToAngles(direction)
	caster:SetAngles(angles.x, directionAsAngle.y, angles.z)
end



