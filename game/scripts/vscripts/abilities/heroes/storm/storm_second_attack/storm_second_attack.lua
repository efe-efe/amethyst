storm_second_attack = class({})
LinkLuaModifier("modifier_storm_second_attack", "abilities/heroes/storm/storm_second_attack/modifier_storm_second_attack", LUA_MODIFIER_MOTION_NONE)

function storm_second_attack:GetCastAnimationCustom()		return ACT_DOTA_ATTACK end
function storm_second_attack:GetPlaybackRateOverride() 	    return 1.5 end
function storm_second_attack:GetCastPointSpeed() 			return 10 end
function storm_second_attack:GetAnimationTranslate() 		return "overload" end

function storm_second_attack:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = self:GetSpecialValueFor("ability_damage")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local duration = self:GetSpecialValueFor("duration")
	
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = Direction2D(origin, point)

	CustomEntities:ProjectileAttack(caster, {
		tProjectile = {
			EffectName = "particles/storm/storm_second_attack.vpcf",
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

				if _self.Source == caster then
					if CustomEntities:ProvidesMana(unit) then
						CustomEntities:GiveManaAndEnergyPercent(caster, mana_gain_pct, true)
					end
					if caster:HasModifier('modifier_storm_ultimate') then
						local extra_mana_pct = mana_gain_pct * (caster:FindModifierByName('modifier_storm_ultimate'):GetManaMultiplier() - 1)
						if CustomEntities:ProvidesMana(unit) then
							CustomEntities:GiveManaPercent(caster, extra_mana_pct, true, true)
						end
					end
				end

				if self:GetLevel() >= 2 then
					unit:AddNewModifier(_self.Source, self, 'modifier_storm_second_attack', { duration = duration })
				end
			end,
			OnFinish = function(_self, pos)
				self:PlayEffectsOnFinish(pos)
			end,
		}
	})

	self:PlayEffectsOnCast()
end

function storm_second_attack:PlayEffectsOnFinish(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_StormSpirit.ProjectileImpact", caster)
	EmitSoundOnLocationWithCaster(pos, "Hero_StormSpirit.StaticRemnantExplode", caster)
	
	local particle_cast = "particles/storm/storm_basic_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function storm_second_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_StormSpirit.Attack", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(storm_second_attack)