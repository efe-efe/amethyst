modifier_stack = class({})
local tempTable = require("util/tempTable")

--------------------------------------------------------------------------------
-- Classifications
function modifier_stack:IsHidden()
	return true
end

function modifier_stack:IsPurgable()
	return false
end

function modifier_stack:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_stack:OnCreated( kv )
	if IsServer() then
		self.modifier = tempTable:RetATValue( kv.modifier )
	end
end

function modifier_stack:OnRemoved()
	if IsServer() then
		self.modifier:RemoveStack()
	end
end
