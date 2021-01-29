mars_special_attack = class({})
LinkLuaModifier("modifier_mars_special_attack_displacement", "abilities/heroes/mars/mars_special_attack/modifier_mars_special_attack_displacement", LUA_MODIFIER_MOTION_BOTH)

function mars_special_attack:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_5 end
function mars_special_attack:GetPlaybackRateOverride() 	    return 0.9 end
function mars_special_attack:GetCastPointSpeed() 			return 0 end

function mars_special_attack:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = self:GetSpecialValueFor("ability_damage")
	local fading_slow_pct = self:GetSpecialValueFor("fading_slow_pct")
	local fading_slow_duration = self:GetSpecialValueFor("fading_slow_duration")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local damage_per_stack = self:GetSpecialValueFor("damage_per_stack")

	local stacks = CustomEntities:SafeGetModifierStacks(caster, "modifier_mars_basic_attack_stacks")
	local final_damage = damage + (stacks * damage_per_stack)

	local projectile_particle = "particles/units/heroes/hero_mars/mars_spear.vpcf"
	local projectile_direction = Direction2D(origin, point)
	local projectile_origin = caster:GetAbsOrigin() + projectile_direction * 80 + Vector(0,0,80)
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_hitbox = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetCastRange(Vector(0,0,0), nil)

	local projectile = {
		EffectName = projectile_particle,
		vSpawnOrigin = projectile_origin,
		fDistance = projectile_distance,
		fStartRadius = projectile_hitbox,
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		TreeBehavior = PROJECTILES_DESTROY,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntities:Allies(_self.Source, unit) end,
		OnUnitHit = function(_self, unit)
			local counter = 0
			for k, v in pairs(_self.tHitLog) do counter = counter + 1 end
			if counter > 1 then return end
			
			local damage_table = {
				victim = unit,
				attacker = caster,
				damage = final_damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}
			ApplyDamage(damage_table)

			local current_direction = _self.current_velocity:Normalized()
			local left_distance = _self.fDistance - _self.distanceTraveled

			unit:AddNewModifier(_self.Source, self, "modifier_mars_special_attack_displacement", { 
				x = current_direction.x,
				y = current_direction.y,
				r = left_distance,
				speed = projectile_speed,
				peak = 1,
			})

			if _self.Source == caster then
				if CustomEntities:ProvidesMana(unit) then
					CustomEntities:GiveManaAndEnergyPercent(caster, mana_gain_pct, true)
				end
			end
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos, _self.current_velocity:Normalized())
		end,
	}

    ExecuteOrderFromTable({ OrderType = DOTA_UNIT_ORDER_STOP, UnitIndex = caster:entindex() })
	ProjectilesManagerInstance:CreateProjectile(projectile)
	CustomEntities:SafeDestroyModifier(caster, "modifier_mars_basic_attack_stacks")

	self:PlayEffectsOnCast()
end

function mars_special_attack:PlayEffectsOnFinish(pos, direction)
	EmitSoundOnLocationWithCaster(pos, "Hero_Mars.Spear.Target", self:GetCaster())
	
	local particle_cast = "particles/units/heroes/hero_mars/mars_spear_end.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
    ParticleManager:SetParticleControl(effect_cast, 3, pos)
    ParticleManager:SetParticleControlForward(effect_cast, 3, direction)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function mars_special_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_Mars.Spear.Cast", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(mars_special_attack)