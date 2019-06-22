modifier_nevermore_second_attack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_nevermore_second_attack:IsHidden()
	return false
end

function modifier_nevermore_second_attack:IsDebuff()
	return true
end

function modifier_nevermore_second_attack:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_nevermore_second_attack:OnCreated()
    if IsServer() then
	    self:SetStackCount(1)
        -- Start Interval
    end
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_nevermore_second_attack:OnRefresh()
    if IsServer() then
	    self:IncrementStackCount()
        -- Start Interval
    end
end

function modifier_nevermore_second_attack:OnStackCountChanged( old )
	if IsServer() then
		if self:GetStackCount() < 1 then
			self:Destroy()
		end
	end
end