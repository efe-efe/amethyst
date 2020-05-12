modifier_hero_movement = class({})

function modifier_hero_movement:IsHidden()                  return true    end
function modifier_hero_movement:IsDebuff()                  return false    end
function modifier_hero_movement:IsPurgable()                return false    end
function modifier_hero_movement:StatusEffectPriority()      return 1.0      end

function modifier_hero_movement:OnCreated(params)
end

function modifier_hero_movement:OnRefresh(params)
end

function modifier_hero_movement:DeclareFunctions() 
    return {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_WEIGHT,
    }
end

function modifier_hero_movement:GetOverrideAnimation(params)          return ACT_DOTA_RUN     end
function modifier_hero_movement:GetOverrideAnimationRate(params)      return 1.0              end
function modifier_hero_movement:GetOverrideAnimationWeight(params)    return 1.0              end