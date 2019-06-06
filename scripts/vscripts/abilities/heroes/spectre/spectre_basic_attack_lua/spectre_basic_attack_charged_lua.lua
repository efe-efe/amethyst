spectre_basic_attack_charged_lua = class({})

LinkLuaModifier( "modifier_spectre_basic_attack_charged_lua", "abilities/heroes/spectre/spectre_basic_attack_lua/modifier_spectre_basic_attack_charged_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_basic_attack_charged_timer_lua", "abilities/heroes/spectre/spectre_basic_attack_lua/modifier_spectre_basic_attack_charged_timer_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_desolate_lua", "abilities/heroes/spectre/spectre_shared_modifiers/modifier_spectre_desolate_lua/modifier_spectre_desolate_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_silenced_lua", "abilities/generic/modifier_generic_silenced_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_pseudo_cast_point_lua", "abilities/generic/modifier_generic_pseudo_cast_point_lua", LUA_MODIFIER_MOTION_NONE )

function spectre_basic_attack_charged_lua:GetAOERadius()
	return self:GetSpecialValueFor( "hitbox" )
end

--------------------------------------------------------------------------------
-- Ability Start
function spectre_basic_attack_charged_lua:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	local point = self:GetCursorPosition()
	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )
	local offset = 10

	-- Projectile data
	local projectile_name = ""
	local projectile_start_radius = 50
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = 2000

	-- Extra data
	local desolate_duration = self:GetSpecialValueFor("desolate_duration")
	local silence_duration = self:GetSpecialValueFor("silence_duration")
	local heal_amount = self:GetSpecialValueFor("heal_amount")

	-- Animation and pseudo cast point
	self:Animate(point)
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point_lua", { duration = cast_point})

	Timers:CreateTimer(cast_point, function()
		-- Dinamyc data
        local origin = caster:GetOrigin()
		local direction_normalized = (point - origin):Normalized()
		local initial_position = origin + Vector(direction_normalized.x * offset, direction_normalized.y * offset, 0)
		local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

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
				--Adds the damage bonus modifier
				caster:AddNewModifier(caster, self , "modifier_spectre_basic_attack_charged_lua", {})
			
				-- perform the actual attack
				_self.Source:PerformAttack(
					unit, -- handle hTarget 
					true, -- bool bUseCastAttackOrb, 
					true, -- bool bProcessProcs,
					true, -- bool bSkipCooldown
					false, -- bool bIgnoreInvis
					false, -- bool bUseProjectile
					false, -- bool bFakeAttack
					false -- bool bNeverMiss
				)
				
				_self.Source:Heal( heal_amount, self )

				unit:AddNewModifier(_self.Source, self , "modifier_generic_silenced_lua", { duration = silence_duration})
				unit:AddNewModifier(_self.Source, self , "modifier_spectre_desolate_lua", {duration = desolate_duration})
				SafeDestroyModifier("modifier_spectre_basic_attack_charged_lua", caster, caster)

				self:PlayEffects_b(unit)
				_self.Destroy()
			end,
			OnFinish = function(_self, pos)
				if next(_self.rehit) == nil then
					self:PlayEffects_c(pos)
				end
				SafeDestroyModifier("modifier_spectre_basic_attack_charged_lua", caster, caster)
				self:PlayEffects_a(pos)
			end,
		}
		self:StopEffects_d()
		
		--Identify the alternate version, and puts it on cooldown
		local alternate_version = caster:FindAbilityByName("spectre_basic_attack_lua")
		alternate_version:StartCooldown(attack_speed)

		--Adds the timer that swaps the abilities
		caster:AddNewModifier(caster, self , "modifier_spectre_basic_attack_charged_timer_lua", {duration = self:GetCooldown(0)})
		-- Cast projectile
		Projectiles:CreateProjectile(projectile)
	end)
end

--------------------------------------------------------------------------------
-- Misc

-- Add mana on attack modifier and visuals. Only first time upgraded
function spectre_basic_attack_charged_lua:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
		-- Visuals
		self:PlayEffects_d()
	end
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Projectile Finish
function spectre_basic_attack_charged_lua:PlayEffects_a()
	local caster = self:GetCaster()
	-- Create Particles
	local particle_cast = "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_crimson_blade_fury_abyssal_start.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControl( effect_cast, 2, caster:GetOrigin())
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- On Projectile hit enemy
-------------------------
function spectre_basic_attack_charged_lua:PlayEffects_b(hTarget)
	-- Create Sound
	local sound_cast = "Hero_BountyHunter.Jinada"
	EmitSoundOn( sound_cast, hTarget )
   
	-- Create Particles
	local particle_cast_a = "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodbath_heal_eztzhok.vpcf"
	local particle_cast_b = "particles/econ/items/slark/slark_ti6_blade/slark_ti6_blade_essence_shift.vpcf"

	local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_POINT, hTarget )
	
	ParticleManager:ReleaseParticleIndex( effect_cast_a )
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
end
	
-- On Projectile Miss
-------------------------
function spectre_basic_attack_charged_lua:PlayEffects_c(pos)
	-- Create Sound
	local sound_cast = "Hero_Spectre.PreAttack"
	EmitSoundOnLocationWithCaster( pos, sound_cast, self:GetCaster() )
end


--------------------------------------------------------------------------------
-- Visuals
function spectre_basic_attack_charged_lua:PlayEffects_d()
	-- Get Resources

	local caster = self:GetCaster()

	local particle_cast = "particles/units/heroes/hero_nevermore/nevermore_base_attack_c.vpcf"
	local origin = caster:GetOrigin()
	self.effect_cast = ParticleManager:CreateParticle( 
		particle_cast, 
		PATTACH_CUSTOMORIGIN, 
		caster
	)

	ParticleManager:SetParticleControlEnt( 
		self.effect_cast, 
		0, 
		caster, 
		PATTACH_POINT_FOLLOW, 
		"attach_attack1", 
		origin, 
		true 
	)
	ParticleManager:SetParticleControlEnt( 
		self.effect_cast, 
		3, 
		caster, 
		PATTACH_POINT_FOLLOW, 
		"attach_attack1", 
		origin, 
		true 
	)
end

function spectre_basic_attack_charged_lua:StopEffects_d()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end


function spectre_basic_attack_charged_lua:Animate(point)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local angles = caster:GetAngles()

	local direction = (point - origin)
	local directionAsAngle = VectorToAngles(direction)
	caster:SetAngles(angles.x, directionAsAngle.y, angles.z)
	StartAnimation(caster, {duration=1.5, activity=ACT_DOTA_ATTACK, rate=2.5})
end

