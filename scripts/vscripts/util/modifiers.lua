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
