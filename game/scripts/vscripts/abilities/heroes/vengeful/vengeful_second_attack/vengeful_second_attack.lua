vengeful_second_attack = class({})
vengeful_second_attack_ultimate = class({})
vengeful_ex_second_attack = class({})
vengeful_ex_second_attack_ultimate = class({})
LinkLuaModifier("modifier_vengeful_second_attack", "abilities/heroes/vengeful/vengeful_second_attack/modifier_vengeful_second_attack", LUA_MODIFIER_MOTION_NONE)

function vengeful_second_attack:GetCastAnimationCustom()			return ACT_DOTA_SPAWN end
function vengeful_second_attack:GetPlaybackRateOverride()			return 2.0 end
function vengeful_second_attack:GetCastPointSpeed()					return 80 end
function vengeful_second_attack:GetCastPoint()						return 0.5 end
function vengeful_second_attack:GetBehavior()						return DOTA_ABILITY_BEHAVIOR_POINT end
function vengeful_second_attack:GetAbilityTextureName()				return self:GetName() end
function vengeful_second_attack:GetCooldown(iLevel)					return 8 end
function vengeful_second_attack:GetCastRange(vLocation, hTarget)	return 850 end

function vengeful_second_attack:OnAbilityPhaseStart()
	self:PlayEffectsOnPhase()
	return true
end

function vengeful_second_attack:OnAbilityPhaseInterrupted()
	DEFX(self.efx, true)
end

function vengeful_second_attack:IsMimicable()
    return true
end

function vengeful_second_attack:OnSpellStart()
	if self.efx then
		DEFX(self.efx, false)
	end
	self:ThrowProjectile()
	self:PlayEffectsOnCast()
	LinkAbilityCooldowns(self:GetCaster(), 'vengeful_ex_second_attack')
end

function vengeful_second_attack:ThrowProjectile(bIsBasicAttack)
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = self:GetSpecialValueFor("ability_damage")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local duration = self:GetSpecialValueFor("duration")
	
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()

	CustomEntities:ProjectileAttack(caster, {
		bIsBasicAttack = bIsBasicAttack,
		tProjectile = {
			EffectName = "particles/vengeful/vengeful_second_attack.vpcf",
			vSpawnOrigin = origin + Vector(projectile_direction.x * 45, projectile_direction.y * 45, 96),
			fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
			fStartRadius = self:GetSpecialValueFor("hitbox"),
			Source = caster,
			vVelocity = projectile_direction * projectile_speed,
			UnitBehavior = PROJECTILES_DESTROY,
			TreeBehavior = PROJECTILES_NOTHING,
			WallBehavior = PROJECTILES_DESTROY,
			GroundBehavior = PROJECTILES_NOTHING,
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

				unit:AddNewModifier(_self.Source, self, "modifier_vengeful_second_attack", { duration = duration })

				if _self.Source == caster then
					if CustomEntities:ProvidesMana(unit) then
						CustomEntities:GiveManaAndEnergyPercent(caster, mana_gain_pct, true)
					end
				end
			end,
			OnFinish = function(_self, pos)
				self:PlayEffectsOnFinish(pos)
			end,
		}
	})
end


function vengeful_second_attack:PlayEffectsOnPhase()
	local caster = self:GetCaster()
	self.efx = EFX('particles/spectre/spectre_second_attack_casting.vpcf', PATTACH_ABSORIGIN_FOLLOW, caster, {
		cp1 = {
			ent = caster,
			point = 'attach_hitloc'
		},
	})
end

function vengeful_second_attack:PlayEffectsOnFinish(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_StormSpirit.ProjectileImpact", self:GetCaster())
	EmitSoundOnLocationWithCaster(pos, "Hero_StormSpirit.StaticRemnantExplode", self:GetCaster())
	
	local particle_cast = "particles/units/heroes/hero_vengeful/vengeful_magic_missle_end.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function vengeful_second_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_VengefulSpirit.MagicMissile", self:GetCaster())
end

function vengeful_ex_second_attack:GetCastAnimationCustom()				return ACT_DOTA_SPAWN end
function vengeful_ex_second_attack:GetPlaybackRateOverride() 	    	return 2.0 end
function vengeful_ex_second_attack:GetCastPointSpeed() 					return 80 end
function vengeful_ex_second_attack:GetCastPoint() 	                    return 0.5 end
function vengeful_ex_second_attack:GetBehavior()                        return DOTA_ABILITY_BEHAVIOR_POINT end
function vengeful_ex_second_attack:GetAbilityTextureName()              return self:GetName() end
function vengeful_ex_second_attack:GetCooldown(iLevel)                  return 8 end
function vengeful_ex_second_attack:GetCastRange(vLocation, hTarget)     return 1600 end
function vengeful_ex_second_attack:GetManaCost()						return 25 end

function vengeful_ex_second_attack:OnAbilityPhaseStart()
	self:PlayEffectsOnPhase()
	return true
end

function vengeful_ex_second_attack:OnAbilityPhaseInterrupted()
	DEFX(self.efx, true)
end

function vengeful_ex_second_attack:IsMimicable()
    return true
end

function vengeful_ex_second_attack:OnSpellStart()
	if self.efx then
		DEFX(self.efx, false)
	end
	
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = self:GetSpecialValueFor("ability_damage")
	local heal = self:GetSpecialValueFor("heal")
	
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	local damage_table = {
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	}

	CustomEntities:ProjectileAttack(caster, {
		tProjectile = {
			EffectName = "particles/vengeful/vengeful_ex_second_attack.vpcf",
			vSpawnOrigin = origin + Vector(projectile_direction.x * 45, projectile_direction.y * 45, 96),
			fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
			fStartRadius = self:GetSpecialValueFor("hitbox"),
			Source = caster,
			vVelocity = projectile_direction * projectile_speed,
			UnitBehavior = PROJECTILES_DESTROY,
			TreeBehavior = PROJECTILES_NOTHING,
			WallBehavior = PROJECTILES_NOTHING,
			GroundBehavior = PROJECTILES_NOTHING,
			fGroundOffset = 0,
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntities:Allies(_self.Source, unit) end,
			OnUnitHit = function(_self, unit) 
				if CustomEntities:Allies(_self.Source, unit) then
					unit:Heal(heal, _self.Source)
				else 
					damage_table.victim = unit
					damage_table.attacker = _self.Source

					local unit_origin = unit:GetOrigin()
					local source_origin = _self.Source:GetOrigin()
					
					FindClearSpaceForUnit(_self.Source, unit_origin , true)
					FindClearSpaceForUnit(unit, source_origin , true)

					self:PlayEffectsSwap(unit)
					ApplyDamage(damage_table)
				end

				_self.Source:Heal(heal, _self.Source)
			end,
			OnFinish = function(_self, pos)
				self:PlayEffectsOnFinish(pos)
			end,
		}
	})

	LinkAbilityCooldowns(caster, 'vengeful_second_attack')
	EmitSoundOn("Hero_Chen.Attack", caster)
	EmitSoundOn("Hero_Chen.HolyPersuasionEnemy", caster)
end

function vengeful_ex_second_attack:PlayEffectsSwap(hTarget)
	local caster = self:GetCaster()
	EFX("particles/units/heroes/hero_vengeful/vengeful_nether_swap.vpcf", PATTACH_CUSTOMORIGIN, nil, {
		cp0 = {
			ent = caster,
			point = 'attach_hitloc'
		},
		cp1 = {
			ent = hTarget,
			point = 'attach_hitloc'
		},
		release = true
	})

    EmitSoundOn("Hero_VengefulSpirit.NetherSwap", caster)
    EmitSoundOn("Hero_VengefulSpirit.NetherSwap", hTarget)
end

function vengeful_ex_second_attack:PlayEffectsOnPhase()
	local caster = self:GetCaster()
	self.efx = EFX('particles/spectre/spectre_second_attack_casting.vpcf', PATTACH_ABSORIGIN_FOLLOW, caster, {
		cp1 = {
			ent = caster,
			point = 'attach_hitloc'
		},
	})
end

function vengeful_ex_second_attack:PlayEffectsOnFinish(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_StormSpirit.ProjectileImpact", self:GetCaster())
	EmitSoundOnLocationWithCaster(pos, "Hero_StormSpirit.StaticRemnantExplode", self:GetCaster())
	
	local particle_cast = "particles/units/heroes/hero_vengeful/vengeful_magic_missle_end.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function MimicSpell(hAbility, hAbilityOriginal, iEnergyCost)
    for key,value in pairs(hAbilityOriginal) do
        hAbility[key] = hAbilityOriginal[key]
    end

    hAbility.IsMimicable = function() return false end
    hAbility.GetManaCost = function() return 0 end
    hAbility.GetEnergyCost = function() return iEnergyCost end
end

MimicSpell(vengeful_second_attack_ultimate, vengeful_second_attack, 25)
MimicSpell(vengeful_ex_second_attack_ultimate, vengeful_ex_second_attack, 25)

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(vengeful_second_attack)
Abilities.Castpoint(vengeful_second_attack_ultimate)
Abilities.Castpoint(vengeful_ex_second_attack)
Abilities.Castpoint(vengeful_ex_second_attack_ultimate)