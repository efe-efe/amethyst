modifier_nevermore_special_attack = class({})

function modifier_nevermore_special_attack:OnCreated()
    if IsServer() then
        self:StartIntervalThink(1.0)
    end
end

function modifier_nevermore_special_attack:OnIntervalThink()
    local radius = self:GetAbility():GetCastRange(Vector(0,0,0), nil)

    if radius > 0 then
        self:PlayEffectsAoe(radius)
    end
end


function modifier_nevermore_special_attack:PlayEffectsAoe(radius)
    local particle_cast = "particles/aoe_marker.vpcf"

    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin())
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, 1, 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 2, Vector( 255, 50, 50 ) )
    ParticleManager:SetParticleControl( effect_cast, 3, Vector(0.3, 0, 0) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end