modifier_juggernaut_ex_counter = class({})

function modifier_juggernaut_ex_counter:OnCreated(kv)
	if IsServer() then
		self:SetStackCount(1)
	end
end

function modifier_juggernaut_ex_counter:OnRefresh(kv)
	if IsServer() then
        self:IncrementStackCount()
	end
end

function modifier_juggernaut_ex_counter:OnStackCountChanged(iStackCount)
    if IsServer() then
        if self:GetStackCount() <= 0 then
            self:Destroy()
        end
	end
end

function modifier_juggernaut_ex_counter:GetTexture()
	return "modifier_juggernaut_ex_counter"
end