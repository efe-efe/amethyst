spectre_basic_attack_test_lua = class ({})

--------------------------------------------------------------------------------
-- Ability Start
function spectre_basic_attack_test_lua:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	self.point = self:GetCursorPosition()
	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )

	-- load data
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox") + 10
	local projectile_vision = 0
    local projectile_name = "particles/mod_units/heroes/hero_dark_willow/dark_willow_base_attack.vpcf"

	local projectile_direction = (Vector( self.point.x-origin.x, self.point.y-origin.y, 0 )):Normalized()

	-- logic

	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = origin,
		
		bDeleteOnHit = true,
		
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		
		EffectName = projectile_name,
		fDistance = projectile_distance,
		fStartRadius = projectile_start_radius,
		fEndRadius =projectile_end_radius,
		vVelocity = projectile_direction * projectile_speed,

		bHasFrontalCone = true,
		bReplaceExisting = false,
		fExpireTime = GameRules:GetGameTime() + 10.0,
		
		bProvidesVision = false,
		iVisionRadius = projectile_vision,
        iVisionTeamNumber = caster:GetTeamNumber(),
        
        ExtraData = {
			
		}
	}
	
    ProjectileManager:CreateLinearProjectile(info)
	self:StartCooldown(attack_speed)
end

--------------------------------------------------------------------------------
-- Projectile
function spectre_basic_attack_test_lua:OnProjectileHit_ExtraData( hTarget, vLocation, extraData )
    if hTarget==nil then 
	    self:PlayEffectsMiss(vLocation)
        return 
	end
	
	-- load variables
	local caster = self:GetCaster()

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

	self:PlayEffects(hTarget, vLocation)	

    return true
end

--------------------------------------------------------------------------------
-- Effects
function spectre_basic_attack_test_lua:PlayEffects(hTarget, vLocation)
	-- Get Resources
	local sound_cast = "Hero_Spectre.Attack"
	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )

	-- Create Particles
	local particle_cast = "particles/units/heroes/hero_spectre/spectre_desolate.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, vLocation)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function spectre_basic_attack_test_lua:PlayEffectsMiss(vLocation)
	-- Get Resources
	local sound_cast = "Hero_Spectre.PreAttack"

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
	
	-- Create Particles
	local particle_cast = "particles/units/heroes/hero_spectre/spectre_desolate.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, vLocation)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function spectre_basic_attack_test_lua:PlayEffects2()
	-- Heal Particles
	local particle_cast = "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodbath_heal_eztzhok.vpcf"

    -- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end