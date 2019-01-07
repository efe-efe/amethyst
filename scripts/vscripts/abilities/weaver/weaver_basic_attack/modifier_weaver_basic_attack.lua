modifier_weaver_basic_attack = class ({})

--- Misc 
function modifier_weaver_basic_attack:IsHidden()
    return false
end

function modifier_weaver_basic_attack:DestroyOnExpire()
    return false
end

function modifier_weaver_basic_attack:IsPurgable()
    return false
end

function modifier_weaver_basic_attack:RemoveOnDeath()
    return false
end

function modifier_weaver_basic_attack:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ABILITY_EXECUTED,
    }
    return funcs
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_weaver_basic_attack:OnCreated( kv )
    

    --Initializers
    if IsServer() then
        
        self.ability = self:GetAbility()
        self.max_charges = self.ability:GetSpecialValueFor("max_charges")
        self.start_charges = self.ability:GetSpecialValueFor("start_charges")
        --self.replenish_time = self.ability:GetSpecialValueFor("replenish_time")
        local caster = self.ability:GetCaster()

        local attacks_per_second = caster:GetAttacksPerSecond()
        local attack_speed = ( 1 / attacks_per_second )
        self.replenish_time = attack_speed
        
        caster:AddNewModifier(caster, self.ability , "modifier_mana_on_attack", {})

        self:SetStackCount(self.max_charges)
    end
end

function modifier_weaver_basic_attack:OnAbilityExecuted( kv )
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
