spectre_ex_second_attack_lua = class({})
LinkLuaModifier( "modifier_spectre_ex_second_attack_lua", "abilities/heroes/spectre/spectre_ex_second_attack_lua/modifier_spectre_ex_second_attack_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_desolate_lua", "abilities/heroes/spectre/spectre_shared_modifiers/modifier_spectre_desolate_lua/modifier_spectre_desolate_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function spectre_ex_second_attack_lua:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	
	-- load data
	local projectile_name = "particles/mod_units/heroes/hero_dark_willow/dark_willow_base_attack.vpcf"
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
    local projectile_vision = 0
	self.damage = self:GetSpecialValueFor("damage")
	self.debuff_duration = self:GetSpecialValueFor("debuff_duration")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	-- logic
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
			-- Hit
			--------------------
			local damage = {
				victim = unit,
				attacker = _self.Source,
				damage = self.damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}

			ApplyDamage( damage )

			--Blind
			unit:AddNewModifier(
				_self.Source, 
				self, 
				"modifier_spectre_ex_second_attack_lua", 
				{ duration = self.debuff_duration }
			)

			--Desolate
			unit:AddNewModifier(
				_self.Source, 
				self, 
				"modifier_spectre_desolate_lua", 
				{ duration = self.debuff_duration }
			)
			
			-- Effects
			self:PlayEffects(unit)

			_self.Destroy()
		end,
		OnFinish = function(_self, pos)
			--self:PlayEffects(pos)
		end,
	}

	-- Put CD on the alternate version of the ability
	local alternate_version = caster:FindAbilityByName("spectre_second_attack_lua")
	alternate_version:StartCooldown(self:GetCooldown(0))

	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
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
		self:PlayEffects(hTarget)
	end

	return true
end

--Impact
function spectre_ex_second_attack_lua:PlayEffects(hTarget)
	-- Get Resources
    local sound_cast = "Hero_Nevermore.RequiemOfSouls.Damage"
	local particle_cast = "particles/units/heroes/hero_spectre/spectre_ambient_endcap.vpcf"

	-- Create Sound
	EmitSoundOn( sound_cast, hTarget )

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end




