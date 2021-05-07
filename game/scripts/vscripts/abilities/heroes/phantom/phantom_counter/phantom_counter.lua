phantom_counter = class({})
phantom_counter_recast = class({})
phantom_ex_counter = class({})
phantom_ex_counter_recast = class({})

LinkLuaModifier("modifier_phantom_counter_banish", "abilities/heroes/phantom/phantom_counter/modifier_phantom_counter_banish", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_counter_countering", "abilities/heroes/phantom/phantom_counter/modifier_phantom_counter_countering", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_counter", "abilities/heroes/phantom/phantom_counter/modifier_phantom_counter", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_counter_recast", "abilities/heroes/phantom/phantom_counter/modifier_phantom_counter_recast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_ex_counter_recast", "abilities/heroes/phantom/phantom_counter/modifier_phantom_ex_counter_recast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_counter_shield", "abilities/heroes/phantom/phantom_counter/modifier_phantom_counter_shield", LUA_MODIFIER_MOTION_NONE)

function phantom_counter:OnSpellStart()
    local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("counter_duration")

    caster:AddNewModifier(
		caster,
		self,
        "modifier_phantom_counter_countering", 
		{ duration = duration }
	)

	LinkAbilityCooldowns(caster, 'phantom_ex_counter', {
		["0"] = {
			ability = 'phantom_ex_counter',
			level = 2,
		}
	})
end

function phantom_counter_recast:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local phantom_counter = caster:FindAbilityByName('phantom_counter')
	local duration = phantom_counter:GetSpecialValueFor('buff_duration')
	local shield = phantom_counter:GetSpecialValueFor('shield')
	local shield_duration = phantom_counter:GetSpecialValueFor('shield_duration')
	
	caster:AddNewModifier(caster, phantom_counter, 'modifier_phantom_counter', { duration = duration } )
	caster:AddNewModifier(caster, nil, "modifier_phantom_counter_shield", { duration = 6.0, damage_block = shield })

	EFX("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster, {
		cp3 = origin,
		release = true
	})
	
	EFX("particles/econ/items/phantom_assassin/pa_fall20_immortal_shoulders/pa_fall20_blur_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster, {
		cp3 = origin,
		release = true
	})

    EmitSoundOn("Hero_Sven.GodsStrength.Attack", caster)
    EmitSoundOn("Hero_Abaddon.AphoticShield.Cast", caster)
end

function phantom_ex_counter:OnSpellStart()
    local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(
		caster,
		self,
        "modifier_phantom_ex_counter_recast", 
		{ duration = duration }
	)
	
	self:PlayEffectsOnCast()

	LinkAbilityCooldowns(caster, 'phantom_counter', {
		["0"] = {
			ability = self,
			level = 2,
		}
	})
end

function phantom_ex_counter:PlayEffectsOnCast()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	EmitSoundOn("Hero_PhantomAssassin.Blur.Break", caster)

	EFX("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster, {
		cp3 = origin,
		release = true
	})
	
	EFX("particles/econ/items/phantom_assassin/pa_fall20_immortal_shoulders/pa_fall20_blur_start.vpcf", PATTACH_WORLDORIGIN, nil, {
		cp0 = origin,
		cp3 = origin,
		release = true
	})
end

function phantom_ex_counter_recast:GetCastAnimationCustom()		return ACT_DOTA_TELEPORT_END end 
function phantom_ex_counter_recast:GetPlaybackRateOverride()	return 2.0 end
function phantom_ex_counter_recast:GetCastPointSpeed()			return 80 end
function phantom_ex_counter_recast:GetFadeGestureOnCast()		return false end

function phantom_ex_counter_recast:OnSpellStart()
	local caster = self:GetCaster()
	local point = CustomAbilities:GetCursorPosition(self)
    local origin = caster:GetAbsOrigin()
	local stacks = CustomEntitiesLegacy:SafeGetModifierStacks(caster, "modifier_phantom_strike_stack")

	local ability = caster:FindAbilityByName('phantom_ex_counter')
	local duration_per_stack = ability:GetSpecialValueFor("duration_per_stack")
	local sleep_duration = ability:GetSpecialValueFor("sleep_duration")
	sleep_duration =  sleep_duration + (duration_per_stack * stacks)

	local damage = ability:GetSpecialValueFor("ability_damage")

	local projectile_direction = Direction2D(origin, point)
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	CustomEntitiesLegacy:ProjectileAttack(caster, {
		tProjectile  = {
			EffectName = "particles/phantom/phantom_counter_recast.vpcf",
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
					if not CustomEntitiesLegacy:IsObstacle(unit) then
						caster:AddNewModifier(
							caster, -- player source
							self, -- ability source
							"modifier_phantom_strike_stack", -- modifier name
							{} -- kv
						)
					end
				end

				unit:AddNewModifier(
					caster, -- player source
					self, -- ability source
					"modifier_generic_sleep", -- modifier name
					{ duration = sleep_duration } -- kv
				)
			end,
			OnFinish = function(_self, pos)
				self:PlayEffectsOnFinish(pos)
			end,
		}
	})

	CustomEntitiesLegacy:SafeDestroyModifier(caster, "modifier_phantom_strike_stack")
	self:PlayEffectsOnCast()
end

function phantom_ex_counter_recast:PlayEffectsOnFinish(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_PhantomAssassin.Dagger.Target", self:GetCaster())
	
	local particle_cast = "particles/phantom/phantom_special_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function phantom_ex_counter_recast:PlayEffectsOnCast()
	EmitSoundOn("Hero_PhantomAssassin.Dagger.Cast", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(phantom_ex_counter_recast)