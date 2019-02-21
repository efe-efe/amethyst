spectre_ex_second_attack_lua = class({})
LinkLuaModifier( "modifier_spectre_ex_second_attack_lua", "abilities/heroes/spectre/spectre_ex_second_attack_lua/modifier_spectre_ex_second_attack_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_desolate_lua", "abilities/heroes/spectre/spectre_shared_modifiers/modifier_spectre_desolate_lua/modifier_spectre_desolate_lua", LUA_MODIFIER_MOTION_NONE )

-- This function is used to change between abilities and ex abilities
--------------------------------------------------------------------------------
function spectre_ex_second_attack_lua:GetRelatedName()
    return "spectre_second_attack_lua"
end

--------------------------------------------------------------------------------
-- Ability Start
function spectre_ex_second_attack_lua:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	
	-- load data
	local projectile_name = "particles/mod_units/heroes/hero_bane/bane_projectile.vpcf"
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
    local projectile_vision = 0
	self.damage = self:GetSpecialValueFor("damage")
	self.debuff_duration = self:GetSpecialValueFor("debuff_duration")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	-- logic

	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = Vector(origin.x, origin.y, origin.z + 54),
		
		bDeleteOnHit = true,
		
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		
		EffectName = projectile_name,
		fDistance = projectile_distance,
		fStartRadius = projectile_start_radius,
		fEndRadius =projectile_end_radius,
		vVelocity = projectile_direction * projectile_speed,

		bHasFrontalCone = false,
		bReplaceExisting = false,
		fExpireTime = GameRules:GetGameTime() + 10.0,
		
		bProvidesVision = false,
		iVisionRadius = projectile_vision,
        iVisionTeamNumber = caster:GetTeamNumber(),
        
        ExtraData = {
			
		}
	}
	
	ProjectileManager:CreateLinearProjectile(info)
	self:PlayEffects()
end

--------------------------------------------------------------------------------
-- Projectile
function spectre_ex_second_attack_lua:OnProjectileHit( hTarget, vLocation )
	if hTarget ~= nil and ( not hTarget:IsInvulnerable() ) and ( not hTarget:TriggerSpellAbsorb( self ) ) then
		local caster =  self:GetCaster()
		
		local damage = {
			victim = hTarget,
			attacker = caster,
			damage = self.damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
		}

		ApplyDamage( damage )

        --Blind
        hTarget:AddNewModifier(
			caster, 
			self, 
			"modifier_spectre_ex_second_attack_lua", 
			{ duration = self.debuff_duration }
		)

        --Desolate
        hTarget:AddNewModifier(
			caster, 
			self, 
			"modifier_spectre_desolate_lua", 
			{ }
		)
		
		-- Effects
		self:PlayEffects2(hTarget)
	end

	return true
end

--Impact
function spectre_ex_second_attack_lua:PlayEffects2(hTarget)
	-- Get Resources
    local sound_cast = "Hero_Nevermore.RequiemOfSouls.Damage"
	local particle_cast = "particles/units/heroes/hero_spectre/spectre_ambient_endcap.vpcf"

	-- Create Sound
	EmitSoundOn( sound_cast, hTarget )

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

--cast
function spectre_ex_second_attack_lua:PlayEffects()
	-- Get Resources
	local sound_cast = "Hero_Nevermore.Raze_Flames"
	local particle_cast = "particles/units/heroes/hero_spectre/spectre_death_mist.vpcf"

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOn( sound_cast, self:GetCaster() )
end




