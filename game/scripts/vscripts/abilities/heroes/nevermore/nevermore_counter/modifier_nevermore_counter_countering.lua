modifier_nevermore_counter_countering = class({})

function modifier_nevermore_counter_countering:OnCreated(params)
    self.banish_duration = self:GetAbility():GetSpecialValueFor("banish_duration")
    EmitSoundOn("Hero_Nevermore.RequiemOfSoulsCast", self:GetParent())
end

function modifier_nevermore_counter_countering:OnDestroy()
    if IsServer() then
        StopSoundOn("Hero_Nevermore.RequiemOfSoulsCast", self:GetCaster())
		EmitSoundOn("Hero_Juggernaut.Attack", self:GetCaster())
		local particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_omni_slash_tgt_bonus.vpcf"
		local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
		ParticleManager:ReleaseParticleIndex(effect_cast)
	end
end

function modifier_nevermore_counter_countering:OnTrigger(params)
    if IsServer() then
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_nevermore_counter_banish", { duration = self.banish_duration })
        self:GetParent():StrongPurge()
        self:PlayEffectsOnTrigger()
		self:Destroy()
	end
end

function modifier_nevermore_counter_countering:GetMovementSpeedPercentage() return 0 end

function modifier_nevermore_counter_countering:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_nevermore_counter_countering:GetOverrideAnimation() 		return ACT_DOTA_TELEPORT end
function modifier_nevermore_counter_countering:GetOverrideAnimationRate() 	return 1.0 end

function modifier_nevermore_counter_countering:PlayEffectsOnTrigger()
    EmitSoundOn("Hero_Nevermore.RequiemOfSouls", self:GetParent())

	local particle_cast = "particles/econ/events/ti9/blink_dagger_ti9_start_lvl2.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    
	local particle_cast_b = "particles/econ/events/ti9/phase_boots_ti9_body_magic.vpcf"
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast_b, 0, self:GetParent():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Counter(modifier_nevermore_counter_countering)