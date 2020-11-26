storm_basic_attack = class({})
LinkLuaModifier("modifier_storm_basic_attack_cooldown", "abilities/heroes/storm/storm_basic_attack/modifier_storm_basic_attack_cooldown", LUA_MODIFIER_MOTION_NONE)

function storm_basic_attack:GetCastPoint()
	if IsServer() then
		return self.BaseClass.GetCastPoint(self) + self:GetCaster():GetAttackAnimationPoint()
	end
end

function storm_basic_attack:GetCooldown(iLevel)
	if IsServer() then
        local attacks_per_second = self:GetCaster():GetAttacksPerSecond()
        local attack_speed = (1 / attacks_per_second)
		
		return self.BaseClass.GetCooldown(self, self:GetLevel()) + attack_speed
	end
end

function storm_basic_attack:GetCastAnimationCustom()	    return ACT_DOTA_ATTACK end
function storm_basic_attack:GetPlaybackRateOverride() 		return 1.5 end
function storm_basic_attack:GetCastPointSpeed() 		    return 10 end
function storm_basic_attack:GetAnimationTranslate() 		return "overload" end

function storm_basic_attack:GetIntrinsicModifierName()
	return "modifier_storm_basic_attack_cooldown"
end

function storm_basic_attack:OnSpellStart()
	self:LaunchProjectile(self:GetCaster():GetOrigin(), self:GetCursorPosition())
end

function storm_basic_attack:LaunchProjectile(origin, point)
	local caster = self:GetCaster()

	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()

    local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local radius = self:GetSpecialValueFor("radius")
	local fading_slow_duration = self:GetSpecialValueFor("fading_slow_duration")
	local fading_slow_pct = self:GetSpecialValueFor("fading_slow_pct")
	
	local is_charged = caster:FindModifierByName("modifier_storm_basic_attack_cooldown"):IsCooldownReady()
	
	local projectile_particle = "particles/storm/storm_basic_attack.vpcf"

	if is_charged then
		projectile_particle = "particles/storm/storm_basic_attack_charged.vpcf"
	end

	local damage = caster:GetAverageTrueAttackDamage(caster)
	local damage_table_aoe = {
		damage = self:GetSpecialValueFor("aoe_damage"),
		damage_type = DAMAGE_TYPE_PURE,
	}

	local projectile = {
		EffectName = projectile_particle,
		vSpawnOrigin = origin + Vector(0, 0, 96),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fStartRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				ability = self
			}
			ApplyDamage(damage_table)

			if _self.Source == caster and not unit:IsObstacle() then
				caster:GiveManaPercent(mana_gain_pct, unit)

				if caster:HasModifier('modifier_storm_ultimate') then
					local extra_mana_pct = mana_gain_pct * (caster:FindModifierByName('modifier_storm_ultimate'):GetManaMultiplier() - 1)
					caster:GiveManaPercentAndInform(extra_mana_pct, unit)
				end
			end

			if _self.Source.OnBasicAttackImpact then
				_self.Source:OnBasicAttackImpact(unit)
			end
		end,
		OnFinish = function(_self, pos)
			if is_charged then
				local enemies = _self.Source:FindUnitsInRadius(
					pos, 
					radius, 
					DOTA_UNIT_TARGET_TEAM_ENEMY, 
					DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER
				)

				damage_table_aoe.attacker = _self.Source
				
				for _,enemy in pairs(enemies) do
					enemy:AddNewModifier(
						_self.Source, -- player source
						self, -- ability source
						"modifier_generic_fading_slow", -- modifier name
						{ duration = fading_slow_duration, max_slow_pct = fading_slow_pct } -- kv
					)
					
					damage_table_aoe.victim = enemy
					ApplyDamage(damage_table_aoe)
				end

				local groundPosition = GetGroundPosition(pos, _self.Source)

				CreateRadiusMarker(_self.Source, groundPosition, radius, RADIUS_SCOPE_PUBLIC, 0.1)
				ScreenShake(groundPosition, 100, 300, 0.45, 1000, 0, true)
			end
			self:PlayEffectsOnFinish(pos, is_charged)
		end,
	}

	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast(is_charged)
end

function storm_basic_attack:PlayEffectsOnCast(isCharged)
	EmitSoundOn("Hero_StormSpirit.Attack", self:GetCaster())
	if isCharged then
		EmitSoundOn("Hero_StormSpirit.StaticRemnantExplode", self:GetCaster())
	end
end

function storm_basic_attack:PlayEffectsOnFinish(pos, is_charged)
	local caster = self:GetCaster()

	EmitSoundOnLocationWithCaster(pos, "Hero_StormSpirit.ProjectileImpact", caster)

	local particle_cast = "particles/units/heroes/hero_stormspirit/stormspirit_base_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	if is_charged then
		EFX("particles/units/heroes/hero_void_spirit/voidspirit_overload_discharge.vpcf", PATTACH_WORLDORIGIN, caster, {
			cp0 = pos,
			release = true,
		})
	end
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(storm_basic_attack)

