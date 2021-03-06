
phantom_special_attack = class({})
phantom_ex_special_attack = class({})

LinkLuaModifier("modifier_phantom_strike_stack", "abilities/heroes/phantom/phantom_shared_modifiers/modifier_phantom_strike_stack", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_special_attack_charges", "abilities/heroes/phantom/phantom_special_attack/modifier_phantom_special_attack_charges", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_bleed", "abilities/heroes/phantom/modifier_phantom_bleed", LUA_MODIFIER_MOTION_NONE)

function phantom_special_attack:GetIntrinsicModifierName()
	return "modifier_phantom_special_attack_charges"
end

function phantom_special_attack:GetCastAnimationCustom()		return ACT_DOTA_TELEPORT_END end 
function phantom_special_attack:GetPlaybackRateOverride() 		return 2.0 end
function phantom_special_attack:GetCastPointSpeed() 			return 80 end
function phantom_special_attack:GetFadeGestureOnCast()			return false end

function phantom_special_attack:GetCooldown(iLevel)
	if self:GetCaster():HasModifier("modifier_upgrade_phantom_fast_daggers") then 
		local attacks_per_second = self:GetCaster():GetAttacksPerSecond()
		local attack_speed = (1 / attacks_per_second)
		
		return attack_speed * 2
	else 
		return self.BaseClass.GetCooldown(self, self:GetLevel())
	end
end

function phantom_special_attack:OnSpellStart()
	local caster = self:GetCaster()
	local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local origin = caster:GetAbsOrigin()
	local straight_direction = Direction2D(origin, point)

	local directions = {}
    table.insert(directions, straight_direction)

	if caster:HasModifier("modifier_upgrade_phantom_extra_daggers") then
    	table.insert(directions, RotatePoint(Vector(0,0,0), Vector(0,0,0) + straight_direction, -30):Normalized())
    	table.insert(directions, RotatePoint(Vector(0,0,0), Vector(0,0,0) + straight_direction, 30):Normalized())
	end

    for _,direction in ipairs(directions) do
		self:ThrowProjectile(origin, direction)
	end

	self:PlayEffectsOnCast()
end

function phantom_special_attack:ThrowProjectile(vOrigin, vDirection)
	local caster = self:GetCaster()
	local bleed_duration = self:GetSpecialValueFor("bleed_duration")
	local damage_modifier = self:GetSpecialValueFor("damage_modifier")
	local damage = caster:GetAverageTrueAttackDamage(caster)
	local final_damage = damage + damage_modifier

	local damage_table = {
		attacker = caster,
		damage = final_damage,
		damage_type = DAMAGE_TYPE_PHYSICAL,
	}

	local fading_slow_duration = self:GetSpecialValueFor("fading_slow_duration")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local fading_slow_pct = self:GetSpecialValueFor("fading_slow_pct")

	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_distance = self:GetCastRange(Vector(0,0,0), nil)

	CustomEntitiesLegacy:ProjectileAttack(caster, {
		bIsBasicAttack = true,
		tProjectile  = {
			EffectName = "particles/phantom/phantom_special_attack.vpcf",
			vSpawnOrigin = vOrigin + Vector(vDirection.x * 30, vDirection.y * 30, 96),
			fDistance =	projectile_distance,
			fStartRadius = self:GetSpecialValueFor("hitbox"),
			Source = caster,
			vVelocity = vDirection * projectile_speed,
			UnitBehavior = PROJECTILES_DESTROY,
			TreeBehavior = PROJECTILES_NOTHING,
			WallBehavior = PROJECTILES_DESTROY,
			GroundBehavior = PROJECTILES_NOTHING,
			fGroundOffset = 0,
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(_self.Source, unit) end,
			OnUnitHit = function(_self, unit) 
				damage_table.victim = unit
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

					if not _self.Source:HasModifier("modifier_upgrade_phantom_fast_daggers") then 
						unit:AddNewModifier(
							_self.Source,
							self,
							"modifier_generic_fading_slow",
							{ duration = fading_slow_duration, max_slow_pct = fading_slow_pct }
						)
					end
				end

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