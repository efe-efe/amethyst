spectre_basic_attack_charged_lua = class({})

LinkLuaModifier( "modifier_spectre_basic_attack_charged_lua", "abilities/heroes/spectre/spectre_basic_attack_lua/modifier_spectre_basic_attack_charged_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_basic_attack_charged_timer_lua", "abilities/heroes/spectre/spectre_basic_attack_lua/modifier_spectre_basic_attack_charged_timer_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_basic_attack_charged_visuals_lua", "abilities/heroes/spectre/spectre_basic_attack_lua/modifier_spectre_basic_attack_charged_visuals_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_desolate_lua", "abilities/heroes/spectre/spectre_shared_modifiers/modifier_spectre_desolate_lua/modifier_spectre_desolate_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_silenced_lua", "abilities/generic/modifier_generic_silenced_lua", LUA_MODIFIER_MOTION_NONE )

function spectre_basic_attack_charged_lua:GetAOERadius()
	return self:GetSpecialValueFor( "hitbox" )
end
--------------------------------------------------------------------------------
-- Ability Start
function spectre_basic_attack_charged_lua:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	self.point = self:GetCursorPosition()

	--Attack speed (To put on cooldown the non charged version)
	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )

	-- load data
	self.debuff_duration = self:GetSpecialValueFor("debuff_duration")
	self.heal_amount = self:GetSpecialValueFor("heal_amount")

	local projectile_name = ""
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox") + 10
	local projectile_vision = 0

	local projectile_direction = (Vector( self.point.x-origin.x, self.point.y-origin.y, 0 )):Normalized()

	--logic
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
			self.modifier_attack_bonus = caster:AddNewModifier(caster, self , "modifier_spectre_basic_attack_charged_lua", {})
		
			-- Hit
			--------------------
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

			self:PlayEffects_a(unit)
			_self.Source:Heal( self.heal_amount, self )

			unit:AddNewModifier(_self.Source, self , "modifier_generic_silenced_lua", { duration = self.debuff_duration})
			unit:AddNewModifier(_self.Source, self , "modifier_spectre_desolate_lua", {})

			--Remove the extra attack
			if self.modifier_attack_bonus ~= nil then
				if not self.modifier_attack_bonus:IsNull() then
					self.modifier_attack_bonus:Destroy()
				end
			end
			_self.Destroy()
		end,
		OnFinish = function(_self, pos)
			
			--Remove the extra attack
			if self.modifier_attack_bonus ~= nil then
				if not self.modifier_attack_bonus:IsNull() then
					self.modifier_attack_bonus:Destroy()
				end
			end
			self:PlayEffects_b()
			--self:PlayEffects_a(pos)
		end,
	}

    --Identify the non charged version, and puts it on cooldown
    local non_charged_version = caster:FindAbilityByName("spectre_basic_attack_lua")
    non_charged_version:StartCooldown(attack_speed)

    -- Put the non charged ability on the basic attack slot
	caster:SwapAbilities( 
		self:GetAbilityName(),
		"spectre_basic_attack_lua",
		false,
		true
	)
	
	-- find and destroy visual modifier
	local visual_effect = caster:FindModifierByNameAndCaster( 
		"modifier_spectre_basic_attack_charged_visuals_lua", caster 
	)
	if visual_effect~=nil then
		if not visual_effect:IsNull() then
			visual_effect:Destroy()
		end
	end

    --Adds the timer that swaps the abilities
	caster:AddNewModifier(caster, self , "modifier_spectre_basic_attack_charged_timer_lua", {duration = self:GetCooldown(0)})

	self:PlayEffectsOnCast()

	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
	self:Animate(self.point)
end

--------------------------------------------------------------------------------
-- Effects

-- Self glow on cast
-------------------------
function spectre_basic_attack_charged_lua:PlayEffectsOnCast()
    -- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- Hit attack effects
-------------------------
function spectre_basic_attack_charged_lua:PlayEffects_a(hTarget)
	local caster = self:GetCaster()
	-- Create Sound
	local sound_cast = "Hero_BountyHunter.Jinada"
	EmitSoundOn( sound_cast, caster )

	-- Load Particles
	local particle_cast_a = "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodbath_heal_eztzhok.vpcf"
	local particle_cast_b = "particles/econ/items/slark/slark_ti6_blade/slark_ti6_blade_essence_shift.vpcf"
	local particle_cast_c = "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_crimson_blade_fury_abyssal_start.vpcf"

    -- Create Particles
	local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_ABSORIGIN_FOLLOW, caster )
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_POINT, hTarget )
	local effect_cast_c = ParticleManager:CreateParticle( particle_cast_c, PATTACH_ABSORIGIN_FOLLOW, caster )
	
	-- Set control points
	ParticleManager:SetParticleControl( effect_cast_c, 2, caster:GetOrigin())

	-- Release Particles
	ParticleManager:ReleaseParticleIndex( effect_cast_a )
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
	ParticleManager:ReleaseParticleIndex( effect_cast_c )
end
	
--Miss attack effects
-------------------------
function spectre_basic_attack_charged_lua:PlayEffects_b()
	local caster = self:GetCaster()
	-- Create Sound
	local sound_cast = "Hero_Spectre.PreAttack"
	EmitSoundOn( sound_cast, caster )

	-- Create Particles
	local particle_cast = "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_crimson_blade_fury_abyssal_start.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControl( effect_cast, 2, caster:GetOrigin())
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- Add mana on attack modifier and visuals. Only first time upgraded
function spectre_basic_attack_charged_lua:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		
		--Visuals
		caster:AddNewModifier( caster, self, "modifier_spectre_basic_attack_charged_visuals_lua", {} )
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	end
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