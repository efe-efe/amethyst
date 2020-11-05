modifier_storm_extra_displacement = class({})

function modifier_storm_extra_displacement:OnCreated(params)
	if IsServer() then
		self.parent = self:GetParent()
		self.origin = self.parent:GetAbsOrigin()
		self.radius = self:GetAbility():GetSpecialValueFor('radius')
		self.fading_slow_duration = self:GetAbility():GetSpecialValueFor("fading_slow_duration")
		self.fading_slow_pct = self:GetAbility():GetSpecialValueFor("fading_slow_pct")
	
		self.damage_table = {
			attacker = self:GetCaster(),
			damage = self:GetAbility():GetSpecialValueFor("ability_damage"),
			damage_type = DAMAGE_TYPE_PURE,
		}

		self.damage_table_aoe = {
			attacker = self:GetCaster(),
			damage = self:GetAbility():GetSpecialValueFor("aoe_damage"),
			damage_type = DAMAGE_TYPE_PURE,
		}

		self:PlayEffectsOnCreated()
	end
end

function modifier_storm_extra_displacement:OnCollide(params)
	if IsServer() then
		if params.type == UNIT_COLLISION then
			local target = nil

			for _,unit in pairs(params.units) do
				if not self.parent:IsAlly(unit) and not unit:HasModifier('modifier_storm_extra') then
					target = unit
					break
				end
			end

			if target then
				self.damage_table.victim = target
				ApplyDamage(self.damage_table)
				
				target:AddNewModifier(
					self:GetCaster(), -- player source
					self:GetAbility(), -- ability source
					"modifier_storm_extra", -- modifier name
					{ duration = 1.0 } -- kv
				)
			end
		end
	end
end

function modifier_storm_extra_displacement:OnDestroy()
	if IsServer() then
		local enemies = self:GetCaster():FindUnitsInRadius(
			self.parent:GetAbsOrigin(), 
			self.radius, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, 
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER
		)

		for _,enemy in pairs(enemies) do
			enemy:AddNewModifier(
				self:GetCaster(), -- player source
				self:GetAbility(), -- ability source
				"modifier_generic_fading_slow", -- modifier name
				{ duration = self.fading_slow_duration, max_slow_pct = self.fading_slow_pct } -- kv
			)
			
			self.damage_table_aoe.victim = enemy
			ApplyDamage(self.damage_table_aoe)
		end
		
		CreateRadiusMarker(self.parent, self.parent:GetAbsOrigin(), self.radius, RADIUS_SCOPE_PUBLIC, 0.1)
		ScreenShake(self.parent:GetAbsOrigin(), 100, 300, 0.45, 1000, 0, true)
		StopSoundOn("Hero_StormSpirit.BallLightning.Loop", self.parent)
		self:PlayEffectsOnDestroy()

		self:GetAbility():StartCooldown(self:GetAbility():GetCooldown(self:GetAbility():GetLevel()))
	end
end

function modifier_storm_extra_displacement:GetEffectName()
	return "particles/units/heroes/hero_stormspirit/stormspirit_ball_lightning.vpcf"
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
    ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(effect_cast, 1, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(effect_cast, 2, self:GetParent():GetAbsOrigin())
end

function modifier_storm_extra_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end

function modifier_storm_extra_displacement:CheckState()
	return { [MODIFIER_STATE_ROOTED] = true }
end

function modifier_storm_extra_displacement:GetOverrideAnimation() 		return ACT_DOTA_OVERRIDE_ABILITY_4 end
function modifier_storm_extra_displacement:GetIsCommandRestricted()		return false end
if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_storm_extra_displacement)
Modifiers.Animation(modifier_storm_extra_displacement)