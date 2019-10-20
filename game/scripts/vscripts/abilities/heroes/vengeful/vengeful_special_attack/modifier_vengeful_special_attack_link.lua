modifier_vengeful_special_attack_link = class({})

function modifier_vengeful_special_attack_link:OnCreated()
    self.max_range = self:GetAbility():GetSpecialValueFor("link_range")

    if IsServer() then
        self:StartIntervalThink(0.1)
        self:PlayEffects(self:GetParent())
    end
end

function modifier_vengeful_special_attack_link:OnRefresh()
    if IsServer() then
        self:StartIntervalThink(0.1)
        self:PlayEffects(self:GetParent())
    end
    
end

function modifier_vengeful_special_attack_link:OnDestroy()
    if IsServer() then
        self:StopEffects()
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_vengeful_special_attack_link:OnIntervalThink()
    local target_origin = self:GetCaster():GetOrigin()
    local caster_origin = self:GetParent():GetOrigin()
    local direction = (caster_origin - target_origin)
    local distance = direction:Length2D()

    if distance > self.max_range then
        self:Destroy()
    end
end

--------------------------------------------------------------------------------
-- Graphics & Sounds
function modifier_vengeful_special_attack_link:PlayEffects( hTarget )
    -- Get Resources
    if IsServer() then
        local caster = self:GetCaster()
        local origin = caster:GetOrigin()

        local particle_cast = "particles/econ/items/razor/razor_punctured_crest_golden/razor_static_link_blade_golden.vpcf"
        self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_CUSTOMORIGIN, nil)

        ParticleManager:SetParticleControlEnt( 
            self.effect_cast, 
            0, 
            caster, 
            PATTACH_POINT_FOLLOW, 
            "attach_hitloc", 
            origin + Vector( 0, 0, 96 ), 
            true 
        );
        ParticleManager:SetParticleControlEnt( 
            self.effect_cast, 
            1, 
            hTarget, 
            PATTACH_POINT_FOLLOW, 
            "attach_hitloc", 
            hTarget:GetOrigin(), 
            true 
        );
    end
end

function modifier_vengeful_special_attack_link:StopEffects()
    if IsServer() then
        ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end
end

