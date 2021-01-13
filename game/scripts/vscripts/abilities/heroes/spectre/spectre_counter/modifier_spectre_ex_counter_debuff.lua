modifier_spectre_ex_counter_debuff = class({})

function modifier_spectre_ex_counter_debuff:OnCreated(table)
    if IsServer() then
        self:StartIntervalThink(0.03)
    end
end

function modifier_spectre_ex_counter_debuff:OnIntervalThink()
	local direction = (self:GetCaster():GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Normalized()
	local point = self:GetParent():GetAbsOrigin() + direction * 40
	self:GetParent():SetAbsOrigin(point)
end