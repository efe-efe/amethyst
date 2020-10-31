puck_basic_attack = class({})
puck_ex_basic_attack = class({})
LinkLuaModifier("modifier_puck_basic_attack_cooldown", "abilities/heroes/puck/puck_basic_attack/modifier_puck_basic_attack_cooldown", LUA_MODIFIER_MOTION_NONE)

function puck_basic_attack:GetCastPoint()
	if IsServer() then
		return self.BaseClass.GetCastPoint(self) + self:GetCaster():GetAttackAnimationPoint()
	end
end

function puck_basic_attack:GetCooldown(iLevel)
	if IsServer() then
        local attacks_per_second = self:GetCaster():GetAttacksPerSecond()
        local attack_speed = (1 / attacks_per_second)
		
		return self.BaseClass.GetCooldown(self, self:GetLevel()) + attack_speed
	end
end

function puck_basic_attack:GetCastAnimationCustom()	    return ACT_DOTA_ATTACK end
function puck_basic_attack:GetPlaybackRateOverride() 	return 1.0 end
function puck_basic_attack:GetCastPointSpeed() 		    return 10 end

function puck_basic_attack:GetIntrinsicModifierName()
	return "modifier_puck_basic_attack_cooldown"
end

function puck_basic_attack:OnSpellStart()
	self:LaunchProjectile(self:GetCaster():GetOrigin(), self:GetCursorPosition())
end

function puck_basic_attack:LaunchProjectile(origin, point)
	local caster = self:GetCaster()

	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()

    local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
    local fading_slow_duration = self:GetSpecialValueFor("fading_slow_duration")
    local fading_slow_pct = self:GetSpecialValueFor("fading_slow_pct")

	local is_charged = caster:FindModifierByName("modifier_puck_basic_attack_cooldown"):IsCooldownReady()
	
	local projectile_particle = "particles/puck/puck_base_attack.vpcf"

	if is_charged then
		projectile_particle = "particles/puck/puck_base_attack_alternative.vpcf"
	end

	local damage = caster:GetAverageTrueAttackDamage(caster)
	local projectile = {
		EffectName = projectile_particle,
		vSpawnOrigin = origin + Vector(projectile_direction.x * 45, projectile_direction.y * 45, 96),
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

			if is_charged then
				unit:AddNewModifier(_self.Source, nil, "modifier_generic_fading_slow", { duration = fading_slow_duration, max_slow_pct = fading_slow_pct })
			end

			if _self.Source == caster and not unit:IsObstacle() then
				caster:GiveManaPercent(mana_gain_pct, unit)
			end

			if _self.Source.OnBasicAttackImpact then
				_self.Source:OnBasicAttackImpact(unit)
			end
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos, is_charged)
		end,
	}

	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast(is_charged)
end

function puck_basic_attack:PlayEffectsOnCast(isCharged)
	EmitSoundOn("Hero_Puck.Attack", self:GetCaster())
	if isCharged then
		EmitSoundOn("Hero_Oracle.FortunesEnd.Attack", self:GetCaster())
	end
end

function puck_basic_attack:PlayEffectsOnFinish(pos, is_charged)
	local caster = self:GetCaster()

	EmitSoundOnLocationWithCaster(pos, "Hero_Puck.ProjectileImpact", caster)

	local particle_cast = "particles/puck/puck_base_attack_explosion.vpcf"
	if is_charged then
		particle_cast = "particles/puck/puck_base_attack_alternative_explosion.vpcf"
	end
	
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function puck_ex_basic_attack:GetCastAnimationCustom()	    return ACT_DOTA_CAST_ABILITY_2 end
function puck_ex_basic_attack:GetPlaybackRateOverride() 	return 1.0 end
function puck_ex_basic_attack:GetCastPointSpeed() 		    return 100 end
function puck_ex_basic_attack:OnSpellStart()
	self:GetCaster():FindModifierByName("modifier_puck_basic_attack_cooldown"):Replenish()

	EFX("particles/puck/puck_ex_base_attack.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster(), {
		release = true
	})

	EmitSoundOn('Hero_Puck.EtherealJaunt', self:GetCaster())
	EmitSoundOn('Hero_Oracle.FatesEdict.Cast', self:GetCaster())
end


if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(puck_basic_attack)
Abilities.Castpoint(puck_ex_basic_attack)

