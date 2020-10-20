modifier_mars_mobility_thinker = class({})

function modifier_mars_mobility_thinker:OnCreated(params)
	if IsServer() then
		self.radius = self:GetAbility():GetSpecialValueFor("radius")
		self.damage_table = {
			attacker = self:GetCaster(),
			damage = self:GetAbility():GetSpecialValueFor("ability_damage"),
			damage_type = DAMAGE_TYPE_PURE,
		}
        self:PlayEffects()
        self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_mars_mobility_banish", { duration = self:GetDuration() })
    end
end

function modifier_mars_mobility_thinker:OnDestroy()
	if IsServer() then
		self:StopEffects()
		UTIL_Remove(self:GetParent())
	end
end

function modifier_mars_mobility_thinker:OnDelayEnds()
	if IsServer() then
		FindClearSpaceForUnit(self:GetCaster(), self:GetParent():GetAbsOrigin() , true)

		local enemies = self:GetCaster():FindUnitsInRadius(
			self:GetParent():GetOrigin(), 
			self.radius, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, 
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER
		)

		for _,enemy in pairs(enemies) do
			self.damage_table.victim = enemy
			ApplyDamage(self.damage_table)
		end

		self:PlayEffectsOnDraw()
		self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1.5)
	end
end

function modifier_mars_mobility_thinker:PlayEffectsOnDraw()
	EmitSoundOn("Hero_Nevermore.ROS_Flames", self:GetCaster())

	local particle_cast = "particles/econ/events/ti10/blink_dagger_end_ti10_lvl2.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetAbsOrigin())
    
	particle_cast = "particles/econ/items/lina/lina_ti7/lina_spell_light_strike_array_ti7.vpcf"
	effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)	
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetAbsOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 5, 1))
    ParticleManager:ReleaseParticleIndex(effect_cast)

	particle_cast = "particles/econ/items/axe/axe_helm_shoutmask/axe_beserkers_call_owner_shoutmask.vpcf"
	effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)	
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetAbsOrigin())
	ParticleManager:SetParticleControl(effect_cast, 2, Vector(self.radius, 1, 1))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	
	ScreenShake(self:GetCaster():GetAbsOrigin(), 100, 300, 0.45, 1000, 0, true)
end

function modifier_mars_mobility_thinker:PlayEffects()
    local particle_cast = "particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_v2_ground01.vpcf"
    self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(self.effect_cast, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(self.effect_cast, 1, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(self.effect_cast, 2, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(self.effect_cast, 3, Vector(self.radius, 0, 0))
end

function modifier_mars_mobility_thinker:StopEffects()
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)    
end

function modifier_mars_mobility_thinker:GetDelayTime()
    return self:GetAbility():GetSpecialValueFor("delay_time")
end

function modifier_mars_mobility_thinker:GetAOERadius()
    return self:GetAbility():GetSpecialValueFor("radius")
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Thinker(modifier_mars_mobility_thinker)