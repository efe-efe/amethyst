modifier_invoker_mobility_thinker = class({})

function modifier_invoker_mobility_thinker:OnCreated(params)
    self.caster = self:GetCaster()
    self.origin = self:GetParent():GetAbsOrigin()
	self.radius = self:GetAbility():GetSpecialValueFor('radius')
	
	if IsServer() then
        local delay_time = self:GetAbility():GetSpecialValueFor('delay_time')
        CreateTimedRadiusMarker(self.caster, self.origin, self.radius, delay_time, 0.2, RADIUS_SCOPE_PUBLIC)
        self:StartIntervalThink(delay_time)
		AddFOWViewer(self.caster:GetTeamNumber(), self.origin, self.radius, delay_time +  0.2, true)
        self:PlayEffects()
        self.caster:AddNewModifier(self.caster, self:GetAbility(), "modifier_invoker_mobility_banish", { duration = delay_time })
    end
end

function modifier_invoker_mobility_thinker:OnDestroy()
	if IsServer() then
		self:StopEffects()
		UTIL_Remove(self:GetParent())
	end
end

function modifier_invoker_mobility_thinker:OnIntervalThink()
	FindClearSpaceForUnit(self.caster, self.origin, true)
	self:PlayEffectsOnDraw()
	--self.caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1.5)
	self:Destroy()
end

function modifier_invoker_mobility_thinker:PlayEffectsOnDraw()
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

function modifier_invoker_mobility_thinker:PlayEffects()
    local particle_cast = "particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_v2_ground01.vpcf"
    self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(self.effect_cast, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(self.effect_cast, 1, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(self.effect_cast, 2, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(self.effect_cast, 3, Vector(self.radius, 0, 0))
end

function modifier_invoker_mobility_thinker:StopEffects()
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)    
end
