spectre_counter_recast = class({})

function spectre_counter_recast:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function spectre_counter_recast:GetPlaybackRateOverride()	    return 0.25 end
function spectre_counter_recast:GetCastPointSpeed() 			return 0 end
function spectre_counter_recast:GetIgnoreActivationCycle() 		return true end

function spectre_counter_recast:OnAbilityPhaseStart()
	self:PlayEffectsOnPhase()
end

function spectre_counter_recast:HasPriority()
	return true
end

function spectre_counter_recast:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()

	local damage = self:GetSpecialValueFor("ability_damage")
	
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local projectile = {
		vSpawnOrigin = 			caster:GetAbsOrigin() + Vector(0,0,80),
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

	local modifier = caster:FindModifierByName('modifier_spectre_counter_recast')
	if modifier then
		if modifier:GetStackCount() >= 1 then
			modifier:SetDuration(5.0, true)
		end
	end
	self:PlayEffectsOnCast()
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