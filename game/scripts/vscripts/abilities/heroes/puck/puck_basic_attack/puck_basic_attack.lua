puck_basic_attack = class({})
puck_ex_basic_attack = class({})
puck_basic_attack_related = class({})

LinkLuaModifier("modifier_puck_basic_attack_cooldown", "abilities/heroes/puck/puck_basic_attack/modifier_puck_basic_attack_cooldown", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_basic_attack_buff", "abilities/heroes/puck/puck_basic_attack/modifier_puck_basic_attack_cooldown", LUA_MODIFIER_MOTION_NONE)

LinkLuaModifier("modifier_puck_fairy_dust", "abilities/heroes/puck/modifier_puck_fairy_dust", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_ex_basic_attack", "abilities/heroes/puck/puck_basic_attack/modifier_puck_ex_basic_attack", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_basic_attack_thinker", "abilities/heroes/puck/puck_basic_attack/modifier_puck_basic_attack_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_ex_basic_attack_shield", "abilities/heroes/puck/puck_basic_attack/modifier_puck_ex_basic_attack_shield", LUA_MODIFIER_MOTION_NONE)



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
	self:LaunchProjectile(self:GetCaster():GetOrigin(), CustomAbilitiesLegacy:GetCursorPosition(self))
end

function puck_basic_attack:LaunchProjectile(origin, point)
	local caster = self:GetCaster()

	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = Direction2D(origin, point)

    local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
    local fairy_dust_duration = self:GetSpecialValueFor("fairy_dust_duration")
    local fairy_dust_slow_pct = self:GetSpecialValueFor("fairy_dust_slow_pct")

	local is_charged = caster:FindModifierByName("modifier_puck_basic_attack_cooldown"):IsCooldownReady()
	
	local projectile_particle = "particles/puck/puck_base_attack.vpcf"

	if is_charged then
		projectile_particle = "particles/puck/puck_base_attack_alternative.vpcf"
	end

	CustomEntitiesLegacy:ProjectileAttack(caster, {
		bIsBasicAttack = true,
		tProjectile = {
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
			fGroundOffset = 0,
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(_self.Source, unit) end,
			OnUnitHit = function(_self, unit)
				CustomEntitiesLegacy:AttackWithBaseDamage(caster, {
					hTarget = unit,
					hAbility = self,
				})
				
				if is_charged then
					unit:AddNewModifier(_self.Source, nil, "modifier_puck_fairy_dust", { duration = fairy_dust_duration, slow_pct = fairy_dust_slow_pct })
				end

				if _self.Source == caster and not CustomEntitiesLegacy:IsObstacle(unit) then
					if CustomEntitiesLegacy:ProvidesMana(unit) then
						CustomEntitiesLegacy:GiveManaAndEnergyPercent(caster, mana_gain_pct, true)
					end
					if self:GetLevel() >=2 then
						caster:FindModifierByName("modifier_puck_basic_attack_cooldown"):Replenish()
					end
				end
			end,
			OnFinish = function(_self, pos)
				self:PlayEffectsOnFinish(pos, is_charged)
			end,
		}
	})

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

function puck_basic_attack:OnUpgrade()
	local related = self:GetCaster():FindAbilityByName('puck_basic_attack_related')
	
	if self:GetLevel() > related:GetLevel() then
		related:UpgradeAbility(true)
	end
end

puck_basic_attack_related.GetCooldown = puck_basic_attack.GetCooldown
puck_basic_attack_related.PlayEffectsOnCast = puck_basic_attack.PlayEffectsOnCast

function puck_basic_attack_related:GetCastAnimationCustom()	    return ACT_DOTA_CAST_ABILITY_2 end
function puck_basic_attack_related:GetPlaybackRateOverride() 	return 1.0 end
function puck_basic_attack_related:GetCastPointSpeed() 		    return 10 end

function puck_basic_attack_related:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(self), self:GetCastRange(Vector(0,0,0), nil), nil)
	local charged = caster:FindModifierByName("modifier_puck_basic_attack_cooldown"):IsCooldownReady() and 1 or 0
	
	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_puck_basic_attack_thinker", --modifierName
		{
			charged = charged
		},
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
	
    EFX('particles/econ/items/invoker/invoker_ti7/invoker_ti7_alacrity_cast.vpcf', PATTACH_CUSTOMORIGIN, caster, {
		cp0 = {
			ent = caster,
			point = 'attach_hitloc'
		},
		cp1 = point + Vector(0, 0, 1000),
		cp2 = point + Vector(0, 0, 1000),
        release = true,
	})
	self:PlayEffectsOnCast(charged == 1)
end

function puck_basic_attack_related:OnUpgrade()
	local related = self:GetCaster():FindAbilityByName('puck_basic_attack')
	
	if self:GetLevel() > related:GetLevel() then
		related:UpgradeAbility(true)
	end
end

function puck_ex_basic_attack:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	caster:AddNewModifier(caster, self, "modifier_puck_ex_basic_attack", { duration = duration })

	EFX("particles/puck/puck_ex_base_attack.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster, {
		release = true
	})
	
    EmitSoundOn("puck_puck_laugh_01", caster)
	EmitSoundOn('Hero_Puck.EtherealJaunt', caster)
	EmitSoundOn("Hero_Puck.Phase_Shift", caster)
end


if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(puck_basic_attack)
Abilities.Castpoint(puck_basic_attack_related)

