modifier_puck_fairy_dust = class({})

function modifier_puck_fairy_dust:OnCreated(params)
    if IsServer() then
        self:SetStackCount(params.slow_pct)
    end
    local particle_cast = "particles/puck/puck_mobility_trail.vpcf"
    self.effect_cast_dust = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
end

function modifier_puck_fairy_dust:OnDestroy()
    ParticleManager:DestroyParticle(self.effect_cast_dust, false)
    ParticleManager:ReleaseParticleIndex(self.effect_cast_dust)
end


function modifier_puck_fairy_dust:OnRefresh(params)
    if IsServer() then
        if params.slow_pct > self:GetStackCount() then
            self:SetStackCount(params.slow_pct)
        end
    end
end

function modifier_puck_fairy_dust:DeclareFunctions()
	return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end


function modifier_puck_fairy_dust:GetModifierMoveSpeedBonus_Percentage()
    return -self:GetStackCount()
end


function modifier_puck_fairy_dust:GetStatusEffectName()
    return "particles/status_fx/status_effect_combo_breaker.vpcf"
end

function modifier_puck_fairy_dust:GetStatusLabel() return "Fairy Dust" end
function modifier_puck_fairy_dust:GetStatusPriority() return 4 end
function modifier_puck_fairy_dust:GetStatusStyle() return "FairyDust" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_puck_fairy_dust)