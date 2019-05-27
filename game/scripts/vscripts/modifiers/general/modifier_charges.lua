modifier_charges = class({})

function modifier_basic_attack:OnCreated( kv )
    --Initializers
    self.ability = self:GetAbility()
    self.max_charges = self.ability:GetSpecialValueFor("max_charges")
    self.start_charges = self.ability:GetSpecialValueFor("start_charges")
    self.replenish_time = self.ability:GetSpecialValueFor("replenish_time")
    self.mana_gain = self.ability:GetSpecialValueFor("mana_gain")
    
    self:SetStackCount(self.max_charges)
end

function modifier_charges:OnAbilityExecuted( kv )
    if kv.unit == self:GetParent() then

        local executed_ability = kv.ability
        local charges = self:GetStackCount() 

        if executed_ability == self:GetAbility() then

            if self.max_charges == charges then
                self:SetDuration(self.replenish_time, true)
                Timers:CreateTimer(self.replenish_time, function()
                        self:SetStackCount(self.max_charges)
                    end
                )
            end
            self:DecrementStackCount()
            
            if self:GetStackCount() == 0 then
                self:GetAbility():StartCooldown(self:GetRemainingTime())
            end
            
        end
    end
    return 0
end

--- Misc 
function modifier_basic_attack:DestroyOnExpire()
    return false
end

function modifier_basic_attack:IsPurgable()
    return false
end

function modifier_basic_attack:RemoveOnDeath()
    return false
end

function modifier_basic_attack:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ABILITY_EXECUTED
    }
    return funcs
end

