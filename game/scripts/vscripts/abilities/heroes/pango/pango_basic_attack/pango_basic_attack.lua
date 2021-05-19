pango_basic_attack = class({})
LinkLuaModifier("modifier_pango_basic_attack_stacks", "abilities/heroes/pango/pango_basic_attack/modifier_pango_basic_attack_stacks", LUA_MODIFIER_MOTION_NONE)

function pango_basic_attack:GetCastPoint()
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
	end
end

function pango_basic_attack:GetCooldown(iLevel)
	if IsServer() then
        local attacks_per_second = self:GetCaster():GetAttacksPerSecond()
        local attack_speed = (1 / attacks_per_second)
		
		return self.BaseClass.GetCooldown(self, self:GetLevel()) + attack_speed
	end
end

function pango_basic_attack:GetCastAnimationCustom()
	if RandomInt(0, 3) == 0 then
		return ACT_DOTA_SPAWN
	else
		return ACT_DOTA_CAST_ABILITY_4_END
	end
end
function pango_basic_attack:GetPlaybackRateOverride() 	
	return 1.2 
end
function pango_basic_attack:GetCastPointSpeed() 		return self:GetSpecialValueFor('cast_point_speed_pct') end

function pango_basic_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = ClampPosition(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), self:GetCastRange(Vector(0,0,0), nil))
	local attack_damage = caster:GetAttackDamage()

	self.radius = self:GetSpecialValueFor("radius")
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
		
		self:TryProc(enemy)
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
			caster:GiveManaAndEnergyPercent(mana_gain_pct, true)
			caster:AddNewModifier(caster, self, "modifier_pango_basic_attack_stacks", {})
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

function pango_basic_attack:TryProc(hTarget)
	local caster = self:GetCaster()
	local stacks = caster:SafeGetModifierStacks("modifier_pango_basic_attack_stacks")
	if stacks == 4 then
		caster:SafeDestroyModifier("modifier_pango_basic_attack_stacks")
		hTarget:AddNewModifier(caster, self, "modifier_generic_silence", { duration = 1.0 })
		hTarget:AddNewModifier(caster, self, "modifier_generic_fading_slow", { 
			duration = 1.0,
			max_slow_pct = 100 
		})
		EmitSoundOn("Hero_Pangolier.LuckyShot.Proc", hTarget)
		
		local damage_table = {
			victim = hTarget,
			attacker = caster,
			damage = 8,
			damage_type = DAMAGE_TYPE_PHYSICAL,
		}
		ApplyDamage(damage_table)
	end

end

function pango_basic_attack:PlayEffectsOnFinish(vDirection)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()

	EFX('particles/juggernaut/juggernaut_basic_attack_parent.vpcf', PATTACH_WORLDORIGIN, nil, {
		cp0 = origin,
		cp0f = vDirection,
		cp3 = Vector(self.radius, 0, 0),
		release = true,
	})
	EFX('particles/juggernaut/juggernaut_basic_attack_dust.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetCaster(), {
		release = true,
	})
end

function pango_basic_attack:PlayEffectsOnImpact(hTarget)
	EFX('particles/juggernaut/juggernaut_basic_attack_impact.vpcf', PATTACH_ABSORIGIN, hTarget, {
		release = true
	})

	EmitSoundOn("Hero_Pangolier.Attack.Impact", hTarget)
end

function pango_basic_attack:PlayEffectsOnMiss(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_Pangolier.PreAttack", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(pango_basic_attack)