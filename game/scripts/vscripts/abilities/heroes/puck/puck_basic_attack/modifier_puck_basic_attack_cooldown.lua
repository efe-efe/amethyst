modifier_puck_basic_attack_cooldown = class({})
modifier_puck_basic_attack_buff = class({})

function modifier_puck_basic_attack_cooldown:DeclareFunctions()
    return { 
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        --MODIFIER_EVENT_ON_ATTACK,
    }
end

function modifier_puck_basic_attack_cooldown:OnEvent(params)
    if params.iEventId == MODIFIER_EVENTS.ON_BASIC_ATTACK_STARTED then
        if self:GetRemainingTime() > 0 then
            return
        end
        
        if IsServer() then
            self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), 'modifier_puck_basic_attack_buff', {})
        end
        self:StartCooldown()
    end
end

function modifier_puck_basic_attack_cooldown:GetModifierPreAttack_BonusDamage()
    if not self:IsCooldownReady() then return 0 end
    return self:GetAbility():GetSpecialValueFor("charged_damage")
end

function modifier_puck_basic_attack_cooldown:OnReplenish()
    if IsServer() then
        ReplenishEFX(self:GetParent())
    end
end

function modifier_puck_basic_attack_cooldown:GetReplenishTime()
    return self:GetAbility():GetSpecialValueFor("replenish_time")
end

function modifier_puck_basic_attack_buff:OnEvent(params)
    if params.iEventId == MODIFIER_EVENTS.ON_BASIC_ATTACK_ENDED then
        self:Destroy()
    end
end

function modifier_puck_basic_attack_buff:GetPreAttackDamage(params)
    return self:GetAbility():GetSpecialValueFor("charged_damage")
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Cooldown(modifier_puck_basic_attack_cooldown)
Modifiers.OnEvent(modifier_puck_basic_attack_cooldown)
Modifiers.OnEvent(modifier_puck_basic_attack_buff)
Modifiers.PreAttackDamage(modifier_puck_basic_attack_buff)