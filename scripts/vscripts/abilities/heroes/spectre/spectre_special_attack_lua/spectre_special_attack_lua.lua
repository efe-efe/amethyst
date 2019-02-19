spectre_special_attack_lua = class({})

LinkLuaModifier( "modifier_spectre_special_attack_debuff_lua", "abilities/heroes/spectre/spectre_special_attack_lua/modifier_spectre_special_attack_debuff_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_special_attack_thinker_lua", "abilities/heroes/spectre/spectre_special_attack_lua/modifier_spectre_special_attack_thinker_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function spectre_special_attack_lua:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	
	-- load data (projectile)
	local projectile_name = "particles/mod_units/heroes/hero_spectre/spectre_ti7_crimson_spectral_dagger.vpcf"
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_vision = 500
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	self.damage = self:GetSpecialValueFor("damage")
	self.mana_gain = self:GetSpecialValueFor("mana_gain")
	self.debuff_duration = self:GetSpecialValueFor("debuff_duration")
	
	-- load data (path)
	local path_duration = self:GetSpecialValueFor("path_duration")

	-- logic

	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = Vector(origin.x, origin.y, origin.z + 128),
		
		bDeleteOnHit = false,
		
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
		
		bProvidesVision = true,
		iVisionRadius = projectile_vision,
        iVisionTeamNumber = caster:GetTeamNumber(),
        
        ExtraData = {
			
		}
	}
	
	ProjectileManager:CreateLinearProjectile(info)
	self:PlayEffects()

	local path = CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_spectre_special_attack_thinker_lua", -- modifier name
		{ 
			duration = path_duration
		}, -- kv
		origin,
		caster:GetTeamNumber(),
		false --bPhantomBlocker
	)
end

--------------------------------------------------------------------------------
-- Projectile
function spectre_special_attack_lua:OnProjectileHit( hTarget, vLocation )
	if hTarget ~= nil and ( not hTarget:IsInvulnerable() ) and ( not hTarget:TriggerSpellAbsorb( self ) ) then
		local caster =  self:GetCaster()
		
		local damage = {
			victim = hTarget,
			attacker = caster,
			damage = self.damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
		}

		ApplyDamage( damage )
		
		hTarget:AddNewModifier(
			caster,
			self,
			"modifier_spectre_special_attack_debuff_lua",
			{ duration = self.debuff_duration }
		)

		-- Give Mana
		local mana_gain_final = caster:GetMaxMana() * self.mana_gain
		caster:GiveMana(mana_gain_final)
		
		-- Effects
		self:PlayEffects2(hTarget)
	end
end

function spectre_special_attack_lua:PlayEffects()
	-- Get Resources
	--local particle_cast = "particles/units/heroes/hero_weaver/weaver_shukuchi_damage.vpcf"
	local sound_cast = "Hero_Spectre.DaggerCast"

	-- Get Data

	-- Create Particle
	--local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	--ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function spectre_special_attack_lua:PlayEffects2(hTarget)
	-- Get Resources
	local sound_cast = "Hero_Spectre.DaggerImpact"
	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )

	-- Create Particles
end

