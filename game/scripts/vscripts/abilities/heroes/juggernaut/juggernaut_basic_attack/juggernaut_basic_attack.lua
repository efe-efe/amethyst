juggernaut_basic_attack = class({})
LinkLuaModifier("modifier_juggernaut_basic_attack_stacks", "abilities/heroes/juggernaut/juggernaut_basic_attack/modifier_juggernaut_basic_attack_stacks", LUA_MODIFIER_MOTION_NONE)

function juggernaut_basic_attack:GetCastPoint()
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
	end
end

function juggernaut_basic_attack:GetCooldown(iLevel)
	if IsServer() then
        local attacks_per_second = self:GetCaster():GetAttacksPerSecond()
        local attack_speed = (1 / attacks_per_second)
		
		return self.BaseClass.GetCooldown(self, self:GetLevel()) + attack_speed
	end
end

function juggernaut_basic_attack:GetCastAnimationCustom()	return ACT_DOTA_ATTACK_EVENT end
function juggernaut_basic_attack:GetPlaybackRateOverride() 	return 1.8 end
function juggernaut_basic_attack:GetCastPointSpeed() 		return self:GetSpecialValueFor('cast_point_speed_pct') end

function juggernaut_basic_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = ClampPosition(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), self:GetCastRange(Vector(0,0,0), nil))
	local attack_damage = caster:GetAttackDamage()

	self.radius = self:GetSpecialValueFor("radius")
	local cooldown_reduction = self:GetSpecialValueFor("cooldown_reduction")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()

	local enemies = caster:FindUnitsInCone(
		direction, 
		0, 
		origin, 
		self.radius, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST
	)

	local should_shake = false

	for _,enemy in pairs(enemies) do 
		if enemy:IsRealHero() then
			should_shake = true
		end

		self:PlayEffectsOnImpact(enemy)

		local damage_table = {
			victim = enemy,
			attacker = caster,
			damage = attack_damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			activate_counters = 1,
		}
		ApplyDamage(damage_table)

		if not enemy:IsObstacle() then 
			caster:GiveManaPercent(mana_gain_pct, enemy)
			-- Add modifier
			caster:AddNewModifier(
				caster, -- player source
				self, -- ability source
				"modifier_juggernaut_basic_attack_stacks", -- modifier name
				{} -- kv
			)

			-- Reduce the cd of the second attack by 1
			local second_attack = caster:FindAbilityByName("juggernaut_second_attack")
			local second_attack_cd = second_attack:GetCooldownTimeRemaining()
			local new_cd = second_attack_cd - cooldown_reduction

			if (new_cd) < 0 then 
				second_attack:EndCooldown()
			else
				second_attack:EndCooldown()
				second_attack:StartCooldown(new_cd)
			end
		end

		if caster.OnBasicAttackImpact then
			caster:OnBasicAttackImpact(enemy)
		end

		break
	end

	if should_shake then
		ScreenShake(point, 100, 100, 0.45, 1000, 0, true)
	end

	self:PlayEffectsOnMiss(point)
	self:PlayEffectsOnFinish(direction)
end

function juggernaut_basic_attack:PlayEffectsOnFinish(vDirection)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()

	EFX('particles/juggernaut/juggernaut_basic_attack_parent.vpcf', PATTACH_WORLDORIGIN, nil, {
		cp0 = origin,
		cp0f = vDirection,
		cp3 = Vector(self.radius, 0, 0),
		release = true,
	})

	particle_cast = "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_ti8_sword_crit_golden.vpcf"
	effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, caster)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function juggernaut_basic_attack:PlayEffectsOnImpact(hTarget)
	EFX('particles/juggernaut/juggernaut_basic_attack_impact.vpcf', PATTACH_ABSORIGIN, hTarget, {
		release = true
	})

	EmitSoundOn("Hero_Juggernaut.Attack", hTarget)
end

function juggernaut_basic_attack:PlayEffectsOnMiss(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_Juggernaut.PreAttack", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(juggernaut_basic_attack)