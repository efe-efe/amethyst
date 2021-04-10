spectre_basic_attack = class({})
LinkLuaModifier("modifier_spectre_desolate_custom", "abilities/heroes/spectre/spectre_shared_modifiers/modifier_spectre_desolate_custom/modifier_spectre_desolate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_basic_attack_cooldown", "abilities/heroes/spectre/spectre_basic_attack/modifier_spectre_basic_attack_cooldown", LUA_MODIFIER_MOTION_NONE)

function spectre_basic_attack:GetIntrinsicModifierName()
	return "modifier_spectre_basic_attack_cooldown"
end

function spectre_basic_attack:GetCastPoint()
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
	end
end

function spectre_basic_attack:GetCooldown(iLevel)
	if IsServer() then
        local attacks_per_second = self:GetCaster():GetAttacksPerSecond()
        local attack_speed = (1 / attacks_per_second)
		
		return self.BaseClass.GetCooldown(self, self:GetLevel()) + attack_speed
	end
end

function spectre_basic_attack:GetCastAnimationCustom()	return ACT_DOTA_ATTACK end
function spectre_basic_attack:GetPlaybackRateOverride()
	if IsServer() then 
		local slow = self:GetCaster():FindModifierByName("modifier_spectre_basic_attack_cooldown"):IsCooldownReady() and 0.3 or 0.0 

		return 1.1 - slow
	end
end
function spectre_basic_attack:GetCastPointSpeed() 		return self:GetSpecialValueFor('cast_point_speed_pct') end

function spectre_basic_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local cast_range = self:GetCastRange(Vector(0,0,0), nil)
	local point = ClampPosition(origin, CustomAbilities:GetCursorPosition(self), cast_range, cast_range)
	local radius = self:GetSpecialValueFor("radius")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local direction = (Vector(point.x - origin.x, point.y - origin.y, 0)):Normalized()
	local max_targets = 1
	local is_charged = caster:FindModifierByName("modifier_spectre_basic_attack_cooldown"):IsCooldownReady()

	if is_charged then
		radius = radius + 50
		max_targets = -1
		ScreenShake(point, 100, 100, 0.45, 1000, 0, true)
	end

	CustomEntities:MeeleAttack(caster, {
		vDirection = direction,
		vOrigin = origin, 
		fRadius = radius,
		iMaxTargets = max_targets,
		bIsBasicAttack = true,
		bShakeOnHeroes = not is_charged,
		Callback = function(hTarget)
			CustomEntities:AttackWithBaseDamage(caster, {
				hTarget = hTarget,
				hAbility = self,
			})

			if CustomEntities:ProvidesMana(hTarget) then
				CustomEntities:GiveManaAndEnergyPercent(caster, mana_gain_pct, true)
			end

			self:PlayEffectsOnImpact(hTarget, hTarget:GetAbsOrigin(), is_charged)
		end
	})

	self:PlayEffectsOnFinish(direction, is_charged, radius)
	self:PlayEffectsOnCast(is_charged)
end

function spectre_basic_attack:PlayEffectsOnFinish(vDirection, bCharged, nRadius)
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local color = Vector(107, 14, 103)

	local efx = EFX('particles/spectre/spectre_basic_attack_parent.vpcf', PATTACH_WORLDORIGIN, nil, {
		cp0 = origin,
		cp0f = vDirection,
		cp3 = Vector(nRadius, 0, 0),
	})

	ParticleManager:SetParticleControl(efx, 60, color)
	ParticleManager:SetParticleControl(efx, 61, Vector(1, 0, 0))

	if bCharged then
		ParticleManager:SetParticleControl(efx, 4, Vector(1, 0, 0))

		local particle_cast = "particles/econ/items/dragon_knight/dk_immortal_dragon/dragon_knight_dragon_tail_dragonform_iron_dragon.vpcf"
		local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster)
		ParticleManager:SetParticleControl(effect_cast, 2, origin)
		ParticleManager:SetParticleControl(effect_cast, 4, origin)
		ParticleManager:ReleaseParticleIndex(effect_cast)

		
		effect_cast = ParticleManager:CreateParticle('particles/spectre/spectre_basic_attack_charged.vpcf', PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(effect_cast, 0, origin)
		ParticleManager:SetParticleControl(effect_cast, 1, Vector(nRadius, nRadius, nRadius))
		ParticleManager:SetParticleControlForward(effect_cast, 0, vDirection)
		ParticleManager:ReleaseParticleIndex(effect_cast)
	end

	ParticleManager:ReleaseParticleIndex(efx)
end

function spectre_basic_attack:PlayEffectsOnCast(bCharged)
	EmitSoundOn("Hero_Spectre.PreAttack", self:GetCaster())

	if bCharged then
		EmitSoundOn('Hero_Sven.Layer.GodsStrength', self:GetCaster())
	end
end

function spectre_basic_attack:PlayEffectsOnImpact(hTarget, vPosition, bCharged)
	if bCharged then
		EmitSoundOn("Hero_BountyHunter.Jinada", hTarget)
		
		local particle_cast = "particles/econ/items/slark/slark_ti6_blade/slark_ti6_blade_essence_shift.vpcf"
		local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, hTarget)
		ParticleManager:ReleaseParticleIndex(effect_cast)
	else
		EmitSoundOn("Hero_Spectre.Attack", hTarget)
		
		EFX('particles/phantom/phantom_basic_attack.vpcf', PATTACH_ABSORIGIN, hTarget, {
			release = true
		})

		local caster = self:GetCaster()
		local offset = 50
		local new_position = caster:GetOrigin() + (vPosition - caster:GetOrigin()):Normalized() * offset
	
		local particle_cast = "particles/units/heroes/hero_spectre/spectre_desolate.vpcf"
		local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, caster)
		ParticleManager:SetParticleControl(effect_cast, 0, vPosition)
		ParticleManager:SetParticleControlForward(effect_cast, 0, (vPosition - caster:GetOrigin()):Normalized())
		ParticleManager:ReleaseParticleIndex(effect_cast)
	end
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(spectre_basic_attack)