modifier_phoenix_ex_ultimate_visuals = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phoenix_ex_ultimate_visuals:IsHidden()
	return true
end

function modifier_phoenix_ex_ultimate_visuals:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_phoenix_ex_ultimate_visuals:OnCreated()
    self.range = 1300   --self:GetAbility():GetSpecialValueFor("range")

    if IsServer() then
        local parent = self:GetParent()
        local origin = parent:GetOrigin()
        local direction = self:GetParent():GetForwardVector():Normalized()
        local target = origin +  direction * self.range 
        self:PlayEffects(target)

        self:StartIntervalThink(0.0)
    end
end


function modifier_phoenix_ex_ultimate_visuals:OnDestroy()
    if IsServer() then
        self:StopEffects()
    end
end

function modifier_phoenix_ex_ultimate_visuals:OnIntervalThink()
    local target = self:GetParent():GetOrigin() + self:GetParent():GetForwardVector():Normalized() * self.range 
    ParticleManager:SetParticleControl( self.effect_cast, 1, target )
end

function modifier_phoenix_ex_ultimate_visuals:PlayEffects(target)
    local particle_cast = "particles/econ/items/phoenix/phoenix_solar_forge/phoenix_sunray_solar_forge.vpcf"
    
    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControlEnt( 
        self.effect_cast, 
        0, 
        self:GetParent(), 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        self:GetParent():GetAbsOrigin(), 
        true 
    )
    ParticleManager:SetParticleControl( self.effect_cast, 1, target )
end

function modifier_phoenix_ex_ultimate_visuals:StopEffects()
    EmitSoundOn("Hero_Phoenix.SunRay.Stop", self:GetParent())
    ParticleManager:DestroyParticle( self.effect_cast, false )
    ParticleManager:ReleaseParticleIndex( self.effect_cast )
end