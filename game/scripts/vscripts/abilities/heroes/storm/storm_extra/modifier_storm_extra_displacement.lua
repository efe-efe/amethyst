modifier_storm_extra_displacement = class({})

function modifier_storm_extra_displacement:OnCreated(params)
	if IsServer() then
		self:SetStackCount(params.level)
		self.parent = self:GetParent()
		self.origin = self.parent:GetAbsOrigin()
		self.radius = self:GetAbility():GetSpecialValueFor('radius')
		self.fading_slow_duration = self:GetAbility():GetSpecialValueFor("fading_slow_duration")
		self.fading_slow_pct = self:GetAbility():GetSpecialValueFor("fading_slow_pct")
	
		local storm_ex_basic_attack = self.parent:FindAbilityByName('storm_ex_basic_attack')
		local damage_per_level = storm_ex_basic_attack:GetSpecialValueFor('damage_per_level')
		self.stun_duration = storm_ex_basic_attack:GetSpecialValueFor('stun_duration')
		self.heal_multiplier = storm_ex_basic_attack:GetSpecialValueFor("heal_multiplier")
		
		local extra_damage = damage_per_level * self:GetStackCount()
		self.damage = self:GetAbility():GetSpecialValueFor("ability_damage") + extra_damage
		self.damage_aoe = self:GetAbility():GetSpecialValueFor("aoe_damage") + extra_damage
		
		self.damage_table = {
			attacker = self.parent,
			damage_type = DAMAGE_TYPE_PURE,
		}

		self:PlayEffectsOnCreated()
	end
end

function modifier_storm_extra_displacement:OnCollide(params)
	if IsServer() then
		if params.type ~= UNIT_COLLISION then
			return
		end
		for _,unit in pairs(params.units) do
			if unit:HasModifier('modifier_storm_extra') or unit == self.parent then
				return
			end

			unit:AddNewModifier(
				self.parent,
				self:GetAbility(),
				"modifier_storm_extra",
				{ duration = 0.35 }
			)

			self:OnImpactEnemyCollision(unit)
		end
	end
end

function modifier_storm_extra_displacement:OnImpactEnemy(hTarget, iDamage)
	if self:GetStackCount() >= 1 then
		if CustomEntitiesLegacy:ProvidesMana(hTarget) then
			self.parent:Heal(self.heal_multiplier * iDamage, self.parent)
		end
	end

	if self:GetStackCount() == 2 then
		hTarget:AddNewModifier(
			self.parent,
			self:GetAbility(),
			"modifier_generic_stunned",
			{ duration = self.stun_duration }
		)
	end

	self.damage_table.victim = hTarget
	self.damage_table.damage = iDamage
	ApplyDamage(self.damage_table)

	if not CustomEntitiesLegacy:IsObstacle(hTarget) and self:GetAbility():GetLevel() >= 2 then
		self.parent:FindAbilityByName("storm_second_attack"):EndCooldown()
	end
end

function modifier_storm_extra_displacement:OnImpactEnemyAOE(hTarget)
	self:OnImpactEnemy(hTarget, self.damage_aoe)
	hTarget:AddNewModifier(
		self.parent,
		self:GetAbility(),
		"modifier_generic_fading_slow",
		{ duration = self.fading_slow_duration, max_slow_pct = self.fading_slow_pct }
	)
end

function modifier_storm_extra_displacement:OnImpactEnemyCollision(hTarget)
	self:OnImpactEnemy(hTarget, self.damage)
end

function modifier_storm_extra_displacement:OnDestroy()
	if IsServer() then
		local units = CustomEntitiesLegacy:FindUnitsInRadius(
			self.parent,
			self.parent:GetAbsOrigin(), 
			self.radius, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, 
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER
		)

		for _,unit in pairs(units) do
			self:OnImpactEnemyAOE(unit)
		end
		
		CreateRadiusMarker(self.parent, self.parent:GetAbsOrigin(), self.radius, RADIUS_SCOPE_PUBLIC, 0.1)
		ScreenShake(self.parent:GetAbsOrigin(), 100, 300, 0.45, 1000, 0, true)
		StopSoundOn("Hero_StormSpirit.BallLightning.Loop", self.parent)
		self:PlayEffectsOnDestroy()

		if self.parent:HasModifier('modifier_storm_ex_basic_attack') then
			local modifier = self.parent:FindModifierByName('modifier_storm_ex_basic_attack')
			modifier:SetStackCount(modifier:GetStackCount() - 10)
		end
		
		if self:GetAbility():GetLevel() >= 2 then
			
		end
	end
end

function modifier_storm_extra_displacement:GetEffectName()
	local stacks = self:GetStackCount()
	if stacks == 0 then
		return "particles/units/heroes/hero_stormspirit/stormspirit_ball_lightning.vpcf"
	elseif stacks == 1 then
		return 'particles/econ/items/storm_spirit/storm_spirit_orchid_hat_retro/stormspirit_orchid_retro_ball_lightning.vpcf'
	else 
		return 'particles/storm/storm_ultimate_level_two.vpcf'
	end
end

function modifier_storm_extra_displacement:GetEffectAttachType()
	return PATTACH_ROOTBONE_FOLLOW
end

function modifier_storm_extra_displacement:PlayEffectsOnCreated()
	EmitSoundOn("Hero_StormSpirit.BallLightning", self.parent)
	EmitSoundOn("Hero_StormSpirit.BallLightning.Loop", self.parent)
end

function modifier_storm_extra_displacement:PlayEffectsOnDestroy()
    local particle_cast = "particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, self.parent:GetAbsOrigin())
    ParticleManager:SetParticleControl(effect_cast, 1, self.parent:GetAbsOrigin())
    ParticleManager:SetParticleControl(effect_cast, 2, self.parent:GetAbsOrigin())
end

function modifier_storm_extra_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end

function modifier_storm_extra_displacement:CheckState()
	return { [MODIFIER_STATE_ROOTED] = true }
end

function modifier_storm_extra_displacement:GetCollisionTeamFilter()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_storm_extra_displacement:GetOverrideAnimation() 		return ACT_DOTA_OVERRIDE_ABILITY_4 end
function modifier_storm_extra_displacement:GetIsCommandRestricted()		return false end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_storm_extra_displacement)
Modifiers.Animation(modifier_storm_extra_displacement)