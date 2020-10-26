modifier_puck_basic_attack_cooldown = class({})

function modifier_puck_basic_attack_cooldown:OnCreated(params)
    self.charged_damage = self:GetAbility():GetSpecialValueFor("charged_damage")
end

function modifier_puck_basic_attack_cooldown:DeclareFunctions()
    return { 
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
end

function modifier_puck_basic_attack_cooldown:GetModifierPreAttack_BonusDamage()
    if not self:IsCooldownReady() then return 0 end
    return self.charged_damage
end
 
function modifier_puck_basic_attack_cooldown:OnAbilityFullyCast(params)
    if IsServer() then
        if params.unit ~= self:GetParent() then
            return
        end

        local counter = self:GetParent():FindAbilityByName("puck_counter")

        if  params.ability == counter or
            params.ability == self:GetAbility()
        then
            if  params.ability == counter and
                counter:GetLevel() < 2
            then
                return
            end

            if self:GetRemainingTime() > 0 then
                return
            end

            self:StartCooldown()
        end
    end
end

function modifier_puck_basic_attack_cooldown:OnReplenish()
    if IsServer() then
        ReplenishEFX(self:GetParent())
    end
end

function modifier_puck_basic_attack_cooldown:GetReplenishTime()
    return self:GetAbility():GetSpecialValueFor("replenish_time")
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Cooldown(modifier_puck_basic_attack_cooldown)