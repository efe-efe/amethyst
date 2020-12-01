spectre_second_attack = class({})

function spectre_second_attack:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function spectre_second_attack:GetPlaybackRateOverride()	return 0.25 end
function spectre_second_attack:GetCastPointSpeed() 			return 0 end

function spectre_second_attack:OnAbilityPhaseStart()
	self:PlayEffectsOnPhase()
	return true
end

function spectre_second_attack:OnAbilityPhaseInterrupted()
	DEFX(self.efx, true)
end

function spectre_second_attack:OnSpellStart()
	if self.efx then
		DEFX(self.efx, false)
	end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()

	local damage = self:GetSpecialValueFor("ability_damage")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local projectile = {
		EffectName =			"particles/spectre/spectre_second_attack.vpcf",
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

			EFX('particles/spectre/spectre_second_attack_impact.vpcf',PATTACH_ABSORIGIN_FOLLOW, unit, { 
				cp1 = unit:GetAbsOrigin(),
				release = true 
			})
			

			caster:GiveManaPercent(mana_gain_pct, unit)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	Projectiles:CreateProjectile(projectile)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 2.0)
	self:PlayEffectsOnCast()
end

function spectre_second_attack:PlayEffectsOnPhase()
	local caster = self:GetCaster()
	EmitSoundOn("Hero_Spectre.Haunt", caster)
	
	self.efx = ParticleManager:CreateParticle('particles/spectre/spectre_second_attack_casting.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(self.efx, 1, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, 'attach_hitloc', self:GetCaster():GetAbsOrigin(), false)
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

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(spectre_second_attack)