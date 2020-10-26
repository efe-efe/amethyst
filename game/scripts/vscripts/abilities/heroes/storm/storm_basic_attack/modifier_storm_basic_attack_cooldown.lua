modifier_storm_basic_attack_cooldown = class({})

function modifier_storm_basic_attack_cooldown:DeclareFunctions()
    return { 
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
    }
end

function modifier_storm_basic_attack_cooldown:OnAbilityFullyCast(params)
    if IsServer() then
        if params.unit ~= self:GetParent() then
            return
        end

        if params.ability == self:GetAbility() then
            if self:GetRemainingTime() > 0 then
                return
            end

            self:StartCooldown()
            DEFX(self.efx)
        else
            if params.ability == self:GetParent():FindAbilityByName('storm_counter') then
                return
            end
			self:Replenish()
        end
    end
end

function modifier_storm_basic_attack_cooldown:OnReplenish()
    if IsServer() then

        self.efx = EFX("particles/units/heroes/hero_stormspirit/stormspirit_overload_ambient.vpcf", PATTACH_POINT_FOLLOW, self:GetParent(), {})
		ParticleManager:SetParticleControlEnt(self.efx, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetParent():GetAbsOrigin(), true)

        EmitSoundOn('Hero_StormSpirit.Overload', self:GetParent())
        ReplenishEFX(self:GetParent())
    end
end

function modifier_storm_basic_attack_cooldown:GetReplenishTime()
    return self:GetAbility():GetSpecialValueFor("replenish_time")
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Cooldown(modifier_storm_basic_attack_cooldown)