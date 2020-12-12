modifier_juggernaut_extra_ward = class({})

function modifier_juggernaut_extra_ward:IsAura()
	return true
end
function modifier_juggernaut_extra_ward:GetModifierAura()
	return "modifier_juggernaut_extra"
end
function modifier_juggernaut_extra_ward:GetAuraRadius()
	return self.radius
end
function modifier_juggernaut_extra_ward:GetAuraDuration()
	return 0.5
end
function modifier_juggernaut_extra_ward:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end
function modifier_juggernaut_extra_ward:GetAuraEntityReject(hEntity)
    if not self:GetCaster():IsAlly(hEntity) then
        return true 
    end
    return false
end
function modifier_juggernaut_extra_ward:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_juggernaut_extra_ward:OnCreated()
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    if IsServer() then
        self:PlayEffectsOnCreated()
        self:StartIntervalThink(0.03)

        EmitSoundOn('Hero_Juggernaut.HealingWard.Loop', self:GetParent())
    end
end

function modifier_juggernaut_extra_ward:OnDestroy()
    if IsServer() then
        ParticleManager:DestroyParticle(self.effect_cast, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast)

        ParticleManager:DestroyParticle(self.efx, false)
        ParticleManager:ReleaseParticleIndex(self.efx)

        EFX('particles/econ/items/juggernaut/jugg_fall20_immortal/jugg_fall20_immortal_healing_ward_death.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), {
            release = true,
        })

        self:GetParent():Kill(nil, self:GetParent())

        self:GetAbility():StartCooldown(self:GetAbility():GetCooldown(0))

        if self:GetCaster():HasModifier("modifier_juggernaut_extra_recast") then
            self:GetCaster():RemoveModifierByName("modifier_juggernaut_extra_recast")
        end

        StopSoundOn('Hero_Juggernaut.HealingWard.Stop', self:GetParent())
        EmitSoundOn('Hero_Juggernaut.HealingWard.Stop', self:GetParent())
    end
end

function modifier_juggernaut_extra_ward:OnIntervalThink()
    local percentage = ((self:GetDuration() - self:GetRemainingTime())/self:GetDuration()) + 0.03

    ParticleManager:SetParticleControl(self.efx, 0, self:GetParent():GetAbsOrigin() + Vector(0, 0, 16))
    ParticleManager:SetParticleControl(self.efx, 1, Vector(self.radius, percentage, 0))
end

function modifier_juggernaut_extra_ward:PlayEffectsOnCreated()
    local effect_cast = ParticleManager:CreateParticle("particles/econ/items/juggernaut/bladekeeper_healing_ward/juggernaut_healing_ward_eruption_dc.vpcf", PATTACH_CUSTOMORIGIN, self:GetParent())
    ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)

    local particle_cast = "particles/econ/items/juggernaut/jugg_fall20_immortal/jugg_fall20_immortal_healing_ward.vpcf"

    self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(self.effect_cast, 0, self:GetParent():GetAbsOrigin() + Vector(0, 0, 100))
    ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.radius, 1, 1))
    ParticleManager:SetParticleControlEnt(
        self.effect_cast, 
        2, 
        self:GetParent(), 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        self:GetParent():GetAbsOrigin(), 
        true
   )
    
    self.efx = ParticleManager:CreateParticle("particles/progress_circle/generic_progress_circle_small.vpcf", PATTACH_WORLDORIGIN, self:GetParent())
    ParticleManager:SetParticleControl(self.efx, 0, self:GetParent():GetAbsOrigin() + Vector(0, 0, 16))
    ParticleManager:SetParticleControlForward(self.efx, 0, Vector(0, -1, 0))	
    ParticleManager:SetParticleControl(self.efx, 1, Vector(self.radius, 0, 1))
    ParticleManager:SetParticleControl(self.efx, 15, Vector(1, 255, 1))
    ParticleManager:SetParticleControl(self.efx, 16, Vector(1, 0, 0))
end


function modifier_juggernaut_extra_ward:DeclareFunctions()
    return { MODIFIER_EVENT_ON_DEATH }
end

function modifier_juggernaut_extra_ward:OnDeath(params)
    if IsServer() then
        if params.unit ~= self:GetParent() then return end
        self:Destroy()        
    end
end
