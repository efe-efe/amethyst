modifier_juggernaut_counter = class({})

function modifier_juggernaut_counter:OnCreated(params)
    if IsServer() then
        self:SetStackCount(1)
    end
end

function modifier_juggernaut_counter:OnRefresh(table)
    if IsServer() then
        self:IncrementStackCount()
    end
end

