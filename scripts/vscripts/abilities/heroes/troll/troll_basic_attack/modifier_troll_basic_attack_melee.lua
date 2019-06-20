modifier_troll_basic_attack_melee = class({})

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_troll_basic_attack_melee:DeclareFunctions()
	local funcs = {
	    MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}

	return funcs
end

function modifier_troll_basic_attack_melee:GetActivityTranslationModifiers()
    return "melee"
end