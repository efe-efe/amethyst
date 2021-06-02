modifier_flying_skull_dash_intrinsic = class({})

function modifier_flying_skull_dash_intrinsic:DeclareFunctions()
    return { 
        MODIFIER_EVENT_ON_DEATH,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    }
end

function modifier_flying_skull_dash_intrinsic:OnDeath(params)
    if IsServer() then
        if params.unit ~= self:GetParent() then return end
        local projectile = self:GetAbility():GetProjectile()
        if projectile then
            projectile:Destroy(true) 
        end
    end
end