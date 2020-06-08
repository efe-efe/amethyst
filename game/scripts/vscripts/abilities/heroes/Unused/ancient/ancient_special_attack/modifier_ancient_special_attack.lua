modifier_ancient_special_attack = class({})

--------------------------------------------------------------------------------
-- Initializations
function modifier_ancient_special_attack:OnCreated(kv)
	-- references
    if IsServer() then
        self:GetParent():AddStatusBar({
            label = "chill", modifier = self, priority = 2, stylename="Chill"
        })
        
        self:PlayEffects()
	end
end

function modifier_ancient_special_attack:OnDestroy()
    if IsServer() then
        self:StopEffects()
    end
end

function modifier_ancient_special_attack:PlayEffects()
    local particle_cast = "particles/econ/courier/courier_donkey_ti7/courier_donkey_ti7_ambient_ground_ice.vpcf"
    self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_CUSTOMORIGIN, self:GetParent())
    ParticleManager:SetParticleControlEnt(
        self.effect_cast, 
        0, 
        self:GetParent(), 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        self:GetParent():GetOrigin(), 
        true 
   )
    ParticleManager:SetParticleControlEnt(
        self.effect_cast, 
        1, 
        self:GetParent(), 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        self:GetParent():GetOrigin(), 
        true 
   )
end

function modifier_ancient_special_attack:StopEffects()
    ParticleManager:DestroyParticle(self.effect_cast, false)
    ParticleManager:ReleaseParticleIndex(self.effect_cast)
end