modifier_miss = class({})

function modifier_miss:DeclareFunctions()
    return { 
        MODIFIER_PROPERTY_EVASION_CONSTANT
    }
end

function modifier_miss:GetModifierEvasion_Constant(params)
    return 100
end