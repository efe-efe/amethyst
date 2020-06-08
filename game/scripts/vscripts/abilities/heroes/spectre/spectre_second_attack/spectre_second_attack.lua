spectre_second_attack = class({})

function spectre_second_attack:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function spectre_second_attack:GetPlaybackRateOverride()	return 0.25 end
function spectre_second_attack:GetCastPointSpeed() 			return 0 end

function spectre_second_attack:OnAbilityPhaseStart()
	self:PlayEffectsOnPhase()
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
		vSpawnOrigin = 			caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance = 			self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius =			self:GetSpecialValueFor("hitbox"),
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
	EmitSoundOn("Hero_Spectre.Haunt", self:GetCaster())
	local particle_cast = "particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_sunder_ti8_swirl_rope.vpcf"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 15, Vector(128, 32, 108))
	ParticleManager:SetParticleControl(effect_cast, 16, Vector(1, 0, 0))

	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function spectre_second_attack:PlayEffectsOnFinish(pos)
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

function spectre_second_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_Nevermore.Raze_Flames", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(spectre_second_attack)