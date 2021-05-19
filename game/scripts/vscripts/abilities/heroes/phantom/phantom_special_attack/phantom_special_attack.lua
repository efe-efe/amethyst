
phantom_special_attack = class({})
phantom_ex_special_attack = class({})

LinkLuaModifier("modifier_phantom_strike_stack", "abilities/heroes/phantom/phantom_shared_modifiers/modifier_phantom_strike_stack", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_fading_slow", "abilities/generic/modifier_generic_fading_slow", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_special_attack_charges", "abilities/heroes/phantom/phantom_special_attack/modifier_phantom_special_attack_charges", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_bleed", "abilities/heroes/phantom/modifier_phantom_bleed", LUA_MODIFIER_MOTION_NONE)

function phantom_special_attack:GetIntrinsicModifierName()
	return "modifier_phantom_special_attack_charges"
end

function phantom_special_attack:GetCastAnimationCustom()		return ACT_DOTA_TELEPORT_END end 
function phantom_special_attack:GetPlaybackRateOverride() 		return 2.0 end
function phantom_special_attack:GetCastPointSpeed() 			return 80 end
function phantom_special_attack:GetFadeGestureOnCast()			return false end

function phantom_special_attack:OnSpellStart()
	local caster = self:GetCaster()
	local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local origin = caster:GetAbsOrigin()
	local damage = self:GetSpecialValueFor("ability_damage")
	local bleed_duration = self:GetSpecialValueFor("bleed_duration")

	local fading_slow_duration = self:GetSpecialValueFor("fading_slow_duration")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local fading_slow_pct = self:GetSpecialValueFor("fading_slow_pct")

	local projectile_direction = Direction2D(origin, point)
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	
	CustomEntitiesLegacy:ProjectileAttack(caster, {
		tProjectile  = {
			EffectName = "particles/phantom/phantom_special_attack.vpcf",
			vSpawnOrigin = origin + Vector(projectile_direction.x * 30, projectile_direction.y * 30, 96),
			fDistance =	self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
			fStartRadius = self:GetSpecialValueFor("hitbox"),
			Source = caster,
			vVelocity = projectile_direction * projectile_speed,
			UnitBehavior = PROJECTILES_DESTROY,
			TreeBehavior = PROJECTILES_NOTHING,
			WallBehavior = PROJECTILES_DESTROY,
			GroundBehavior = PROJECTILES_NOTHING,
			fGroundOffset = 0,
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(_self.Source, unit) end,
			OnUnitHit = function(_self, unit) 
				local damage_table = {
					victim = unit,
					attacker = caster,
					damage = damage,
					damage_type = DAMAGE_TYPE_PHYSICAL,
				}
				ApplyDamage(damage_table)

				if _self.Source == caster then
					if CustomEntitiesLegacy:ProvidesMana(unit) then
						CustomEntitiesLegacy:GiveManaAndEnergyPercent(caster, mana_gain_pct, true)
					end

					if not CustomEntitiesLegacy:IsObstacle(unit) then
						caster:AddNewModifier(
							caster,
							self,
							"modifier_phantom_strike_stack",
							{}
						)
					end
				end

				unit:AddNewModifier(
					_self.Source,
					self,
					"modifier_generic_fading_slow",
					{ duration = fading_slow_duration, max_slow_pct = fading_slow_pct }
				)
				
				if self:GetLevel() >= 2 then
					unit:AddNewModifier(
						_self.Source,
						self,
						'modifier_phantom_bleed',
						{ duration = bleed_duration }
					)
				end
			end,
			OnFinish = function(_self, pos)
				self:PlayEffectsOnFinish(pos)
			end,
		}
	})

	self:PlayEffectsOnCast()
end

function phantom_special_attack:OnUpgrade()
	if self:GetLevel() == 2 then
		self:GetCaster():FindModifierByName("modifier_phantom_special_attack_charges"):AddCharge()
	end
end

function phantom_special_attack:PlayEffectsOnFinish(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_PhantomAssassin.Dagger.Target", self:GetCaster())
	
	local particle_cast = "particles/phantom/phantom_special_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function phantom_special_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_PhantomAssassin.Dagger.Cast", self:GetCaster())
end


if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(phantom_special_attack)