modifier_lich_ultimate = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_lich_ultimate:IsHidden()
	return false
end

function modifier_lich_ultimate:IsDebuff()
	return false
end

function modifier_lich_ultimate:IsStunDebuff()
	return false
end

function modifier_lich_ultimate:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_lich_ultimate:OnCreated( kv )
	-- references
	if IsServer() then
		self:SetStackCount(1)
	end
end

function modifier_lich_ultimate:OnRefresh( kv )
	if IsServer() then
		self:IncrementStackCount()
	end
end