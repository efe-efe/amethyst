spectre_second_attack = class({})
spectre_ex_second_attack = class({})

function spectre_second_attack:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function spectre_second_attack:GetPlaybackRateOverride()	return 0.25 end
function spectre_second_attack:GetCastPointSpeed() 			return 0 end

function spectre_second_attack:OnAbilityPhaseStart()
	self:PlayEffectsOnPhase()
	return true
end

function spectre_second_attack:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()

	local damage = self:GetSpecialValueFor("ability_damage")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local projectile = {
		vSpawnOrigin = 			origin + Vector(projectile_direction.x * 45, projectile_direction.y * 45, 96),
		fDistance = 			self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fStartRadius =			self:GetSpecialValueFor("hitbox"),
		Source = 				caster,
		vVelocity = 			projectile_direction * projectile_speed,
		UnitBehavior = 			PROJECTILES_DESTROY,
		WallBehavior = 			PROJECTILES_DESTROY,
		TreeBehavior = 			PROJECTILES_NOTHING,
		GroundBehavior = 		PROJECTILES_NOTHING,
		fGroundOffset = 		80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}

			ApplyDamage(damage_table)

			caster:GiveManaPercent(mana_gain_pct, unit)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
		OnThinkBegin = function(_self, pos)
			local effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_grimstroke/grimstroke_cast_soulchain.vpcf", PATTACH_WORLDORIGIN, nil)
			ParticleManager:SetParticleControl(effect_cast, 0, pos)
			ParticleManager:SetParticleControl(effect_cast, 1, pos)
			ParticleManager:SetParticleControl(effect_cast, 2, pos)
			ParticleManager:SetParticleControl(effect_cast, 60, Vector(155, 7, 229))
			ParticleManager:SetParticleControl(effect_cast, 61, Vector(1, 0, 0))
			ParticleManager:ReleaseParticleIndex(effect_cast)
		end,
	}

	Projectiles:CreateProjectile(projectile)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 2.0)
	self:PlayEffectsOnCast()
end

function spectre_second_attack:PlayEffectsOnPhase()
	local caster = self:GetCaster()
	EmitSoundOn("Hero_Spectre.Haunt", caster)
	EFX('particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_sunder_ti8_swirl_rope.vpcf', PATTACH_ABSORIGIN_FOLLOW, caster, {
		cp15 = Vector(128, 32, 108),
		cp15 = Vector(1, 0, 0),
		release = true,
	})
end

function spectre_second_attack:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()

	EmitSoundOnLocationWithCaster(pos, "Hero_Nevermore.RequiemOfSouls.Damage", caster)
	EFX('particles/units/heroes/hero_arc_warden/arc_warden_wraith_cast.vpcf', PATTACH_ABSORIGIN, caster, {
		cp0 = pos,
		cp1 = pos,
		cp2 = pos,
		release = true,
	})
end

function spectre_second_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_Nevermore.Raze_Flames", self:GetCaster())
end

spectre_ex_second_attack.PlayEffectsOnCast = spectre_second_attack.PlayEffectsOnCast
spectre_ex_second_attack.PlayEffectsOnFinish = spectre_second_attack.PlayEffectsOnFinish

function spectre_ex_second_attack:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function spectre_ex_second_attack:GetPlaybackRateOverride()		return 1.0 end
function spectre_ex_second_attack:GetCastPointSpeed() 			return 0 end

function spectre_ex_second_attack:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()

	local damage = self:GetSpecialValueFor("ability_damage")
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local projectile = {
		EffectName =			'particles/spectre/spectre_ex_second_attack.vpcf', 
		vSpawnOrigin = 			origin + Vector(projectile_direction.x * 45, projectile_direction.y * 45, 96),
		fDistance = 			self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fStartRadius =			self:GetSpecialValueFor("hitbox"),
		Source = 				caster,
		vVelocity = 			projectile_direction * projectile_speed,
		UnitBehavior = 			PROJECTILES_DESTROY,
		WallBehavior = 			PROJECTILES_DESTROY,
		TreeBehavior = 			PROJECTILES_NOTHING,
		GroundBehavior = 		PROJECTILES_NOTHING,
		fGroundOffset = 		80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}

			ApplyDamage(damage_table)

			if unit:IsAlive() then
				self:TeleportTarget(unit, _self.Source)
			end
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

function spectre_ex_second_attack:TeleportTarget(hTarget, hCaster)
	local vCasterOrigin = hCaster:GetAbsOrigin()
	local hTargetOrigin = hTarget:GetAbsOrigin()
	local vDirection = (hTargetOrigin - vCasterOrigin):Normalized()
	local vNewOrigin = vCasterOrigin + vDirection * 150

	EFX('particles/units/heroes/hero_spectre/spectre_death.vpcf', PATTACH_WORLDORIGIN, hTarget, {
		cp0 = hTargetOrigin,
		cp3 = hTargetOrigin,
		release = true,
	})

	FindClearSpaceForUnit(hTarget, vNewOrigin, true)

	EFX('particles/econ/items/outworld_devourer/od_shards_exile_gold/od_shards_exile_prison_end_gold.vpcf', PATTACH_WORLDORIGIN, hTarget, {
		cp0 = vNewOrigin,
		release = true,
	})
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(spectre_second_attack)
Abilities.Castpoint(spectre_ex_second_attack)
Abilities.Tie(spectre_second_attack, 'spectre_ex_second_attack')
Abilities.Tie(spectre_ex_second_attack, 'spectre_second_attack')