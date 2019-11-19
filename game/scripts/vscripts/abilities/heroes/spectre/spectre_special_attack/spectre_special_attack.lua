spectre_special_attack = class({})
LinkLuaModifier( "modifier_spectre_special_attack_debuff", "abilities/heroes/spectre/spectre_special_attack/modifier_spectre_special_attack_debuff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_special_attack_thinker", "abilities/heroes/spectre/spectre_special_attack/modifier_spectre_special_attack_thinker", LUA_MODIFIER_MOTION_NONE )

function spectre_special_attack:OnCastPointEnd( )
	local caster = self:GetCaster()
	local damage = self:GetSpecialValueFor("ability_damage")
	local origin = caster:GetOrigin()
	local point = CalcRange(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)

	-- Projectile data
	local projectile_name = "particles/mod_units/heroes/hero_spectre/spectre_ti7_crimson_spectral_dagger.vpcf" 
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local hitbox = self:GetSpecialValueFor("hitbox")

	-- Extra data
	local path_duration = self:GetSpecialValueFor("path_duration")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local debuff_duration = self:GetSpecialValueFor("debuff_duration")

	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	local projectile = {
		vSpawnOrigin = origin,
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius = hitbox,
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_NOTHING,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
		bGroundLock = true,
		bIsSlowable = false,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit)
			local damage = {
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}

			ApplyDamage( damage )
			
			unit:AddNewModifier(
				caster,
				self,
				"modifier_spectre_special_attack_debuff",
				{ duration = debuff_duration }
			)

			-- Give Mana
			if _self.Source == caster then
				caster:GiveManaPercent(mana_gain_pct, unit)
			end

			self:PlayEffectsOnImpact(unit)
		end,
		OnFinish = function(_self, pos)
		end,
		OnThinkBegin = function(_self)
			CreateModifierThinker(
				caster, -- player source
				self, -- ability source
				"modifier_spectre_special_attack_thinker", -- modifier name
				{ 
					duration = path_duration,
					x = _self.currentPosition.x,
					y = _self.currentPosition.y,
					z = _self.currentPosition.z,
					draw = 1,
				 }, -- kv
				 _self.currentPosition,
				caster:GetTeamNumber(),
				false --bPhantomBlocker
			)
		end
	}

	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_spectre_special_attack_thinker", -- modifier name
		{ 
			duration = path_duration,
			x = point.x,
			y = point.y,
			z = point.z,
		 }, -- kv
		origin,
		caster:GetTeamNumber(),
		false --bPhantomBlocker
	)

	--THIS IS ONLY FOR VISUALS
	local info = { 
		Source = caster, 
		Ability = self, 
		vSpawnOrigin = Vector(origin.x, origin.y, origin.z + 128), 
			
		bDeleteOnHit = false, 
			
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY, 
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE, 
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
			
		EffectName = projectile_name, 
		fDistance = projectile.fDistance, 
		fStartRadius = hitbox, 
		fEndRadius = hitbox, 
		vVelocity = projectile.vVelocity, 
	
		bHasFrontalCone = false, 
		bReplaceExisting = false, 
		fExpireTime = GameRules:GetGameTime() + 8.0, 
			
		bProvidesVision = true, 
	} 
	Projectiles:CreateProjectile(projectile)
	ProjectileManager:CreateLinearProjectile(info) 
	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Ability start
function spectre_special_attack:PlayEffectsOnCast()
	EmitSoundOn( "Hero_Spectre.DaggerCast", self:GetCaster() )
end

-- On Projectile hit an enemy
function spectre_special_attack:PlayEffectsOnImpact(hTarget)
	EmitSoundOn( "Hero_Spectre.DaggerImpact", hTarget )

	local particle_cast = "particles/econ/items/spectre/spectre_transversant_soul/spectre_ti7_crimson_spectral_dagger_path_owner_impact.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, hTarget )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	spectre_special_attack,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 0.7 },
	{ movement_speed = 20, fixed_range = 1 }
)