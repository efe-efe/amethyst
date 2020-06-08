modifier_puck_mobility_debuff = class({})

function modifier_puck_mobility_debuff:OnCreated(params)
    self.speed_debuff_pct = self:GetAbility():GetSpecialValueFor("speed_debuff_pct")
    
    local particle_cast = "particles/puck/puck_mobility_trail.vpcf"
    self.effect_cast_dust = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
end

function modifier_puck_mobility_debuff:OnDestroy()
    ParticleManager:DestroyParticle(self.effect_cast_dust, false)
    ParticleManager:ReleaseParticleIndex(self.effect_cast_dust)
end

function modifier_puck_mobility_debuff:DeclareFunctions()
	return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end


function modifier_puck_mobility_debuff:GetModifierMoveSpeedBonus_Percentage()
    return -self.speed_debuff_pct
end


function modifier_puck_mobility_debuff:GetStatusEffectName()
    return "particles/status_fx/status_effect_combo_breaker.vpcf"
end

function modifier_puck_mobility_debuff:GetStatusLabel() return "Fairy Dust" end
function modifier_puck_mobility_debuff:GetStatusPriority() return 4 end
function modifier_puck_mobility_debuff:GetStatusStyle() return "FairyDust" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_puck_mobility_debuff)