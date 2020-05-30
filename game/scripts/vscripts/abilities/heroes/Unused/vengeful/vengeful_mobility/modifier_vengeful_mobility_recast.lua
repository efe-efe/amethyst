modifier_vengeful_mobility_recast = class({})
modifier_vengeful_mobility_recast_ultimate = class({})

--------------------------------------------------------------------------------
-- Initializations
function modifier_vengeful_mobility_recast:OnCreated( kv )
    if IsServer() then
        self:GetParent():AddRecastVisual({
            key = "Space",
            modifier = self,
            abilityName = self:GetAbility():GetName(),
        })
    end
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_vengeful_mobility_recast_ultimate:OnCreated( kv )
    if IsServer() then
        self:GetParent():AddRecastVisual({
            key = "F",
            modifier = self,
            abilityName = self:GetAbility():GetName(),
        })
    end
end