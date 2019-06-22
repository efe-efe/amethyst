modifier_wisp_basic_attack_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_wisp_basic_attack_lua:IsHidden()
	return true
end

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
        if params.unit == self:GetCaster() then 
            return 
        end

        local heal = params.gain/2
        self:GetCaster():Heal(heal, self:GetAbility())

        --return true
    end
end