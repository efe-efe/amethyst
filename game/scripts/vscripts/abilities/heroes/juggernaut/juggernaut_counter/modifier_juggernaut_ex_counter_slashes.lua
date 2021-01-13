modifier_juggernaut_ex_counter_slashes = class({})

function modifier_juggernaut_ex_counter_slashes:OnCreated(params)
    if IsServer() then
        self:SetStackCount(1)
    end
end

function modifier_juggernaut_ex_counter_slashes:OnRefresh(table)
    if IsServer() then
        self:IncrementStackCount()
    end
end

