spectre_basic_attack_lua = class ({})
LinkLuaModifier( "modifier_spectre_basic_attack_lua", "abilities/heroes/spectre/spectre_basic_attack_lua/modifier_spectre_basic_attack_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_pseudo_cast_point_lua", "abilities/generic/modifier_generic_pseudo_cast_point_lua", LUA_MODIFIER_MOTION_NONE )

function spectre_basic_attack_lua:GetAOERadius()
	return self:GetSpecialValueFor( "hitbox" )
end

--------------------------------------------------------------------------------
-- Ability Start
function spectre_basic_attack_lua:OnSpellStart()

	-- Initialize variables
	local caster = self:GetCaster()
	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )
	self.point = self:GetCursorPosition()

	-- Animation and pseudo cast point
	self:SetActivated(false)
	self:Animate(self.point)
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point_lua", { duration = attack_speed })
end

function spectre_basic_attack_lua:OnEndPseudoCastPoint()
	local caster = self:GetCaster()
	local offset = 10

	-- Projectile data
	local projectile_name = ""
	local projectile_start_radius = 50
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = 2000

	-- Extra data
	local heal_amount = self:GetSpecialValueFor("heal_amount")
	
	self:SetActivated(true)

	-- Dinamyc data
	local origin = caster:GetOrigin()
	local direction_normalized = (self.point - origin):Normalized()
	local initial_position = origin + Vector(direction_normalized.x * offset, direction_normalized.y * offset, 0)
	local projectile_direction = (Vector( self.point.x-origin.x, self.point.y-origin.y, 0 )):Normalized()

	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = initial_position + Vector(0,0,80),
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
		fGroundOffset = 0,
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

			local desolate = unit:FindModifierByNameAndCaster( "modifier_spectre_desolate_lua", caster )
		
			-- If have the debuff, adds extra attack and extends debuff duration
			if desolate ~= nil then
				caster:AddNewModifier(caster, self , "modifier_spectre_basic_attack_lua", {})
				caster:Heal( heal_amount, _self.Source )
				self:PlayEffects_d()
			end
		
			-- perform the actual attack
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
			SafeDestroyModifier("modifier_spectre_basic_attack_lua", caster, caster)

			self:PlayEffects_b(unit)
			_self.Destroy()
		end,
		OnFinish = function(_self, pos)
			if next(_self.rehit) == nil then
				self:PlayEffects_c(pos)
			end
			self:PlayEffects_a(pos)
			--Remove the extra attack
			SafeDestroyModifier("modifier_spectre_basic_attack_lua", caster, caster)
		end,
	}
	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
end

function spectre_basic_attack_lua:OnStopPseudoCastPoint()
	self:SetActivated(true)
end


--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Projectile finish
function spectre_basic_attack_lua:PlayEffects_a( pos )
	local caster = self:GetCaster()
	-- Create Particles
	local particle_cast = "particles/units/heroes/hero_spectre/spectre_desolate.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos)
	ParticleManager:SetParticleControlForward( effect_cast, 0, (caster:GetOrigin()-pos):Normalized() * -1 )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- On hit enemy
function spectre_basic_attack_lua:PlayEffects_b( hTarget )
	-- Create Sound
	local sound_cast = "Hero_Spectre.Attack"
	EmitSoundOn( sound_cast, hTarget )
end

-- On Projectile miss
function spectre_basic_attack_lua:PlayEffects_c( pos )
	-- Create Sound
	local sound_cast = "Hero_Spectre.PreAttack"
	EmitSoundOnLocationWithCaster( pos, sound_cast, self:GetCaster() )
end

-- On self when lifestealing
function spectre_basic_attack_lua:PlayEffects_d()
	-- Heal Particles
	local particle_cast = "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodbath_heal_eztzhok.vpcf"

    -- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function spectre_basic_attack_lua:Animate(point)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local angles = caster:GetAngles()

	local direction = (point - origin)
	local directionAsAngle = VectorToAngles(direction)
	caster:SetAngles(angles.x, directionAsAngle.y, angles.z)
	StartAnimation(caster, {duration=1.0, activity=ACT_DOTA_ATTACK, rate=1.5})
end