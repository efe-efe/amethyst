modifier_hero_movement_running = class({})

function modifier_hero_movement_running:DeclareFunctions() 
    return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end

function modifier_hero_movement_running:GetActivityTranslationModifiers(params)
	return "haste"
end
