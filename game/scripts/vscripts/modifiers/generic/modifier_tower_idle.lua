modifier_tower_idle = class({})

function modifier_tower_idle:IsHidden()                  return true     end
function modifier_tower_idle:IsDebuff()                  return false    end
function modifier_tower_idle:IsPurgable()                return false    end
function modifier_tower_idle:StatusEffectPriority()      return 1.0      end

function modifier_tower_idle:DeclareFunctions() 
    return {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
    }
end

function modifier_tower_idle:GetOverrideAnimation(params)          return ACT_DOTA_CUSTOM_TOWER_IDLE     end
function modifier_tower_idle:GetOverrideAnimationRate(params)      return 1.0              end