modifier_generic_pre_silence = class({})
LinkLuaModifier("modifier_generic_silence", "abilities/generic/modifier_generic_silence", LUA_MODIFIER_MOTION_NONE)

function modifier_generic_pre_silence:IsHidden()
    return false
end

function modifier_generic_pre_silence:IsPurgable()
    return true
end

function modifier_generic_pre_silence:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ORDER,
    }
    return funcs
end


function modifier_generic_pre_silence:OnCreated()
    if IsServer() then
        self:PlayEffects_a()

        ProgressBars:AddProgressBar(self:GetParent(), self:GetName(), {
            style = "PreSilence",
            text = "pre-silence",
            progressBarType = "duration",
            priority = 1,
        })
    end
end

function modifier_generic_pre_silence:OnDestroy()
    if IsServer() then
        local silence_duration = self:GetAbility():GetSpecialValueFor("silence_duration")

        self:StopEffects_a()
        if self:GetRemainingTime() > 0.05 then
            self:PlayEffects_b()

            self:GetParent():AddNewModifier(
                self:GetCaster(),
                self:GetAbility(),
                "modifier_generic_silence",
                { duration = silence_duration }
           )
        end
    end
end

function modifier_generic_pre_silence:PlayEffects_a()
    -- Create Sounds
    local sound_cast = "Hero_Silencer.Curse.Impact"
    EmitSoundOn(sound_cast, self:GetParent())

    -- Create particles
    local particle_cast = "particles/econ/items/silencer/silencer_ti6/silencer_last_word_status_ti6.vpcf"
    self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())

    ParticleManager:SetParticleControl(self.effect_cast, 0, self:GetParent():GetOrigin())
end

function modifier_generic_pre_silence:StopEffects_a()
    -- Destroy particles
    if self.effect_cast == nil then return end

    ParticleManager:DestroyParticle(self.effect_cast, false)
    ParticleManager:ReleaseParticleIndex(self.effect_cast)
end

function modifier_generic_pre_silence:PlayEffects_b()
    -- Create Sounds
    local sound_cast = "Hero_Silencer.Curse"
    EmitSoundOn(sound_cast, self:GetParent())

    -- Create particles
    local particle_cast = "particles/econ/items/silencer/silencer_ti6/silencer_last_word_dmg_ti6.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, self:GetParent())

    ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end