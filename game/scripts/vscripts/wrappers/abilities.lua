Abilities = {}

function Abilities.Tie(ability, abilityName, shareCooldowns)
    local onSpellStart = ability.OnSpellStart

    function ability:OnSpellStart()
        if onSpellStart then onSpellStart(self) end

        if (shareCooldowns ~= false) then
            local otherAbility = self:GetCaster():FindAbilityByName(abilityName)
            otherAbility:StartCooldown(otherAbility:GetCooldown(0))
        end
    end
end

function Abilities.Castpoint(ability)
    local getCastPoint = ability.GetCastPoint
    local onAbilityPhaseStart = ability.OnAbilityPhaseStart
    local onAbilityPhaseInterrupted = ability.OnAbilityPhaseInterrupted
    local onSpellStart = ability.OnSpellStart
    local getCastPointSpeed = ability.GetCastPointSpeed
    local getAnimationTranslate = ability.GetAnimationTranslate
    local getFadeGestureOnCast = ability.GetFadeGestureOnCast
    local getIgnoreActivationCycle = ability.GetIgnoreActivationCycle
    
    function ability:OnAbilityPhaseStart()
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_casting", { 
            duration = self:GetCastPoint(), 
            movement_speed = self:GetCastPointSpeed(),
            translate = self:GetAnimationTranslate(),
            ignore_activation_cycle = self:GetIgnoreActivationCycle()
        })

        if self.GetCastAnimationCustom then
            self:GetCaster():StartGestureWithPlaybackRate(self:GetCastAnimationCustom(), self:GetPlaybackRateOverride())
        end
        
        if onAbilityPhaseStart then onAbilityPhaseStart(self) end
        return true
    end

    function ability:OnAbilityPhaseInterrupted()
        if self.GetCastAnimationCustom then
            self:GetCaster():FadeGesture(self:GetCastAnimationCustom())
        end
        self:GetCaster():RemoveModifierByName("modifier_casting")
    end

    function ability:OnSpellStart()
        if self.GetCastAnimationCustom then
            if self:GetFadeGestureOnCast() then
                self:GetCaster():FadeGesture(self:GetCastAnimationCustom())
            end
        end
        if onSpellStart then onSpellStart(self) end
    end

    function ability:GetCastPointSpeed()
        if getCastPointSpeed then return getCastPointSpeed(self) end
        return 100
    end

    function ability:GetAnimationTranslate()
        if getAnimationTranslate then return getAnimationTranslate(self) end
        return nil
    end

    function ability:GetFadeGestureOnCast()
        if getFadeGestureOnCast then return getFadeGestureOnCast(self) end
        return true
    end

    function ability:GetIgnoreActivationCycle()
        if getIgnoreActivationCycle then return getIgnoreActivationCycle(self) end
        return nil
    end


    function ability:GetCastPoint()
        if self.GetCastPointOverride then
            return self:GetCastPointOverride()
        end

        return self:GetSpecialValueFor("cast_point")
    end
end

