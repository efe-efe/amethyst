modifier_spectre_special_attack_thinker = class({})

function modifier_spectre_special_attack_thinker:IsAura()
	return true
end
function modifier_spectre_special_attack_thinker:GetModifierAura()
	return "modifier_spectre_special_attack_buff"
end
function modifier_spectre_special_attack_thinker:GetAuraRadius()
	return self.radius
end
function modifier_spectre_special_attack_thinker:GetAuraDuration()
	return self.buff_duration
end
function modifier_spectre_special_attack_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end
function modifier_spectre_special_attack_thinker:GetAuraEntityReject(hEntity)
    if not self:GetCaster():IsAlly(hEntity) then
        return true 
    end
    return false
end
function modifier_spectre_special_attack_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_spectre_special_attack_thinker:OnCreated(params)
    self.buff_duration = self:GetAbility():GetSpecialValueFor("buff_duration")
    self.radius = 100
    
    if IsServer() then
        self:PlayEffects()
    end
end

function modifier_spectre_special_attack_thinker:OnDestroy()
    if IsServer() then
        self:StopEffects()
        UTIL_Remove(self:GetParent())
    end
end

function modifier_spectre_special_attack_thinker:PlayEffects()
    local pos = self:GetParent():GetOrigin()
    local particle_cast = "particles/econ/items/dazzle/dazzle_ti6/dazzle_ti6_shallow_grave_ground_steam.vpcf"
    self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(self.effect_cast, 0, pos)
    ParticleManager:SetParticleControl(self.effect_cast, 1, pos)
    
	particle_cast = "particles/econ/items/lifestealer/ls_ti9_immortal/ls_ti9_open_wounds_ground.vpcf"
	self.effect_cast_dark = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.effect_cast_dark, 0, pos)
    ParticleManager:SetParticleControl(self.effect_cast_dark, 5, pos)
end

function modifier_spectre_special_attack_thinker:StopEffects()
    if self.effect_cast then
        ParticleManager:DestroyParticle(self.effect_cast, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast)
    end

    if self.effect_cast_dark then
        ParticleManager:DestroyParticle(self.effect_cast_dark, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast_dark)
    end
end