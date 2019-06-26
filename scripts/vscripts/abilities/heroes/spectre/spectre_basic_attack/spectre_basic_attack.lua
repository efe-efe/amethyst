spectre_basic_attack = class({})
LinkLuaModifier( "modifier_spectre_desolate_lua", "abilities/heroes/spectre/spectre_shared_modifiers/modifier_spectre_desolate_lua/modifier_spectre_desolate_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_silenced_lua", "abilities/generic/modifier_generic_silenced_lua", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier( "modifier_spectre_basic_attack", "abilities/heroes/spectre/spectre_basic_attack/modifier_spectre_basic_attack", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_pseudo_cast_point_lua", "abilities/generic/modifier_generic_pseudo_cast_point_lua", LUA_MODIFIER_MOTION_NONE )
--------------------------------------------------------------------------------
--Passive Modifier
function spectre_basic_attack:GetIntrinsicModifierName()
	return "modifier_spectre_basic_attack"
end

function spectre_basic_attack:GetAOERadius()
	return self:GetSpecialValueFor( "hitbox" )
end

--------------------------------------------------------------------------------
-- Ability Start
function spectre_basic_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = caster:GetAttackAnimationPoint()
	self.silence_duration = self:GetSpecialValueFor("silence_duration")
	self.desolate_duration = self:GetSpecialValueFor("desolate_duration")
    self.heal_charged = self:GetSpecialValueFor("heal_charged")
	
	self.point = self:GetCursorPosition()

	-- Animation and pseudo cast point
	self:Animate(self.point)
	caster:AddNewModifier(
		caster, 
		self, 
		"modifier_generic_pseudo_cast_point_lua",
		{ duration = cast_point }
	)
end

function spectre_basic_attack:OnEndPseudoCastPoint()
	local caster = self:GetCaster()
	local offset = 10

	-- Projectile data
	local projectile_name = ""
	local projectile_start_radius = 50
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = 130
	local projectile_speed = 2000

	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )
	
	local modifier = caster:FindModifierByName("modifier_spectre_basic_attack")
	local stacks = modifier:GetStackCount() 

	-- Extra data
	local desolate_duration = self:GetSpecialValueFor("desolate_duration")
	local silence_duration = self:GetSpecialValueFor("silence_duration")
	local heal_amount = self:GetSpecialValueFor("heal_amount")

	-- Dinamyc data
	local origin = caster:GetOrigin()
	local direction_normalized = (self.point - origin):Normalized()
	local initial_position = origin + Vector(direction_normalized.x * offset, direction_normalized.y * offset, 0)
	local projectile_direction = (Vector( self.point.x-origin.x, self.point.y-origin.y, 0 )):Normalized()

	--logic
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

			if counter > 0 and stacks <= 0 then return end
			
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
				unit:AddNewModifier(_self.Source, self , "modifier_generic_silenced_lua", { duration = self.silence_duration })
				unit:AddNewModifier(_self.Source, self , "modifier_spectre_desolate_lua", { duration = self.desolate_duration })
				_self.Source:Heal( self.heal_charged, _self.Source )

				self:PlayEffects_b(unit)
			else
				self:PlayEffects_e(unit)
			end
		end,
		OnFinish = function(_self, pos)
			if next(_self.rehit) == nil then
				self:PlayEffects_c(pos)
			end
			if stacks > 0 then
				self:PlayEffects_a(pos)
			else
				self:PlayEffects_d(pos)
			end
		end,
	}
	
	modifier:DecrementStackCount()
	modifier:CalculateCharge()
	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
	self:StartCooldown(attack_speed)
end


--------------------------------------------------------------------------------
-- Misc

-- Add mana on attack modifier and visuals. Only first time upgraded
function spectre_basic_attack:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	end
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Projectile Finish
function spectre_basic_attack:PlayEffects_a()
	local caster = self:GetCaster()
	-- Create Particles
	local particle_cast = "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_crimson_blade_fury_abyssal_start.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControl( effect_cast, 2, caster:GetOrigin())
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- On Projectile hit enemy
-------------------------
function spectre_basic_attack:PlayEffects_b( hTarget )
	-- Create Sound
	local sound_cast = "Hero_BountyHunter.Jinada"
	EmitSoundOn( sound_cast, hTarget )
   
	-- Create Particles
	local particle_cast_a = "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodbath_heal_eztzhok.vpcf"
	local particle_cast_b = "particles/econ/items/slark/slark_ti6_blade/slark_ti6_blade_essence_shift.vpcf"

	--local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_POINT, hTarget )
	
	--ParticleManager:ReleaseParticleIndex( effect_cast_a )
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
end
	
-- On Projectile Miss
-------------------------
function spectre_basic_attack:PlayEffects_c(pos)
	-- Create Sound
	local sound_cast = "Hero_Spectre.PreAttack"
	EmitSoundOnLocationWithCaster( pos, sound_cast, self:GetCaster() )
end

-- On Projectile finish (NON CHARGED)
function spectre_basic_attack:PlayEffects_d( pos )
	local caster = self:GetCaster()
	-- Create Particles
	local particle_cast = "particles/units/heroes/hero_spectre/spectre_desolate.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos)
	ParticleManager:SetParticleControlForward( effect_cast, 0, (caster:GetOrigin()-pos):Normalized() * -1 )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end


-- On Projectile hit enemy (NON CHARGED)
function spectre_basic_attack:PlayEffects_e( hTarget )
	-- Create Sound
	local sound_cast = "Hero_Spectre.Attack"
	EmitSoundOn( sound_cast, hTarget )
end

function spectre_basic_attack:Animate(point)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local angles = caster:GetAngles()

	local direction = (point - origin)
	local directionAsAngle = VectorToAngles(direction)
	caster:SetAngles(angles.x, directionAsAngle.y, angles.z)

	StartAnimation(caster, {duration=1.0, activity=ACT_DOTA_ATTACK, rate=1.0})
end

