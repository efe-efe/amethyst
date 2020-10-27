modifier_storm_ex_special_attack_displacement = class({})

function modifier_storm_ex_special_attack_displacement:OnCreated(params)
	if IsServer() then
		self.parent = self:GetParent()
		self.origin = self.parent:GetAbsOrigin()
		self.radius = self:GetAbility():GetSpecialValueFor('radius')
		self.heal = self:GetAbility():GetSpecialValueFor('heal')
		self.ally_heal = self:GetAbility():GetSpecialValueFor('ally_heal')
		self:PlayEffectsOnCreated()
	end
end

function modifier_storm_ex_special_attack_displacement:OnCollide(params)
	if IsServer() then
		if params.type == UNIT_COLLISION then
			local target = nil

			for _,unit in pairs(params.units) do
				if not self.parent:IsAlly(unit) and not unit:HasModifier('modifier_storm_ex_special_attack') then
					target = unit
					break
				end
			end

			if target then
				self.parent:Heal(self.heal, self.parent)
				
				target:AddNewModifier(
					self:GetCaster(), -- player source
					self:GetAbility(), -- ability source
					"modifier_storm_ex_special_attack", -- modifier name
					{ duration = 1.0 } -- kv
				)
			end
		end
	end
end

function modifier_storm_ex_special_attack_displacement:OnDestroy()
	if IsServer() then
		local allies = self:GetCaster():FindUnitsInRadius(
			self.parent:GetAbsOrigin(), 
			self.radius, 
			DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER
		)

		for _,ally in pairs(allies) do
			if not ally == self.parent then 
				ally:Heal(self.ally_heal, self.parent)
			end
		end
		
		CreateRadiusMarker(self.parent, self.parent:GetAbsOrigin(), self.radius, RADIUS_SCOPE_PUBLIC, 0.1)
		StopSoundOn("Hero_StormSpirit.BallLightning.Loop", self.parent)
		self:PlayEffectsOnDestroy()

		self:GetAbility():StartCooldown(self:GetAbility():GetCooldown(0))
	end
end

function modifier_storm_ex_special_attack_displacement:GetEffectName()
	return "particles/econ/items/storm_spirit/storm_spirit_orchid_hat_retro/stormspirit_orchid_retro_ball_lightning.vpcf"
end

function modifier_storm_ex_special_attack_displacement:GetEffectAttachType()
	return PATTACH_ROOTBONE_FOLLOW
end

function modifier_storm_ex_special_attack_displacement:PlayEffectsOnCreated()
	EmitSoundOn("Hero_StormSpirit.BallLightning", self.parent)
	EmitSoundOn("Hero_StormSpirit.BallLightning.Loop", self.parent)
end

function modifier_storm_ex_special_attack_displacement:PlayEffectsOnDestroy()
    local particle_cast = "particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(effect_cast, 1, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(effect_cast, 2, self:GetParent():GetAbsOrigin())
end

function modifier_storm_ex_special_attack_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end

function modifier_storm_ex_special_attack_displacement:GetOverrideAnimation() 		return ACT_DOTA_OVERRIDE_ABILITY_4 end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_storm_ex_special_attack_displacement)
Modifiers.Animation(modifier_storm_ex_special_attack_displacement)