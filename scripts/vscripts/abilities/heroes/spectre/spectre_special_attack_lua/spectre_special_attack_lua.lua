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
	local projectile_name = "particles/econ/items/spectre/spectre_transversant_soul/spectre_ti7_crimson_spectral_dagger.vpcf"
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
	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = {unit=caster, attach="attach_attack1", offset=Vector(0,0,0)},
		ControlPoints = {[5]=Vector(path_duration,0,0)},
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
		WallBehavior = PROJECTILES_NOTHING,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		nChangeMax = 1,
		bRecreateOnChange = true,
		bZCheck = false,
		bGroundLock = true,
		bProvidesVision = true,
		bIsSlowable = false,
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
			local caster =  self:GetCaster()
		
			local damage = {
				victim = unit,
				attacker = caster,
				damage = self.damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}

			ApplyDamage( damage )
			
			unit:AddNewModifier(
				caster,
				self,
				"modifier_spectre_special_attack_debuff_lua",
				{ duration = self.debuff_duration }
			)

			-- Give Mana
			local mana_gain_final = caster:GetMaxMana() * self.mana_gain
			caster:GiveMana(mana_gain_final)

			-- Effects
			self:PlayEffects_b(_self:GetPosition())
			_self.Destroy()
		end,
		OnFinish = function(_self, pos)
			--self:PlayEffects_b(pos)
		end,
	}

--[[
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

]]

	self:PlayEffects_a()

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
	
	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
end

--Cant be blocked!
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
		self:PlayEffects_b(hTarget)
	end
end

function spectre_special_attack_lua:PlayEffects_a()
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

function spectre_special_attack_lua:PlayEffects_b(hTarget)
	-- Get Resources
	local sound_cast = "Hero_Spectre.DaggerImpact"
	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )

	-- Create Particles
end

