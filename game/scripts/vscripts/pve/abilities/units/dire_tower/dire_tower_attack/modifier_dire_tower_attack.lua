modifier_dire_tower_attack = class({})

function modifier_dire_tower_attack:OnCreated()
    if IsServer() then
        EFX("particles/econ/world/towers/ti10_dire_tower/ti10_dire_tower_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), {
            release = true
        })
    end
end

function modifier_dire_tower_attack:DeclareFunctions()
    return { MODIFIER_EVENT_ON_DEATH }
end

function modifier_dire_tower_attack:OnDeath(params)
    if IsServer() then
        if params.unit ~= self:GetParent() then return end
        self:GetParent():StartGestureWithPlaybackRate(ACT_DOTA_CUSTOM_TOWER_DIE, 0.5)       
    end
end