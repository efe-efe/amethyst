modifier_phantom_counter_banish = class({})

function modifier_phantom_counter_banish:OnCreated(params)
    self.heal = self:GetAbility():GetSpecialValueFor("heal")
    self.buff_duration = self:GetAbility():GetSpecialValueFor("buff_duration")

    if IsServer() then
        self:PlayEffectsOnCreated()
    end
end

function modifier_phantom_counter_banish:OnDestroy()
    if IsServer() then
        local point = ClampPosition(self:GetParent():GetAbsOrigin(), CustomAbilitiesLegacy:GetCursorPosition(self:GetAbility()), self:GetAbility():GetCastRange(Vector(0,0,0), nil), nil)
        FindClearSpaceForUnit(self:GetParent(), point, true)

        self:GetParent():Heal(self.heal, self:GetParent())
        
        if self:GetAbility():GetLevel() >= 2 then
            self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_phantom_counter_recast", { duration = self.buff_duration })
        end
        
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_phantom_counter", { duration = self.buff_duration })
        self:PlayEffectsOnCast()
    end
end


function modifier_phantom_counter_banish:PlayEffectsOnCreated()
    EmitSoundOn("Hero_PhantomAssassin.Blur", self:GetParent())

    local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(effect_cast, 3, self:GetParent():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_phantom_counter_banish:PlayEffectsOnCast()
    EmitSoundOn("Hero_PhantomAssassin.Blur.Break", self:GetParent() )

    local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(effect_cast, 3, self:GetParent():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_phantom_counter_banish:CheckState()
	return {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end


if IsClient() then require("wrappers/modifiers") end
Modifiers.Banish(modifier_phantom_counter_banish)