vengeful_counter = class({})
vengeful_counter_ultimate = class({})
vengeful_ex_counter = class({})
vengeful_ex_counter_ultimate = class({})

function vengeful_counter:GetCastAnimationCustom()			return ACT_DOTA_CAST_ABILITY_2 end
function vengeful_counter:GetPlaybackRateOverride() 	    return 1.0 end
function vengeful_counter:GetCastPointSpeed() 				return 0 end
function vengeful_counter:GetCastPoint()					return 0.3 end
function vengeful_counter:GetBehavior()						return DOTA_ABILITY_BEHAVIOR_POINT end
function vengeful_counter:GetAbilityTextureName()			return self:GetName() end
function vengeful_counter:GetCooldown(iLevel)				return 8 end
function vengeful_counter:GetCastRange(vLocation, hTarget)	return 1200 end

function vengeful_counter:IsMimicable()
    return true
end

function vengeful_counter:OnSpellStart()
	local caster = self:GetCaster()
	local damage = self:GetSpecialValueFor("ability_damage")
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	self:ThrowProjectile(caster, damage, origin, projectile_direction, projectile_speed, true)
	self:PlayEffectsOnCast()
	LinkAbilityCooldowns(caster, 'vengeful_ex_counter')
end

function vengeful_counter:ThrowProjectile(hCaster, iDamage, vOrigin, vDirection, fSpeed, bReturn)
	local ability = hCaster:FindAbilityByName("vengeful_counter")
	local mana_gain_pct = ability:GetSpecialValueFor("mana_gain_pct")
	local duration = ability:GetSpecialValueFor("duration")

	local projectile = {
		EffectName = "particles/units/heroes/hero_vengeful/vengeful_wave_of_terror.vpcf",
		vSpawnOrigin = vOrigin + Vector(vDirection.x * 45, vDirection.y * 45, 96),
		fDistance = ability:GetCastRange(Vector(0,0,0), nil),
		fStartRadius = ability:GetSpecialValueFor("hitbox"),
        Source = hCaster,
		vVelocity = vDirection * fSpeed,
		UnitBehavior = PROJECTILES_NOTHING,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_NOTHING,
		GroundBehavior = PROJECTILES_NOTHING,
		bIsReflectable = false,
		fGroundOffset = 0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntities:Allies(_self.Source, unit) end,
		OnUnitHit = function(_self, unit)
			local damage_table = {
				victim = unit,
				attacker = hCaster,
				damage = iDamage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = ability,
			}
			ApplyDamage(damage_table)
			if CustomEntities:ProvidesMana(unit) then
				CustomEntities:GiveManaAndEnergyPercent(hCaster, mana_gain_pct, true)
			end
		end,
		OnFinish = function(_self, pos)
			ability:PlayEffectsOnFinish(pos)
			if bReturn then
				local origin = hCaster:GetAbsOrigin()
				local projectile_direction = (Vector(origin.x-pos.x, origin.y-pos.y, 0)):Normalized()
				ability:ThrowProjectile(hCaster, 10, pos, projectile_direction, fSpeed * 1.25 , false)
			end
		end,
	}

    local projectile = Projectiles:CreateProjectile(projectile)
end

function vengeful_counter:PlayEffectsOnFinish(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_StormSpirit.ProjectileImpact", self:GetCaster())
	EmitSoundOnLocationWithCaster(pos, "Hero_StormSpirit.StaticRemnantExplode", self:GetCaster())
	
	local particle_cast = "particles/storm/storm_basic_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function vengeful_counter:PlayEffectsOnCast()
	EmitSoundOn("Hero_VengefulSpirit.WaveOfTerror", self:GetCaster())
end

function vengeful_ex_counter:GetCastAnimationCustom()			return ACT_DOTA_CAST_ABILITY_2 end
function vengeful_ex_counter:GetPlaybackRateOverride() 	    	return 1.0 end
function vengeful_ex_counter:GetCastPointSpeed() 				return 0 end
function vengeful_ex_counter:GetCastPoint()						return 0.3 end
function vengeful_ex_counter:GetBehavior()						return DOTA_ABILITY_BEHAVIOR_POINT end
function vengeful_ex_counter:GetAbilityTextureName()			return self:GetName() end
function vengeful_ex_counter:GetCooldown(iLevel)				return 8 end
function vengeful_ex_counter:GetCastRange(vLocation, hTarget)	return 2500 end
function vengeful_ex_counter:GetManaCost()						return 25 end

function vengeful_ex_counter:IsMimicable()
    return true
end

function vengeful_ex_counter:OnSpellStart()
	local caster = self:GetCaster()
    local origin = caster:GetOrigin()
	local damage = self:GetSpecialValueFor("ability_damage")
	local point = self:GetCursorPosition()
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local projectile = {
		EffectName = "particles/econ/items/vengeful/vengeful_weapon_talon/vengeful_wave_of_terror_weapon_talon.vpcf",
		vSpawnOrigin = origin + Vector(projectile_direction.x * 45, projectile_direction.y * 45, 96),
		fDistance = self:GetCastRange(Vector(0,0,0), nil),
		fStartRadius = self:GetSpecialValueFor("hitbox"),
        Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_NOTHING,
		GroundBehavior = PROJECTILES_NOTHING,
		bIsReflectable = false,
		fGroundOffset = 0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntities:Allies(_self.Source, unit) end,
		OnUnitHit = function(_self, unit)
			local damage_table = {
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self,
			}
			ApplyDamage(damage_table)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

    local projectile = Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
	LinkAbilityCooldowns(caster, 'vengeful_counter')
end

function vengeful_ex_counter:PlayEffectsOnFinish(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_StormSpirit.ProjectileImpact", self:GetCaster())
	EmitSoundOnLocationWithCaster(pos, "Hero_StormSpirit.StaticRemnantExplode", self:GetCaster())
	
	local particle_cast = "particles/storm/storm_basic_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function vengeful_ex_counter:PlayEffectsOnCast()
	EmitSoundOn("Hero_VengefulSpirit.WaveOfTerror", self:GetCaster())
end


function MimicSpell(hAbility, hAbilityOriginal, iEnergyCost)
    for key,value in pairs(hAbilityOriginal) do
        hAbility[key] = hAbilityOriginal[key]
    end

    hAbility.IsMimicable = function() return false end
    hAbility.GetManaCost = function() return 0 end
    hAbility.GetEnergyCost = function() return iEnergyCost end
end

MimicSpell(vengeful_counter_ultimate, vengeful_counter, 25)
MimicSpell(vengeful_ex_counter_ultimate, vengeful_ex_counter, 25)

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(vengeful_counter)
Abilities.Castpoint(vengeful_counter_ultimate)
Abilities.Castpoint(vengeful_ex_counter)
Abilities.Castpoint(vengeful_ex_counter_ultimate)