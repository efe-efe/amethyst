
phantom_basic_attack_related = class({})
LinkLuaModifier("modifier_phantom_strike_stack", "abilities/heroes/phantom/phantom_shared_modifiers/modifier_phantom_strike_stack", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_fading_slow", "abilities/generic/modifier_generic_fading_slow", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_bleed", "abilities/heroes/phantom/modifier_phantom_bleed", LUA_MODIFIER_MOTION_NONE)


function phantom_basic_attack_related:GetCastPoint()
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
	end
end

function phantom_basic_attack_related:GetCooldown(iLevel)
	if IsServer() then
        local attacks_per_second = self:GetCaster():GetAttacksPerSecond()
        local attack_speed = (1 / attacks_per_second)
		
		return self.BaseClass.GetCooldown(self, self:GetLevel()) + attack_speed
	end
end

function phantom_basic_attack_related:GetCastAnimationCustom()		return ACT_DOTA_TELEPORT_END end
function phantom_basic_attack_related:GetPlaybackRateOverride() 	return 2.0 end
function phantom_basic_attack_related:GetCastPointSpeed() 			return 80 end
function phantom_basic_attack_related:GetFadeGestureOnCast()		return false end

function phantom_basic_attack_related:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()
	local ability = caster:FindAbilityByName("phantom_ex_basic_attack")
	local bleed_duration = ability:GetSpecialValueFor("bleed_duration")
	local damage = ability:GetSpecialValueFor("ability_damage")
	
	local fading_slow_pct = ability:GetSpecialValueFor("fading_slow_pct")
	local fading_slow_duration = ability:GetSpecialValueFor("fading_slow_duration")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")

	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local projectile = {
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
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntities:Allies(_self.Source, unit) end,
		OnUnitHit = function(_self, unit)
			caster:PerformAttack(unit, true, true, true, true, false, false, true)

			if _self.Source == caster then
				if CustomEntities:ProvidesMana(unit) then
					CustomEntities:GiveManaAndEnergyPercent(caster, mana_gain_pct, true)
				end
					
				if _self.Source == caster and not CustomEntities:IsObstacle(unit) then 
					caster:AddNewModifier(
						caster, -- player source
						self, -- ability source
						"modifier_phantom_strike_stack", -- modifier name
						{} -- kv
					)
				end
			end

			unit:AddNewModifier(
				_self.Source,
				self,
				"modifier_generic_fading_slow", -- modifier name
				{ duration = fading_slow_duration, max_slow_pct = fading_slow_pct } -- kv
			)

			if ability:GetLevel() >= 2 then
				unit:AddNewModifier(
					_self.Source,
					ability,
					'modifier_phantom_bleed',
					{ duration = bleed_duration }
				)
			end
		end,
		OnFinish = function(_self, pos)
			if next(_self.rehit) == nil then
				CustomEntities:FakeMissAttack(caster, pos)
			end
			self:PlayEffectsOnFinish(pos)
		end,
	}

	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end


function phantom_basic_attack_related:PlayEffectsOnFinish(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_PhantomAssassin.Dagger.Target", self:GetCaster())

	local particle_cast = "particles/phantom/phantom_special_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function phantom_basic_attack_related:PlayEffectsOnCast()
	EmitSoundOn("Hero_PhantomAssassin.Dagger.Cast", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(phantom_basic_attack_related)