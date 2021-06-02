modifier_upgrade_phantom_strike_knives = class({})
function modifier_upgrade_phantom_strike_knives:RemoveOnDeath() return false end
function modifier_upgrade_phantom_strike_knives:IsPurgable() return false end
 
function modifier_upgrade_phantom_strike_knives:OnCreated(params)
    if IsServer() then
        self:SetStackCount(1)
    end
end

function modifier_upgrade_phantom_strike_knives:OnRefresh()
    if IsServer() then
        self:IncrementStackCount()
    end
end