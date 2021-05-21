puck_mobility = class({})
puck_mobility_recast = class({})
puck_ex_mobility = class({})
puck_ex_mobility_recast = class({})

LinkLuaModifier("modifier_puck_mobility_recast", "abilities/heroes/puck/puck_mobility/modifier_puck_mobility_recast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_ex_mobility_recast", "abilities/heroes/puck/puck_mobility/modifier_puck_ex_mobility_recast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_ex_mobility_fear", "abilities/heroes/puck/puck_mobility/modifier_puck_ex_mobility_fear", LUA_MODIFIER_MOTION_NONE)

function puck_mobility:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function puck_mobility:GetPlaybackRateOverride() 	    return 1.0 end
function puck_mobility:GetCastPointSpeed() 			return 10 end

function puck_mobility:OnSpellStart()
	local caster = self:GetCaster()
	local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local origin = caster:GetOrigin()
	local damage = self:GetSpecialValueFor("ability_damage")
	local damage_aoe = self:GetSpecialValueFor("damage_aoe")
	local radius = self:GetSpecialValueFor("radius")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local refreshed = false

	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = Direction2D(origin, point)

	local damage_table = {
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
	}

	local projectile = nil

	CustomEntitiesLegacy:ProjectileAttack(caster, {
		OnProjectileCreated = function(hProjectile)
			projectile = hProjectile
		end,
		tProjectile = {
			EffectName = "particles/econ/items/puck/puck_alliance_set/puck_illusory_orb_aproset.vpcf",
			vSpawnOrigin = caster:GetAbsOrigin() + Vector(0,0,80),
			fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
			fStartRadius = self:GetSpecialValueFor("hitbox"),
			Source = caster,
			bIsReflectable = false,
			bIsDestructible = false,
			vVelocity = projectile_direction * projectile_speed,
			UnitBehavior = PROJECTILES_NOTHING,
			TreeBehavior = PROJECTILES_NOTHING,
			WallBehavior = PROJECTILES_NOTHING,
			GroundBehavior = PROJECTILES_NOTHING,
			fGroundOffset = 0,
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(_self.Source, unit) end,
			OnUnitHit = function(_self, unit)
				damage_table.victim = unit
				ApplyDamage(damage_table)

				if _self.Source == caster then
					if self:GetLevel() >= 2 and CustomEntitiesLegacy:ProvidesMana(unit) then
						self:EndCooldown()
						refreshed = true
					end

					if CustomEntitiesLegacy:ProvidesMana(unit) then
						CustomEntitiesLegacy:GiveManaAndEnergyPercent(caster, mana_gain_pct, true)
					end
				end
			end,
			OnFinish = function(_self, pos)
				damage_table.damage = damage_aoe
				ApplyCallbackForUnitsInArea(_self.Source, pos, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
					damage_table.victim = unit
					ApplyDamage(damage_table)
				end)

				ScreenShake(pos, 100, 300, 0.45, 1000, 0, true)
				CreateRadiusMarker(_self.Source, pos, radius, RADIUS_SCOPE_PUBLIC, 0.1)
				EmitSoundOn("Hero_Puck.EtherealJaunt", _self.Source)
				EmitSoundOnLocationWithCaster(pos, 'Hero_Puck.Waning_Rift', _self.Source)
				StopSoundOn("Hero_Puck.Illusory_Orb", _self.Source)
				self:PlayEffectsOnFinish(pos, 'particles/econ/items/puck/puck_merry_wanderer/puck_illusory_orb_explode_merry_wanderer.vpcf')
			end,
		}
	})

    local time = self:GetCastRange(Vector(0,0,0), nil)/projectile_speed
    caster:AddNewModifier(caster, self, "modifier_puck_mobility_recast", { duration = time })
    caster:FindAbilityByName("puck_mobility_recast"):SetProjectile(projectile)
	self:PlayEffectsOnCast()

	LinkAbilityCooldowns(caster, 'puck_ex_mobility', {
		["0"] = {
			ability = 'puck_ex_mobility',
			level = 2,
		}
	})
end

function puck_mobility:PlayEffectsOnFinish(pos, particle, exParticle)
	StopSoundOn("Hero_Puck.Illusory_Orb", self:GetCaster())
	
	local effect_cast = ParticleManager:CreateParticle(particle, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	if exParticle then
		effect_cast = ParticleManager:CreateParticle(exParticle, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(effect_cast, 0, pos)
		ParticleManager:SetParticleControl(effect_cast, 1, pos)
		ParticleManager:ReleaseParticleIndex(effect_cast)
	end
end

function puck_mobility:PlayEffectsOnCast()
	EmitSoundOn("Hero_Puck.Illusory_Orb", self:GetCaster())
end

function puck_mobility:OnUpgrade()
	CustomAbilitiesLegacy:LinkUpgrades(self, "puck_mobility_recast")
end

function puck_mobility_recast:GetCastPointSpeed()    return 0 end

function puck_mobility_recast:OnSpellStart()
    FindClearSpaceForUnit(self:GetCaster(), self.projectile:GetPosition(), true)
    EmitSoundOn("Hero_Puck.EtherealJaunt", self:GetCaster())
    
	StopSoundOn("Hero_Puck.Illusory_Orb", self:GetCaster())
    self.projectile:ScheduleDestroy()
end

function puck_mobility_recast:SetProjectile(projectile)
    if IsServer() then
        self.projectile = projectile
    end
end

function puck_mobility_recast:OnUpgrade()
	CustomAbilitiesLegacy:LinkUpgrades(self, "puck_mobility")
end

puck_ex_mobility.GetCastAnimationCustom = puck_mobility.GetCastAnimationCustom
puck_ex_mobility.PlayEffectsOnCast = puck_mobility.PlayEffectsOnCast
puck_ex_mobility.PlayEffectsOnFinish = puck_mobility.PlayEffectsOnFinish

function puck_ex_mobility:GetPlaybackRateOverride() 	    return 0.5 end
function puck_ex_mobility:GetCastPointSpeed() 			return 10 end

function puck_ex_mobility:OnSpellStart()
	local caster = self:GetCaster()
	local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local origin = caster:GetOrigin()

	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = Direction2D(origin, point)

	local radius = self:GetSpecialValueFor('radius')
	local fear_duration = self:GetSpecialValueFor('fear_duration')
	local damage = self:GetSpecialValueFor("damage")
	local damage_aoe = self:GetSpecialValueFor("damage_aoe")
	local damage_table = {
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_PURE,
	}

	local projectile = nil

	CustomEntitiesLegacy:ProjectileAttack(caster, {
		OnProjectileCreated = function(hProjectile)
			projectile = hProjectile
		end,
		tProjectile = {
			EffectName = "particles/puck/puck_ex_mobility.vpcf",
			vSpawnOrigin = caster:GetAbsOrigin() + Vector(0,0,80),
			fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
			fStartRadius = self:GetSpecialValueFor("hitbox"),
			Source = caster,
			bIsReflectable = false,
			bIsDestructible = false,
			vVelocity = projectile_direction * projectile_speed,
			UnitBehavior = PROJECTILES_NOTHING,
			TreeBehavior = PROJECTILES_NOTHING,
			WallBehavior = PROJECTILES_NOTHING,
			GroundBehavior = PROJECTILES_NOTHING,
			fGroundOffset = 0,
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(_self.Source, unit) end,
			OnUnitHit = function(_self, unit)
				damage_table.victim = unit
				ApplyDamage(damage_table)
			end,
			OnFinish = function(_self, pos)
				damage_table.damage = damage_aoe
				ApplyCallbackForUnitsInArea(_self.Source, pos, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
					damage_table.victim = unit
					ApplyDamage(damage_table)
					unit:AddNewModifier(caster, self, "modifier_puck_ex_mobility_fear", { 
						duration = fear_duration,
						max_slow_pct = fading_slow_pct 
					})
				end)

				ScreenShake(pos, 100, 300, 0.45, 1000, 0, true)
				CreateRadiusMarker(_self.Source, pos, radius, RADIUS_SCOPE_PUBLIC, 0.1)
				EmitSoundOn("Hero_Puck.EtherealJaunt", _self.Source)
				EmitSoundOnLocationWithCaster(pos, 'Hero_Puck.Waning_Rift', _self.Source)
				StopSoundOn("Hero_Puck.Illusory_Orb", _self.Source)
				self:PlayEffectsOnFinish(pos, 'particles/econ/items/puck/puck_alliance_set/puck_illusory_orb_explode_aproset.vpcf', 'particles/econ/items/abaddon/abaddon_alliance/abaddon_death_coil_alliance_explosion.vpcf')
			end,
		}
	})

    local time = self:GetCastRange(Vector(0,0,0), nil)/projectile_speed
    caster:AddNewModifier(caster, self, "modifier_puck_ex_mobility_recast", { duration = time })
    caster:FindAbilityByName("puck_ex_mobility_recast"):SetProjectile(projectile)
	self:PlayEffectsOnCast()

	LinkAbilityCooldowns(caster, 'puck_mobility', {
		["0"] = {
			ability = self,
			level = 2,
		}
	})
end

function puck_ex_mobility:OnUpgrade()
	CustomAbilitiesLegacy:LinkUpgrades(self, "puck_ex_mobility_recast")
end

function puck_ex_mobility_recast:GetCastPointSpeed()    	return 0 end
function puck_ex_mobility_recast:GetCastAnimationCustom()	return ACT_DOTA_CAST_ABILITY_2 end
function puck_ex_mobility_recast:OnSpellStart()
    FindClearSpaceForUnit(self:GetCaster(), self.projectile:GetPosition(), true)
    EmitSoundOn("Hero_Puck.EtherealJaunt", self:GetCaster())
	StopSoundOn("Hero_Puck.Illusory_Orb", self:GetCaster())
    self.projectile:ScheduleDestroy()
end

function puck_ex_mobility_recast:SetProjectile(projectile)
    if IsServer() then
        self.projectile = projectile
    end
end

function puck_ex_mobility_recast:OnUpgrade()
	CustomAbilitiesLegacy:LinkUpgrades(self, "puck_ex_mobility")
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(puck_mobility)
Abilities.Castpoint(puck_mobility_recast)
Abilities.Castpoint(puck_ex_mobility)