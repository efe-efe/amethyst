modifier_sniper_ex_special_attack_thinker = class({})

function modifier_sniper_ex_special_attack_thinker:IsAura()
	return self:IsInitialized()
end
function modifier_sniper_ex_special_attack_thinker:GetModifierAura()
	return "modifier_sniper_shrapnel_debuff"
end
function modifier_sniper_ex_special_attack_thinker:GetAuraRadius()
	return self.radius
end
function modifier_sniper_ex_special_attack_thinker:GetAuraDuration()
	return self.debuff_linger
end
function modifier_sniper_ex_special_attack_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end
function modifier_sniper_ex_special_attack_thinker:GetAuraEntityReject(hEntity)
    if self:GetCaster():IsAlly(hEntity) then
        return true 
    end
    return false
end
function modifier_sniper_ex_special_attack_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_sniper_ex_special_attack_thinker:OnDelayEnds()
    if IsServer() then
        self.duration = self:GetAbility():GetSpecialValueFor("duration")
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.debuff_linger = self:GetAbility():GetSpecialValueFor("debuff_linger")
        self.direction = (self:GetParent():GetAbsOrigin() - self:GetCaster():GetAbsOrigin()):Normalized()
        
        AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self.radius, self.duration, false)
        self:PlayEffects()
    end
end

function modifier_sniper_ex_special_attack_thinker:OnDestroy()
    if IsServer() then
        self:StopEffects()
		UTIL_Remove(self:GetParent())
	end
end

function modifier_sniper_ex_special_attack_thinker:PlayEffects()
    EmitSoundOn("Hero_Sniper.MKG_ShrapnelShatter", self:GetParent())

    local particle_cast = "particles/mod_units/heroes/hero_sniper/sniper_shrapnel.vpcf"
    self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(self.effect_cast, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.radius,0,0))
	ParticleManager:SetParticleControlForward(self.effect_cast, 2, self.direction + Vector(0, 0, 0.1))
end

function modifier_sniper_ex_special_attack_thinker:StopEffects()
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)

	StopSoundOn("Hero_Sniper.MKG_ShrapnelShatter", self:GetParent())
end

function modifier_sniper_ex_special_attack_thinker:GetDelayTime()
    return self:GetAbility():GetSpecialValueFor("delay_time")
end

function modifier_sniper_ex_special_attack_thinker:GetAOERadius()
    return self:GetAbility():GetSpecialValueFor("radius")
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Thinker(modifier_sniper_ex_special_attack_thinker)