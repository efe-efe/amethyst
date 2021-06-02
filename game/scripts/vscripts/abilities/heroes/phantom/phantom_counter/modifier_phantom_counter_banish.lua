modifier_phantom_counter_banish = class({})

function modifier_phantom_counter_banish:OnCreated(params)
    self.ability = self:GetAbility()
    self.heal = self.ability:GetSpecialValueFor("heal")
    self.buff_duration = self.ability:GetSpecialValueFor("buff_duration")

    if IsServer() then
        self.parent = self:GetParent()
        self:PlayEffectsOnCreated()
    end
end

function modifier_phantom_counter_banish:OnDestroy()
    if IsServer() then
        local point = ClampPosition(self.parent:GetAbsOrigin(), CustomAbilitiesLegacy:GetCursorPosition(self.ability), self.ability:GetCastRange(Vector(0,0,0), nil), nil)
        FindClearSpaceForUnit(self.parent, point, true)

        if not self.parent:HasModifier("modifier_upgrade_phantom_strike_instant") then
            self.parent:Heal(self.heal, self.parent)
        end
        
        self.parent:FindAbilityByName("phantom_basic_attack"):TryThrowKnives("modifier_upgrade_phantom_strike_knives")
        
        if self.ability:GetLevel() >= 2 then
            self.parent:AddNewModifier(self.parent, self.ability, "modifier_phantom_counter_recast", { duration = self.buff_duration })
        end
        
        self.parent:AddNewModifier(self.parent, self.ability, "modifier_phantom_counter", { duration = self.buff_duration })
        self:PlayEffectsOnCast()
    end
end


function modifier_phantom_counter_banish:PlayEffectsOnCreated()
    EmitSoundOn("Hero_PhantomAssassin.Blur", self.parent)

    local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, self.parent:GetAbsOrigin())
    ParticleManager:SetParticleControl(effect_cast, 3, self.parent:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_phantom_counter_banish:PlayEffectsOnCast()
    EmitSoundOn("Hero_PhantomAssassin.Blur.Break", self.parent )

    local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControl(effect_cast, 3, self.parent:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_phantom_counter_banish:CheckState()
	return {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end


if IsClient() then require("wrappers/modifiers") end
Modifiers.Banish(modifier_phantom_counter_banish)