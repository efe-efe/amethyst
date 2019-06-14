modifier_wisp_basic_attack_lua = class({})

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_wisp_basic_attack_lua:DeclareFunctions()
	local funcs = {
        MODIFIER_EVENT_ON_HEALTH_GAINED,
	}
	return funcs
end

function modifier_wisp_basic_attack_lua:OnHealthGained(params)
    if IsServer() then
        local heal = params.gain/2
        self:GetCaster():SetHealth(self:GetCaster():GetHealth() + heal)

        return true
    end
end