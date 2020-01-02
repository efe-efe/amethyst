modifier_nevermore_second_attack = class({})

function modifier_nevermore_second_attack:OnCreated(params)
    if IsServer() then
        self:SetStackCount(1)
    end
end

function modifier_nevermore_second_attack:OnRefresh(table)
    if IsServer() then
        self:IncrementStackCount()
    end
end

