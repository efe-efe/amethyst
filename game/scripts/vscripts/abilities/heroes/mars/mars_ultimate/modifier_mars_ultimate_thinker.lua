modifier_mars_ultimate_thinker = class({})

function modifier_mars_ultimate_thinker:OnCreated(params)
    self.radius = self:GetAbility():GetSpecialValueFor("radius")

    EmitSoundOn("Hero_Mars.ArenaOfBlood", self:GetParent())
    
end
    
function modifier_mars_ultimate_thinker:OnDestroy()
    if IsServer() then
        EmitSoundOn("Hero_Mars.ArenaOfBlood.End", self:GetParent())
        self:StopEffects()
    end
end

function modifier_mars_ultimate_thinker:OnDelayEnds()
    if IsServer() then
        self:PlayEffectsOnCreated()
        EmitSoundOn("Hero_Mars.ArenaOfBlood.Start", self:GetParent())
    end
end

function modifier_mars_ultimate_thinker:PlayEffectsOnCreated()
    local particle_cast = "particles/units/heroes/hero_mars/mars_arena_of_blood.vpcf"
	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, self:GetParent())	
	ParticleManager:SetParticleControl(self.effect_cast, 2, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.radius, 1, 1))
end

function modifier_mars_ultimate_thinker:StopEffects()
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
end
    
function modifier_mars_ultimate_thinker:GetDelayTime()
    return self:GetAbility():GetCastPoint()
end

function modifier_mars_ultimate_thinker:GetAOERadius()
    return self:GetAbility():GetSpecialValueFor("radius")
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Thinker(modifier_mars_ultimate_thinker)