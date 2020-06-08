modifier_spectre_counter_countering = class({})

function modifier_spectre_counter_countering:OnCreated(params)
    self.fading_slow_duration = self:GetAbility():GetSpecialValueFor("fading_slow_duration")
    if IsServer() then
        self.effect_cast = ParticleManager:CreateParticle("particles/spectre/spectre_counter.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    end
end

function modifier_spectre_counter_countering:OnDestroy()
    if IsServer() then
        EmitSoundOn("Hero_Spectre.HauntCast", self:GetParent())

        ParticleManager:DestroyParticle(self.effect_cast, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast)

        local effect_cast = ParticleManager:CreateParticle("particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff_circle_outer_pulse.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        ParticleManager:ReleaseParticleIndex(effect_cast)
    end
end

function modifier_spectre_counter_countering:OnTrigger(params)   
    if IsServer() then
        local modifier = self:GetParent():FindModifierByName("modifier_spectre_basic_attack_cooldown"):Replenish()
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_spectre_counter_recast", { duration = 5.0 })

        if self:GetAbility():GetLevel() >= 2 then
            params.attacker:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_spectre_counter", { duration = self.fading_slow_duration })
        end

        self:PlayEffectsOnTrigger()
    end
end


function modifier_spectre_counter_countering:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ABILITY_EXECUTED,
    }
end

function modifier_spectre_counter_countering:OnAbilityExecuted(params)
    if IsServer() then
        if params.unit ~= self:GetParent() then
            return
        end

        if params.ability ~= self:GetParent():FindAbilityByName("spectre_counter_recast") then
            self:Destroy()
        end
    end
end

function modifier_spectre_counter_countering:OnOrder(params)
    if params.unit == self:GetParent() then
        if  params.order_type == DOTA_UNIT_ORDER_STOP or 
            params.order_type == DOTA_UNIT_ORDER_HOLD_POSITION
        then
            self:Destroy()
        end
    end
end

function modifier_spectre_counter_countering:PlayEffectsOnTrigger()
    EmitSoundOn("Hero_Spectre.Reality", self:GetParent())
    local particle_cast = "particles/units/heroes/hero_spectre/spectre_death.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(effect_cast, 3, self:GetParent():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_spectre_counter_countering:GetStatusEffectName()
    return "particles/status_fx/status_effect_terrorblade_reflection.vpcf"
end

function modifier_spectre_counter_countering:GetMovementSpeedPercentage() return 80 end
function modifier_spectre_counter_countering:UseDefaultVisuals() return false end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Counter(modifier_spectre_counter_countering)