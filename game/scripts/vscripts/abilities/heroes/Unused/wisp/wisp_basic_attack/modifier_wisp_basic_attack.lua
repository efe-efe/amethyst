modifier_wisp_basic_attack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_wisp_basic_attack:IsHidden()
	return true
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_wisp_basic_attack:OnCreated()
    self.heal_share = self:GetAbility():GetSpecialValueFor("heal_share")
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_wisp_basic_attack:DeclareFunctions()
	local funcs = {
        MODIFIER_EVENT_ON_HEALTH_GAINED,
	}
	return funcs
end

function modifier_wisp_basic_attack:OnHealthGained(params)
    if IsServer() then
        if params.unit == self:GetCaster() then 
            return 
        end

        local heal = params.gain * self.heal_share/100
        
        self:GetCaster():Heal(heal, self:GetAbility())

        --return true
    end
end