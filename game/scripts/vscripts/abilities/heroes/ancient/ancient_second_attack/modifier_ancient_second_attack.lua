modifier_ancient_second_attack = class({})

---------------------------------------------------------------------------------
-- Initializer
function modifier_ancient_second_attack:OnCreated(params)
    if IsServer() then
        self:SetStackCount(0)
		self:StartIntervalThink( 0.01 )
	end
end


--------------------------------------------------------------------------------
-- Interval Effects
function modifier_ancient_second_attack:OnIntervalThink()
    self:IncrementStackCount()
end