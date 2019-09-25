Abilities = {}

--[[
    warmup = {
        fixed_range = 1 or nil,     max_range equals to min_range
        min_range = 1 or nil,       min_range comes from SpecialValue "min_range",
        movement_speed = int        movement_speed pct while casting
    }
]]

function Abilities.Initialize( ability, animation, warmup, range )
    local onCastPointEnd = ability.OnCastPointEnd

    function ability:GetBehavior()
        return self.BaseClass.GetBehavior(self) + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
    end
    
    function ability:OnSpellStart()
        local caster = self:GetCaster()
        local cast_point = self:IsBasicAttack() and caster:GetAttackAnimationPoint() or self:GetCastPoint() 
        
        if animation and animation.activity then
            StartAnimation(caster, {
                duration = animation.duration or cast_point + 0.1, 
                activity = animation.activity, 
                rate = animation.rate or 1.0  
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
            if warmup.min_range then
                min_range = self:GetSpecialValueFor("min_range")
            end
        end

        caster:AddNewModifier( caster, self, "modifier_cast_point_new", { 
            duration = cast_point, 
            movement_speed = warmup.movement_speed,
            radius = radius,
            min_range = min_range,
            max_range = max_range,
            hide_indicator = warmup.hide_indicator or false
        })
    end

    function ability:OnCastPointEnd()
        if onCastPointEnd then onCastPointEnd(self) end
        
        local alternate_version = self:GetCaster():FindAbilityByName(self:GetAlternateName())
        if alternate_version ~= nil then
            alternate_version:StartCooldown(self:GetCooldown(0))
        end
    end
end

function Abilities.BasicAttack( ability )
    local onCastPointEnd = ability.OnCastPointEnd

    function ability:OnCastPointEnd()
        if onCastPointEnd then onCastPointEnd(self) end

        local attacks_per_second = self:GetCaster():GetAttacksPerSecond()
        local attack_speed = ( 1 / attacks_per_second )
        self:StartCooldown( attack_speed )
    end
end