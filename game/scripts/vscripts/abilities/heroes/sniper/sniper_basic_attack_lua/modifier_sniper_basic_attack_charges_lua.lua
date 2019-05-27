modifier_sniper_basic_attack_charges_lua = class({})

--- Misc 
function modifier_sniper_basic_attack_charges_lua:IsHidden()
    return false
end

function modifier_sniper_basic_attack_charges_lua:DestroyOnExpire()
    return false
end

function modifier_sniper_basic_attack_charges_lua:IsPurgable()
    return false
end

function modifier_sniper_basic_attack_charges_lua:RemoveOnDeath()
    return false
end

function modifier_sniper_basic_attack_charges_lua:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ABILITY_EXECUTED,
    }
    return funcs
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sniper_basic_attack_charges_lua:OnCreated( kv )
    --Initializers
    if IsServer() then
        
        self.ability = self:GetAbility()
        self.max_charges = self.ability:GetSpecialValueFor("max_charges")
        self.start_charges = self.ability:GetSpecialValueFor("start_charges")
        self.replenish_time = self.ability:GetSpecialValueFor("replenish_time")
        local caster = self.ability:GetCaster()

        self:SetStackCount(self.max_charges)
    end
end

function modifier_sniper_basic_attack_charges_lua:OnAbilityExecuted( kv )
    if kv.unit == self:GetParent() then

        local ability = kv.ability
        local charges = self:GetStackCount() 

        if ability == self.ability then

            if self.max_charges == charges then
                self:SetDuration(self.replenish_time, true)
                Timers:CreateTimer(self.replenish_time, function()
                    self:SetStackCount(self.max_charges)
                end)
            end
            self:DecrementStackCount()
            
            if self:GetStackCount() == 0 then
                self.ability:StartCooldown(self:GetRemainingTime())
            end
            
        end
    end
    return 0
end
