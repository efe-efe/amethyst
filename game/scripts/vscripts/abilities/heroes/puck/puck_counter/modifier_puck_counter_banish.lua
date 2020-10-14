modifier_puck_counter_banish = class({})

function modifier_puck_counter_banish:OnCreated(params)
    if IsServer() then
        EmitSoundOn("Hero_Puck.Phase_Shift", self:GetParent())
        
        self.effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_puck/puck_phase_shift.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    end
end

function modifier_puck_counter_banish:OnDestroy()
    if IsServer() then
        StopSoundOn("Hero_Puck.Phase_Shift", self:GetParent())
        
        ParticleManager:DestroyParticle(self.effect_cast, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast)
    end
end

function modifier_puck_counter_banish:DeclareFunctions()
    return { MODIFIER_EVENT_ON_ORDER }
end

function modifier_puck_counter_banish:OnOrder(params)
    if params.unit == self:GetParent() then
        if  params.order_type == DOTA_UNIT_ORDER_STOP or 
            params.order_type == DOTA_UNIT_ORDER_HOLD_POSITION or 
            params.order_type == DOTA_UNIT_ORDER_CAST_POSITION or
            params.order_type == DOTA_UNIT_ORDER_CAST_NO_TARGET
        then
            self:Destroy()
        end
    end
end

function modifier_puck_counter_banish:CheckState()
    return {
        [MODIFIER_STATE_ROOTED] = true,
	}
end

function modifier_puck_counter_banish:GetStatusLabel() return "Phase Shift" end
function modifier_puck_counter_banish:GetStatusPriority() return 4 end
function modifier_puck_counter_banish:GetStatusStyle() return "PhaseShift" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Banish(modifier_puck_counter_banish)
Modifiers.Status(modifier_puck_counter_banish)