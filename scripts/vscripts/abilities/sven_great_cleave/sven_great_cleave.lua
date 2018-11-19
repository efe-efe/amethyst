
function GreatCleave( keys )
    local greatCleave = keys.ability
	local level = greatCleave:GetLevel() - 1
    local cooldown = greatCleave:GetCooldown(level)
    local caster = keys.caster	
    local modifierName = "modifier_great_cleave_datadriven"
    local actualCleaveName = "modifier_actual_cleave_datadriven"

    greatCleave:StartCooldown(cooldown)

    caster:RemoveModifierByName(modifierName)
    caster:RemoveModifierByName(actualCleaveName)

    Timers:CreateTimer(cooldown, function()
        greatCleave:ApplyDataDrivenModifier(caster, caster, modifierName, {})
        greatCleave:ApplyDataDrivenModifier(caster, caster, actualCleaveName, {})
    end)	
end