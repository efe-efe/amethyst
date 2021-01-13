vengeful_special_attack = class({})
vengeful_special_attack_ultimate = class({})
LinkLuaModifier("modifier_vengeful_special_attack", "abilities/heroes/vengeful/vengeful_special_attack/modifier_vengeful_special_attack", LUA_MODIFIER_MOTION_NONE)

function vengeful_special_attack:GetCastAnimationCustom()		return ACT_DOTA_ATTACK end
function vengeful_special_attack:GetPlaybackRateOverride() 	    return 1.2 end
function vengeful_special_attack:GetCastPointSpeed() 			return 10 end
function vengeful_special_attack:GetCastPoint() 	                    return 0.3 end
function vengeful_special_attack:GetBehavior()                        return DOTA_ABILITY_BEHAVIOR_POINT end
function vengeful_special_attack:GetAbilityTextureName()              return self:GetName() end
function vengeful_special_attack:GetCooldown(iLevel)                  return 8 end
function vengeful_special_attack:GetCastRange(vLocation, hTarget)     return 800 end

function vengeful_special_attack:IsMimicable()
    return true
end

function vengeful_special_attack:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = self:GetSpecialValueFor("ability_damage")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local duration = self:GetSpecialValueFor("link_duration")
	
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()

	local projectile = {
		EffectName = "particles/vengeful/vengeful_special_attack_proj.vpcf",
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
            
            unit:AddNewModifier(_self.Source, self, "modifier_vengeful_special_attack", { duration = duration })

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

    local projectile = Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

function vengeful_special_attack:PlayEffectsOnFinish(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_StormSpirit.ProjectileImpact", caster)
	EmitSoundOnLocationWithCaster(pos, "Hero_StormSpirit.StaticRemnantExplode", caster)
	
	EFX("particles/econ/items/vengeful/vs_ti8_immortal_shoulder/vs_ti8_immortal_magic_missle_end.vpcf", PATTACH_WORLDORIGIN, nil, {
		cp0 = pos,
		cp1 = pos,
		cp3 = pos,
		release = true
	})
end

function vengeful_special_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_StormSpirit.Attack", self:GetCaster())
end

function MimicSpell(hAbility, hAbilityOriginal, iEnergyCost)
    for key,value in pairs(hAbilityOriginal) do
        hAbility[key] = hAbilityOriginal[key]
    end

    hAbility.IsMimicable = function() return false end
    hAbility.GetManaCost = function() return 0 end
    hAbility.GetEnergyCost = function() return iEnergyCost end
end

MimicSpell(vengeful_special_attack_ultimate, vengeful_special_attack, 25)

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(vengeful_special_attack)
Abilities.Castpoint(vengeful_special_attack_ultimate)