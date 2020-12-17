modifier_spectre_ultimate_thinker = class({})

function modifier_spectre_ultimate_thinker:IsAura()
	return self.initialized
end
function modifier_spectre_ultimate_thinker:GetModifierAura()
	return "modifier_spectre_ultimate"
end
function modifier_spectre_ultimate_thinker:GetAuraRadius()
	return self.radius
end
function modifier_spectre_ultimate_thinker:GetAuraDuration()
	return 0.0
end
function modifier_spectre_ultimate_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end
function modifier_spectre_ultimate_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_spectre_ultimate_thinker:OnCreated()
    if IsServer() then
        local delay_time = self:GetAbility():GetSpecialValueFor("delay_time")
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.origin = self:GetParent():GetAbsOrigin()
        self.duration = self:GetAbility():GetSpecialValueFor("duration")
        self.initialized = false
        CreateTimedRadiusMarker(self:GetCaster(), self.origin, self.radius, delay_time, 0.2, RADIUS_SCOPE_PUBLIC)
        self:StartIntervalThink(delay_time)
    end
end


function modifier_spectre_ultimate_thinker:OnDestroy()
    if IsServer() then
        ApplyCallbackForUnitsInArea(self:GetCaster(), self.origin, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)

            local modifier = unit:FindModifierByName("modifier_spectre_ultimate")
            if modifier ~= nil then
                if not modifier:IsNull() then
                    modifier:SetStackCount(1)
                end
            end 
        end)

        ParticleManager:DestroyParticle(self.efx, false)
        ParticleManager:ReleaseParticleIndex(self.efx)
        
        UTIL_Remove(self:GetParent())
    end
end

function modifier_spectre_ultimate_thinker:OnIntervalThink()
    if not self.initialized then
        self.efx = ParticleManager:CreateParticle("particles/spectre/spectre_ultimate.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(self.efx, 0, self.origin)
        ParticleManager:SetParticleControl(self.efx, 1, Vector(self.radius, self.radius, 1))

        self.initialized = true
        self:StartIntervalThink(self.duration)
        EmitSoundOn("Hero_Spectre.HauntCast", self:GetParent())
        EmitSoundOn("Hero_Spectre.Reality", self:GetParent())
    else
        self:Destroy()
    end
end