modifier_ancient_second_attack = class({})

---------------------------------------------------------------------------------
-- Initializer
function modifier_ancient_second_attack:OnCreated(params)
    if IsServer() then
        self.effects_cast = {}
        self.counter = 0
        self.index = 0
        self:SetStackCount(0)
		self:StartIntervalThink(0.01)
	end
end

function modifier_ancient_second_attack:OnDestroy()
    if IsServer() then
        self:StopEffects()
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_ancient_second_attack:OnIntervalThink()
    self:IncrementStackCount()
    if self.counter == 20  then
        self:PlayEffects(self.index)
        self.index = self.index + 1
        self.counter = 0
    end
    self.counter = self.counter + 1
end


function modifier_ancient_second_attack:PlayEffects(index)
    local particle_cast = "particles/units/heroes/hero_visage/visage_ambient.vpcf"
    self.effects_cast[index] = ParticleManager:CreateParticle(particle_cast, PATTACH_CUSTOMORIGIN, self:GetParent())
    ParticleManager:SetParticleControlEnt(
        self.effects_cast[index], 
        0, 
        self:GetParent(), 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        self:GetParent():GetOrigin(), 
        true 
   )
    ParticleManager:SetParticleControlEnt(
        self.effects_cast[index], 
        2, 
        self:GetParent(), 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        self:GetParent():GetOrigin(), 
        true 
   )
end

function modifier_ancient_second_attack:StopEffects()
    for _,effect in pairs(self.effects_cast) do
        ParticleManager:DestroyParticle(effect, false)
        ParticleManager:ReleaseParticleIndex(effect)
    end
end