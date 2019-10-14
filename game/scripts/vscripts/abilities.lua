Abilities = {}

--[[
    warmup = {
        fixed_range = 1 or nil,     max_range equals to min_range
        min_range = 1 or nil,       min_range comes from SpecialValue "min_range",
        movement_speed = int        movement_speed pct while casting
    }
]]

function Abilities.Initialize( ability, animation, warmup )
    local onCastPointEnd = ability.OnCastPointEnd
    local onSpellStart = ability.OnSpellStart

    function ability:GetBehavior()
        return self.BaseClass.GetBehavior(self) + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
    end
    
    function ability:OnSpellStart()
        local caster = self:GetCaster()
        local cast_point = self:GetCastPoint() 
        local myrate = animation and animation.rate or self:GetPlaybackRateOverride()


        if animation or self.GetCastAnimation then
            StartAnimation(caster, {
                duration = animation and animation.duration or cast_point + 0.1, 
                activity = animation and animation.activity or self:GetCastAnimation(), 
                rate = animation and animation.rate or self:GetPlaybackRateOverride(),
                translate = animation and animation.translate or nil,
            })
        end

        local radius = nil
        local min_range = nil
        local max_range = nil

        if self:HasBehavior(DOTA_ABILITY_BEHAVIOR_AOE) then
            radius = self:GetSpecialValueFor("radius")
        end
        if self:HasBehavior(DOTA_ABILITY_BEHAVIOR_NO_TARGET) then
            max_range = 0
        else 
            max_range = self:GetCastRange(Vector(0,0,0), nil)
        end

        if warmup.fixed_range then
            min_range = max_range
        else
            min_range = self:GetSpecialValueFor("min_range")
        end

        caster:AddNewModifier( caster, self, "modifier_cast_point_new", { 
            duration = cast_point, 
            movement_speed = warmup.movement_speed,
            radius = radius,
            min_range = min_range,
            max_range = max_range,
            hide_indicator = warmup.hide_indicator or false,
            public = warmup.public or nil,
            disable_all = warmup.disable_all == false and 0 or 1
        })
        
        -- Castbar (ULTIMATE)
        if self:GetAbilityType() == 1 then
            ProgressBars:AddProgressBar(caster, "modifier_cast_point_new", {
                style = "Ultimate",
                text = "ultimate",
                progressBarType = "duration",
                priority = 0,
                reversedProgress = true,
            })
        -- Castbar (MOUNT)
        elseif self:GetName() == "mount" then
            ProgressBars:AddProgressBar(caster, "modifier_cast_point_new", {
                style = "Generic",
                text = "mounting",
                progressBarType = "duration",
                priority = 1,
                reversedProgress = true,
            })
        -- Castbar
        else
            if warmup.hide_castbar ~= 1 then
                ProgressBars:AddProgressBar(caster, "modifier_cast_point_new", {
                    style = "Castpoint",
                    progressBarType = "duration",
                    ignorePriority = true,
                    reversedProgress = true,
                })
            end
        end

        if onSpellStart then
            onSpellStart(self)
        end
    end

    function ability:OnCastPointEnd()
        if self:HasBehavior(DOTA_ABILITY_BEHAVIOR_CHANNELLED) then
            
        end

        if onCastPointEnd then onCastPointEnd(self) end

        local alternate_version = self:GetCaster():FindAbilityByName(self:GetAlternateName())
        if alternate_version ~= nil then
            alternate_version:StartCooldown(self:GetCooldown(0))
        end
    end
end

function Abilities.BasicAttack( ability )
    local onCastPointEnd = ability.OnCastPointEnd
    local getCastPoint = ability.GetCastPoint

    function ability:OnCastPointEnd()
        if onCastPointEnd then onCastPointEnd(self) end

        local attacks_per_second = self:GetCaster():GetAttacksPerSecond()
        local attack_speed = ( 1 / attacks_per_second )
        self:StartCooldown( attack_speed )
    end

    function ability:GetCastPoint()
        if IsServer() then
            return self.BaseClass.GetCastPoint( self ) + self:GetCaster():GetAttackAnimationPoint()
        end
    end
    
end