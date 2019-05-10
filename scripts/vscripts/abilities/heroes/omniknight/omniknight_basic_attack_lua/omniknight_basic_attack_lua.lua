omniknight_basic_attack_lua = class({})

function omniknight_basic_attack_lua:GetAOERadius()
	return self:GetSpecialValueFor( "hitbox" )
end

--------------------------------------------------------------------------------
-- Ability Start
function omniknight_basic_attack_lua:OnSpellStart()
    --Initialize variables
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	self.point = self:GetCursorPosition()

	--Attack speed (To put on cooldown the non charged version)
	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )

	-- load data
	self.debuff_duration = self:GetSpecialValueFor("debuff_duration")
	self.heal_amount = self:GetSpecialValueFor("heal_amount")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox") + 10
	local projectile_vision = 0
    local projectile_name = ""

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
end


--------------------------------------------------------------------------------
-- Projectile
function omniknight_basic_attack_lua:OnProjectileHit_ExtraData( hTarget, vLocation, extraData )
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
    
    self:PlayEffects(hTarget)

    return true
end


-- Hit attack effects
-------------------------
function omniknight_basic_attack_lua:PlayEffects(hTarget)
	-- Create Sound
	local sound_cast = "Hero_Omniknight.Attack"
    EmitSoundOn( sound_cast, hTarget )
    
    -- Load Particles
	local particle_cast = "particles/base_attacks/test_projectile_explosion.vpcf"
    
     -- Create Particles
	local effect_cast = ParticleManager:CreateParticle( 
        particle_cast, 
        PATTACH_ABSORIGIN_FOLLOW, 
        self:GetCaster() 
    )

    ParticleManager:SetParticleControl( effect_cast, 3, Vector(hTarget:GetOrigin().x, hTarget:GetOrigin().y, hTarget:GetOrigin().z + 10) )
	-- Release Particles
	ParticleManager:ReleaseParticleIndex( effect_cast )
end