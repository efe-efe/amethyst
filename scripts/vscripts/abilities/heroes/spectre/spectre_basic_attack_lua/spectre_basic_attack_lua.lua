spectre_basic_attack_lua = class ({})
LinkLuaModifier( "modifier_spectre_basic_attack_lua", "abilities/heroes/spectre/spectre_basic_attack_lua/modifier_spectre_basic_attack_lua", LUA_MODIFIER_MOTION_NONE )

function spectre_basic_attack_lua:GetAOERadius()
	return self:GetSpecialValueFor( "hitbox" )
end

--------------------------------------------------------------------------------
-- Ability Start
function spectre_basic_attack_lua:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	local ability = self
	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )

	-- load data
    local projectile_name = "particles/mod_units/heroes/hero_skywrath_mage/skywrath_mage_base_attack.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local heal_amount = self:GetSpecialValueFor("heal_amount")

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
		draw = true,
		fRehitDelay = 1.0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= caster:GetTeamNumber() end,
		OnUnitHit = function(_self, unit) 

			-- Blocked
			--------------------
			local is_slower = unit:FindModifierByName("modifier_generic_projectile_blocker_lua")
			if is_slower ~= nil then
				if not is_slower:IsNull() then
					_self.Destroy()
					return
				end
			end

			-- Hit
			--------------------

			local desolate = unit:FindModifierByNameAndCaster( "modifier_spectre_desolate_lua", caster )
			local modifier_attack_bonus = nil
		
			-- If have the debuff, adds extra attack and extends debuff duration
			if desolate ~= nil then
				modifier_attack_bonus = caster:AddNewModifier(caster, ability , "modifier_spectre_basic_attack_lua", {})
				caster:Heal( heal_amount, ability )
				self:PlayEffects_c()
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
				false -- bool bNeverMiss
			)
		
			--Remove the extra attack
			if modifier_attack_bonus ~= nil then
				if not modifier_attack_bonus:IsNull() then
					modifier_attack_bonus:Destroy()
				end
			end

			self:PlayEffects_b(_self:GetPosition())
			_self.Destroy()
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects_a(pos)
		end,
	}

	self:StartCooldown(attack_speed)

	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
end

--------------------------------------------------------------------------------
-- Projectile
function spectre_basic_attack_lua:OnProjectileHit_ExtraData( hTarget, vLocation, extraData )
    if hTarget==nil then 
	    self:PlayEffectsMiss()
        return 
	end
	
	-- Blocked
	local is_blocker = hTarget:FindModifierByName("modifier_generic_projectile_blocker_lua")
	if is_blocker ~= nil then
		if not is_blocker:IsNull() then
			return true
		end
	end
	
	-- load variables
	local caster = self:GetCaster()
	local desolate = hTarget:FindModifierByNameAndCaster( "modifier_spectre_desolate_lua", caster )
	local modifier_attack_bonus = nil

	-- If have the debuff, adds extra attack and extends debuff duration
	if desolate ~= nil then
		modifier_attack_bonus = caster:AddNewModifier(caster, self , "modifier_spectre_basic_attack_lua", {})
		caster:Heal( self.heal_amount, self )
		self:PlayEffects2()
	end

	-- perform the actual attack
	caster:PerformAttack(
		hTarget, -- handle hTarget 
		true, -- bool bUseCastAttackOrb, 
		true, -- bool bProcessProcs,
		true, -- bool bSkipCooldown
		false, -- bool bIgnoreInvis
		false, -- bool bUseProjectile
		false, -- bool bFakeAttack
		false -- bool bNeverMiss
	)

	self:PlayEffects(hTarget)	
	
	--Remove the extra attack
	if modifier_attack_bonus ~= nil then
		if not modifier_attack_bonus:IsNull() then
			modifier_attack_bonus:Destroy()
		end
	end

	return true
end

--------------------------------------------------------------------------------
-- Effects

-- On Miss
function spectre_basic_attack_lua:PlayEffects_a( pos )
	local caster = self:GetCaster()

	-- Create Sound
	local sound_cast = "Hero_Spectre.PreAttack"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )
	
	-- Create Particles
	local particle_cast = "particles/units/heroes/hero_spectre/spectre_desolate.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- On hit enemy
function spectre_basic_attack_lua:PlayEffects_b( pos )
	local caster = self:GetCaster()

	-- Create Sound
	local sound_cast = "Hero_Spectre.Attack"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Create Particles
	local particle_cast = "particles/units/heroes/hero_spectre/spectre_desolate.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, pos)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- On self when lifestealing
function spectre_basic_attack_lua:PlayEffects_c()
	-- Heal Particles
	local particle_cast = "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodbath_heal_eztzhok.vpcf"

    -- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end