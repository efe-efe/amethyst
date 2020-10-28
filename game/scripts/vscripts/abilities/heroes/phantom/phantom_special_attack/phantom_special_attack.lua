
phantom_special_attack = class({})
phantom_ex_special_attack = class({})

LinkLuaModifier("modifier_phantom_strike_stack", "abilities/heroes/phantom/phantom_shared_modifiers/modifier_phantom_strike_stack", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_fading_slow", "abilities/generic/modifier_generic_fading_slow", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_special_attack_charges", "abilities/heroes/phantom/phantom_special_attack/modifier_phantom_special_attack_charges", LUA_MODIFIER_MOTION_NONE)

function phantom_special_attack:GetIntrinsicModifierName()
	return "modifier_phantom_special_attack_charges"
end

function phantom_special_attack:GetCastAnimationCustom()		return ACT_DOTA_TELEPORT_END end 
function phantom_special_attack:GetPlaybackRateOverride() 		return 2.0 end
function phantom_special_attack:GetCastPointSpeed() 			return 80 end
function phantom_special_attack:GetFadeGestureOnCast()			return false end

function phantom_special_attack:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetAbsOrigin()
	local damage = self:GetSpecialValueFor("ability_damage")

	local fading_slow_duration = self:GetSpecialValueFor("fading_slow_duration")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local fading_slow_pct = self:GetSpecialValueFor("fading_slow_pct")

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
				caster:GiveManaPercent(mana_gain_pct, unit)

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
				"modifier_generic_fading_slow", -- modifier name
				{ duration = fading_slow_duration, max_slow_pct = fading_slow_pct } -- kv
			)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	Projectiles:CreateProjectile(projectile)
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