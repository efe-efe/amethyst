queen_wave = class({})

function queen_wave:GetCastAnimationCustom() return ACT_DOTA_CAST_ABILITY_4 end
function queen_wave:GetPlaybackRateOverride() return 0.8 end
function queen_wave:GetCastPointSpeed() return 0 end

function queen_wave:OnAbilityPhaseStart()
	EFX('particles/units/heroes/hero_dawnbreaker/dawnbreaker_converge.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetCaster(), { relese = true })
	return true
end

function queen_wave:OnSpellStart()
    local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	local direction = Direction2D(origin, point)
	local projectile_speed = 850--self:GetSpecialValueFor("projectile_speed")
	local damage = self:GetSpecialValueFor("ability_damage")
	local damage_table = {
        damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
	}

	CustomEntities:ProjectileAttack(caster, {
		tProjectile = {
			EffectName = "particles/units/heroes/hero_queenofpain/queen_sonic_wave.vpcf",
			vSpawnOrigin = origin + Vector(direction.x * 45, direction.y * 45, 96),
			fDistance = 1000,--self:GetSpecialValueFor("projectile_distance"),
			fStartRadius = self:GetSpecialValueFor("hitbox"),
			fEndRadius = self:GetSpecialValueFor("hitbox") * 4,
			Source = caster,
			vVelocity = direction * projectile_speed,
			UnitBehavior = PROJECTILES_NOTHING,
			TreeBehavior = PROJECTILES_NOTHING,
			WallBehavior = PROJECTILES_DESTROY,
			GroundBehavior = PROJECTILES_NOTHING,
			fGroundOffset = 0,
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntities:Allies(_self.Source, unit) end,
			OnUnitHit = function(_self, unit)
				damage_table.victim = unit
				damage_table.attacker = _self.Source
				
				ApplyDamage(damage_table)
				self:PlayEffectsOnHit(unit)
			end
		}
	})

	self:PlayEffectsOnCast()
end

function queen_wave:PlayEffectsOnCast()
	EmitSoundOn("Hero_QueenOfPain.SonicWave", self:GetCaster())
end

function queen_wave:PlayEffectsOnFinish(pos, particle_cast)
	local caster = self:GetCaster()
	EmitSoundOnLocationWithCaster(pos, "Hero_Centaur.DoubleEdge", caster)
	EmitSoundOnLocationWithCaster(pos, "Hero_Centaur.DoubleEdge.TI9_layer", caster)
	EmitSoundOnLocationWithCaster(pos, "Hero_Centaur.Gore", caster)

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 1, pos)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function queen_wave:PlayEffectsOnHit(hTarget)
	local caster = self:GetCaster()
	EmitSoundOn("Hero_Sniper.AssassinateDamage", caster)

	local particle_cast = "particles/units/heroes/hero_sniper/sniper_assassinate_impact_blood.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget)

	ParticleManager:SetParticleControl(effect_cast, 0, hTarget:GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, hTarget:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(queen_wave)