nevermore_basic_attack = class({})
LinkLuaModifier( "modifier_generic_pseudo_cast_point_lua", "abilities/generic/modifier_generic_pseudo_cast_point_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nevermore_basic_attack", "abilities/heroes/nevermore/nevermore_basic_attack/modifier_nevermore_basic_attack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
--Passive Modifier
function nevermore_basic_attack:GetIntrinsicModifierName()
	return "modifier_nevermore_basic_attack"
end

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_basic_attack:OnSpellStart()
	-- Initialize bariables
	local caster = self:GetCaster()
	local cast_point = caster:GetAttackAnimationPoint()
	self.point = self:GetCursorPosition()

    EmitSoundOn("Hero_Nevermore.PreAttack", caster)

	-- Animation and pseudo cast point
	self:Animate()
	self:Rotate(self.point)
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point_lua", { duration = cast_point })
end

function nevermore_basic_attack:OnEndPseudoCastPoint()
	local caster = self:GetCaster()

	-- Get Stack
	local modifier = caster:FindModifierByNameAndCaster("modifier_nevermore_ex_special_attack", caster)
	local stacks = 0
	if modifier~=nil then
		stacks = modifier:GetStackCount()
	end
	-- Projectile data
	local projectile_name = "particles/mod_units/heroes/hero_nevermore/nevermore_base_attack.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	if stacks > 0 then
		projectile_name = "particles/mod_units/heroes/hero_nevermore/sf_base_attack_desolation_desolator.vpcf"
	end

	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )

	-- Dynamic data
	local origin = caster:GetOrigin()
	local projectile_direction = (Vector( self.point.x-origin.x, self.point.y-origin.y, 0 )):Normalized()

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
		bMultipleHits = false,
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
			-- Count targets
			local counter = 0
			for k, v in pairs(_self.rehit) do
				counter = counter + 1
			end

			if counter > 0 then return end

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

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Projectile starts
function nevermore_basic_attack:PlayEffects_a()
	-- Create Sound
	local sound_cast = "Hero_Nevermore.Attack"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

-- On Projectile impacts
function nevermore_basic_attack:PlayEffects_b( pos )
	local caster = self:GetCaster()

	-- Create Sound
	local sound_cast = "Hero_Nevermore.ProjectileImpact"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Cast Particle
	local particle_cast = "particles/mod_units/heroes/hero_nevermore/nevermore_base_attack_impact.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 1, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

--------------------------------------------------------------------------------
-- On First Upgrade Effects
function nevermore_basic_attack:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	end
end

function nevermore_basic_attack:Animate()
	StartAnimation(self:GetCaster(), {duration=1.5, activity=ACT_DOTA_ATTACK, rate=1.5})
end

function nevermore_basic_attack:Rotate(point)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local angles = caster:GetAngles()

	local direction = (point - origin)
	local directionAsAngle = VectorToAngles(direction)
	caster:SetAngles(angles.x, directionAsAngle.y, angles.z)
end
