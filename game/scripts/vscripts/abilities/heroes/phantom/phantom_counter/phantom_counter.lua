phantom_counter = class({})
phantom_ex_counter = class({})
phantom_ex_counter_recast = class({})

LinkLuaModifier("modifier_phantom_counter_banish", "abilities/heroes/phantom/phantom_counter/modifier_phantom_counter_banish", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_counter_countering", "abilities/heroes/phantom/phantom_counter/modifier_phantom_counter_countering", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_counter", "abilities/heroes/phantom/phantom_counter/modifier_phantom_counter", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_ex_counter_recast", "abilities/heroes/phantom/phantom_counter/modifier_phantom_ex_counter_recast", LUA_MODIFIER_MOTION_NONE)

function phantom_counter:OnSpellStart()
    local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("counter_duration")

    caster:AddNewModifier(
		caster,
		self,
        "modifier_phantom_counter_countering", 
		{ duration = duration }
   )
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
	local point = self:GetCursorPosition()
    local origin = caster:GetAbsOrigin()

	local ability = caster:FindAbilityByName('phantom_ex_counter')
	local sleep_duration = ability:GetSpecialValueFor("sleep_duration")
	local damage = ability:GetSpecialValueFor("ability_damage")

	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local projectile = {
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
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
			}
			ApplyDamage(damage_table)

			if _self.Source == caster then
				if not unit:IsObstacle() then
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

	Projectiles:CreateProjectile(projectile)
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
Abilities.Tie(phantom_counter, 'phantom_ex_counter')
Abilities.Tie(phantom_ex_counter, 'phantom_counter')