spectre_counter_recast = class({})

function spectre_counter_recast:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function spectre_counter_recast:GetPlaybackRateOverride()	    return 1.0 end
function spectre_counter_recast:GetCastPointSpeed() 			return 0 end
function spectre_counter_recast:GetIgnoreActivationCycle() 		return true end

function spectre_counter_recast:OnAbilityPhaseStart()
	self:PlayEffectsOnPhase()
	return true
end

function spectre_counter_recast:HasPriority()
	return true
end

function spectre_counter_recast:OnSpellStart()
	local caster = self:GetCaster()
	local point = CustomAbilities:GetCursorPosition(self)
    local origin = caster:GetOrigin()
    local ability = caster:FindAbilityByName('spectre_counter')

	local damage = ability:GetSpecialValueFor("ability_damage")
	
	local projectile_direction = Direction2D(origin, point)
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	
	CustomEntitiesLegacy:ProjectileAttack(caster, {
		tProjectile = {
			EffectName =			"particles/spectre/spectre_ex_second_attack.vpcf",
			vSpawnOrigin = 			caster:GetAbsOrigin() + Vector(0, 0, 80),
			fDistance = 			self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
			fStartRadius =			self:GetSpecialValueFor("hitbox"),
			Source = 				caster,
			vVelocity = 			projectile_direction * projectile_speed,
			UnitBehavior = 			PROJECTILES_DESTROY,
			WallBehavior = 			PROJECTILES_DESTROY,
			TreeBehavior = 			PROJECTILES_NOTHING,
			GroundBehavior = 		PROJECTILES_NOTHING,
			fGroundOffset = 		0,
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(_self.Source, unit) end,
			OnUnitHit = function(_self, unit) 
				local damage_table = {
					victim = unit,
					attacker = caster,
					damage = damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
				}

				ApplyDamage(damage_table)

				self:TeleportTarget(unit, _self.Source)
			end,
			OnFinish = function(_self, pos)
				self:PlayEffectsOnFinish(pos)
			end
		}
	})

	self:PlayEffectsOnCast()
end

function spectre_counter_recast:TeleportTarget(hTarget, hCaster)
	local vCasterOrigin = hCaster:GetAbsOrigin()
	local hTargetOrigin = hTarget:GetAbsOrigin()
	local vDirection = (vCasterOrigin - hTargetOrigin):Normalized()
	local iDistance = (vCasterOrigin - hTargetOrigin):Length2D()
	local vNewOrigin = vCasterOrigin + hCaster:GetForwardVector() * 150
	local iSpeed = 3000

	local projectile = {
		EffectName =			"particles/spectre/spectre_ex_second_attack.vpcf",
		vSpawnOrigin = 			hTarget:GetAbsOrigin() + Vector(0, 0, 80),
		fDistance = 			iDistance,
		fStartRadius =			80,
		Source = 				hCaster,
		vVelocity = 			vDirection * iSpeed,
		UnitBehavior = 			PROJECTILES_DESTROY,
		WallBehavior = 			PROJECTILES_DESTROY,
		TreeBehavior = 			PROJECTILES_NOTHING,
		GroundBehavior = 		PROJECTILES_NOTHING,
		fGroundOffset = 		0,
		OnFinish = function(_self, pos)
			FindClearSpaceForUnit(hTarget, vNewOrigin, true)
			EFX('particles/units/heroes/hero_spectre/spectre_death.vpcf', PATTACH_WORLDORIGIN, hTarget, {
				cp0 = hTargetOrigin,
				cp3 = hTargetOrigin,
				release = true,
			})
			EFX('particles/econ/items/outworld_devourer/od_shards_exile_gold/od_shards_exile_prison_end_gold.vpcf', PATTACH_WORLDORIGIN, hTarget, {
				cp0 = vNewOrigin,
				release = true,
			})
		end,
	}

	ProjectilesManagerInstance:CreateProjectile(projectile)
end

function spectre_counter_recast:PlayEffectsOnPhase()
	EmitSoundOn("Hero_Spectre.Haunt", self:GetCaster())
	local particle_cast = "particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_sunder_ti8_swirl_rope.vpcf"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 15, Vector(128, 32, 108))
	ParticleManager:SetParticleControl(effect_cast, 16, Vector(1, 0, 0))

	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function spectre_counter_recast:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()

    local sound_cast = "Hero_Nevermore.RequiemOfSouls.Damage"
	EmitSoundOnLocationWithCaster(pos, sound_cast, caster)

	local particle_cast = "particles/units/heroes/hero_arc_warden/arc_warden_wraith_cast.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, caster)
	
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 1, pos)
	ParticleManager:SetParticleControl(effect_cast, 2, pos)

	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function spectre_counter_recast:PlayEffectsOnCast()
	EmitSoundOn("Hero_Nevermore.Raze_Flames", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(spectre_counter_recast)