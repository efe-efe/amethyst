function SafeDestroyModifier(modifier_name, unit, caster)
    -- Find and destroy modifier
    local modifier = unit:FindModifierByNameAndCaster( modifier_name, caster )
    
    -- Safe destroying
    if modifier~=nil then
        if not modifier:IsNull() then
            modifier:Destroy()
        end
    end
end

function SafeGetModifierStacks(modifier_name, unit, caster)
    -- Find and destroy modifier
    local modifier = unit:FindModifierByNameAndCaster( modifier_name, caster )
    local stacks = 0

    -- Safe Get stack count
    if modifier~=nil then
        if not modifier:IsNull() then
            stacks = modifier:GetStackCount()
        end
    end

    return stacks
end

function SafeGetModifierCaster(modifier_name, unit)
    -- Find and destroy modifier
    local modifier = unit:FindModifierByName( modifier_name)
    local caster = nil

    -- Safe destroying
    if modifier~=nil then
        if not modifier:IsNull() then
            caster = modifier:GetCaster()
        end
    end

    return caster
end
