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
	local point = ClampPosition(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), self:GetCastRange(Vector(0,0,0), nil))

	self.radius = self:GetSpecialValueFor("radius")
	local cooldown_reduction = self:GetSpecialValueFor("cooldown_reduction")
	local cooldown_reduction_counter = self:GetSpecialValueFor("cooldown_reduction_counter")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local direction = Direction2D(origin, point)
	local modifier = CustomEntities:SafeGetModifier(caster, "modifier_juggernaut_ex_counter")

	if modifier then
		local color = Vector(0, 255, 0)
		self:PlayEffectsOnFinish(direction, color)
	else
		self:PlayEffectsOnFinish(direction)
	end
	
	CustomEntities:MeeleAttack(caster, {
		vDirection = direction,
		vOrigin = origin, 
		fRadius = self.radius,
		bIsBasicAttack = true,
		iMaxTargets = 1,
		Callback = function(hTarget)
			CustomEntities:AttackWithBaseDamage(caster, {
				hTarget = hTarget,
				hAbility = self,
			})

			if not CustomEntities:IsObstacle(hTarget) then
				if CustomEntities:ProvidesMana(hTarget) then
					CustomEntities:GiveManaAndEnergyPercent(caster, mana_gain_pct, true)
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
	local ability_cd = ability:GetCooldownTimeRemaining()
	local new_cd = ability_cd - iCooldownReduction

	if (new_cd) < 0 then 
		ability:EndCooldown()
	else
		ability:EndCooldown()
		ability:StartCooldown(new_cd)
	end
end

function juggernaut_basic_attack:PlayEffectsOnFinish(vDirection, vColor)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()

	local efx = EFX('particles/juggernaut/juggernaut_basic_attack_parent.vpcf', PATTACH_WORLDORIGIN, nil, {
		cp0 = origin,
		cp0f = vDirection,
		cp3 = Vector(self.radius, 0, 0),
	})

	if vColor then
		ParticleManager:SetParticleControl(efx, 60, vColor)
		ParticleManager:SetParticleControl(efx, 61, Vector(1, 0, 0))
	end

	ParticleManager:ReleaseParticleIndex(efx)

	EFX('particles/juggernaut/juggernaut_basic_attack_dust.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetCaster(), {
		release = true,
	})
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