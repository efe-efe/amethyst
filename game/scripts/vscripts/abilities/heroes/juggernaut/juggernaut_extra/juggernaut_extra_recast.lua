juggernaut_extra_recast = class({})

function juggernaut_extra_recast:OnSpellStart()
    local caster = self:GetCaster()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    
    local healing_ward = EntIndexToHScript(self.healing_ward_index) 

    healing_ward:MoveToPosition(point)

    self:PlayEffects(point)
end

function juggernaut_extra_recast:SetHealingWardIndex(healing_ward_index)
    self.healing_ward_index = healing_ward_index
end

function juggernaut_extra_recast:PlayEffects(point)
    local particle_cast = "particles/ui_mouseactions/clicked_basemove.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, point)
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(0,255,0))
end