modifier_hero_movement = class({})

local translate = {
	["bulwark"] = 1,
}

function modifier_hero_movement:IsHidden()                  return true     end
function modifier_hero_movement:IsDebuff()                  return false    end
function modifier_hero_movement:IsPurgable()                return false    end
function modifier_hero_movement:StatusEffectPriority()      return 1.0      end

function modifier_hero_movement:OnCreated(params)
    if IsServer() then
        local translate_modifiers = CustomEntitiesLegacy:GetAllModifiersWithType(self:GetParent(), MODIFIER_TYPES.TRANSLATE)

        if translate_modifiers then
            local translate_modifier = nil

            for _,modifier in pairs(translate_modifiers) do
                local modifier_handle = self:GetParent():FindModifierByName(modifier)

                if translate_modifier == nil then
                    translate_modifier = modifier_handle
                else
                    if modifier_handle:GetWeight() > translate_modifier:GetWeight() then
                        translate_modifier = modifier_handle
                    end
                end
            end

            if translate_modifier ~= nil then
                self:SetStackCount(translate[translate_modifier:GetTranslation()])
            end
        end
    end
end

function modifier_hero_movement:DeclareFunctions() 
    return {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_WEIGHT,
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
    }
end

function modifier_hero_movement:GetOverrideAnimation(params)          return ACT_DOTA_RUN     end
function modifier_hero_movement:GetOverrideAnimationRate(params)      return 1.0              end
function modifier_hero_movement:GetOverrideAnimationWeight(params)    return 1.0              end
function modifier_hero_movement:GetActivityTranslationModifiers(params)
	for k,v in pairs(translate) do
        if self:GetStackCount() == v then
			return k
		end
	end
end