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
function juggernaut_basic_attack:GetPlaybackRateOverride() 	return 1.2 end
function juggernaut_basic_attack:GetAnimationTranslate() 	return "odachi" end
function juggernaut_basic_attack:GetCastPointSpeed() 		return self:GetSpecialValueFor('cast_point_speed_pct') end

function juggernaut_basic_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(self), self:GetCastRange(Vector(0,0,0), nil), self:GetCastRange(Vector(0,0,0), nil))

	self.radius = self:GetSpecialValueFor("radius") + CustomEntitiesLegacy:GetMeeleExtraRadius(caster)
	local cooldown_reduction = self:GetSpecialValueFor("cooldown_reduction")
	local cooldown_reduction_counter = self:GetSpecialValueFor("cooldown_reduction_counter")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local direction = Direction2D(origin, point)
	local modifier = CustomEntitiesLegacy:SafeGetModifier(caster, "modifier_juggernaut_ex_counter")

	if modifier then
		local color = Vector(0, 255, 0)
		MeeleEFX(caster, direction, self.radius, color)
	else
		MeeleEFX(caster, direction, self.radius, nil)
	end
	
	CustomEntitiesLegacy:MeeleAttack(caster, {
		vDirection = direction,
		vOrigin = origin, 
		fRadius = self.radius,
		bIsBasicAttack = true,
		iMaxTargets = 1,
		Callback = function(hTarget)
			CustomEntitiesLegacy:AttackWithBaseDamage(caster, {
				hTarget = hTarget,
				hAbility = self,
			})

			if not CustomEntitiesLegacy:IsObstacle(hTarget) then
				if CustomEntitiesLegacy:ProvidesMana(hTarget) then
					CustomEntitiesLegacy:GiveManaAndEnergyPercent(caster, mana_gain_pct, true)
				end

				caster:AddNewModifier(caster, self, "modifier_juggernaut_basic_attack_stacks", {})
	
				self:ReduceCooldown(caster, 'juggernaut_second_attack', cooldown_reduction)
				self:ReduceCooldown(caster, 'juggernaut_ex_second_attack', cooldown_reduction)
	
				if self:GetLevel() >= 2 then
					self:ReduceCooldown(caster, 'juggernaut_counter', cooldown_reduction_counter)
					self:ReduceCooldown(caster, 'juggernaut_ex_counter', cooldown_reduction_counter)
				end
			end
	
			self:PlayEffectsOnImpact(hTarget)
		end
	})

	self:PlayEffectsOnMiss(point)
end

function juggernaut_basic_attack:ReduceCooldown(hCaster, sAbilityName, iCooldownReduction)
	local ability = hCaster:FindAbilityByName(sAbilityName)

	if ability then
		local ability_cd = ability:GetCooldownTimeRemaining()
		local new_cd = ability_cd - iCooldownReduction

		if (new_cd) < 0 then 
			ability:EndCooldown()
		else
			ability:EndCooldown()
			ability:StartCooldown(new_cd)
		end
	end
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