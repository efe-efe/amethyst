tinker_basic_attack = class({})
LinkLuaModifier( "modifier_generic_pseudo_cast_point_lua", "abilities/generic/modifier_generic_pseudo_cast_point_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function tinker_basic_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = caster:GetAttackAnimationPoint()

	self.point = self:GetCursorPosition()

	-- Animation and pseudo cast point
	self:Animate(self.point)
	caster:AddNewModifier(
		caster, 
		self , 
		"modifier_generic_pseudo_cast_point_lua", 
		{ duration = cast_point }
	)
end

function tinker_basic_attack:OnEndPseudoCastPoint()
	local caster = self:GetCaster()

	-- Projectile data
	local projectile_name = "particles/mod_units/heroes/hero_tinker/tinker_base_attack.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	-- Dinamyc data
	local origin = caster:GetOrigin()
	local projectile_direction = (Vector( self.point.x-origin.x, self.point.y-origin.y, -80 )):Normalized()

	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )

	-- Projectile
	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin =  {unit=caster, attach="attach_attack1", offset=Vector(0,0,0)},
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
				true -- bool bNeverMiss
			)

			-- Reduce the cd of the special attack by 1
			local special_attack = caster:FindAbilityByName("tinker_special_attack_lua")
			local special_attack_cd = special_attack:GetCooldownTimeRemaining()
			local new_cd = special_attack_cd - 1.0

			if (new_cd) < 0 then 
				special_attack:EndCooldown()
			else
				special_attack:EndCooldown()
				special_attack:StartCooldown(new_cd)
			end

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

--------------------------------------------------------------------------------
-- Graphics & sounds
function tinker_basic_attack:PlayEffects_a()
	-- Create Sound
	local sound_cast = "Hero_Tinker.Attack"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function tinker_basic_attack:PlayEffects_b( pos )
	local caster = self:GetCaster()
	
	-- Create Sound
	local sound_cast = "Hero_Tinker.ProjectileImpact"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Cast Particle
	local particle_cast = "particles/mod_units/heroes/hero_tinker/tinker_base_attack_impact_burst.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
end

function tinker_basic_attack:Animate(point)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local angles = caster:GetAngles()

	local direction = (point - origin)
	local directionAsAngle = VectorToAngles(direction)
	caster:SetAngles(angles.x, directionAsAngle.y, angles.z)
	StartAnimation(caster, {duration=1.0, activity=ACT_DOTA_ATTACK, rate=1.5})
end

--------------------------------------------------------------------------------
-- Misc
-- Add mana on attack modifier. Only first time upgraded
function tinker_basic_attack:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	end
end