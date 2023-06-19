modifier_invoker_tornado_custom_displacement = class({})

function modifier_invoker_tornado_custom_displacement:OnCreated(table)
    if IsServer() then
        self.efx = ParticleManager:CreateParticle("particles/econ/items/invoker/invoker_ti6/invoker_tornado_child_ti6.vpcf", PATTACH_ABSORIGIN, self:GetParent())
    end
end

function modifier_invoker_tornado_custom_displacement:OnDestroy()
    if IsServer() then
        local fading_slow_duration = 0.5
        local fading_slow_pct = 100

        self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_fading_slow", { 
            duration = fading_slow_duration,
            maxSlowPct = fading_slow_pct 
        })

        StopSoundOn("Hero_Invoker.Tornado.Target", self:GetParent())
        EmitSoundOn("Hero_Invoker.Tornado.LandDamage", self:GetParent())
        ParticleManager:DestroyParticle(self.efx, false)
        ParticleManager:ReleaseParticleIndex(self.efx)
    end
end

function modifier_invoker_tornado_custom_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_invoker_tornado_custom_displacement:GetOverrideAnimation() 		return ACT_DOTA_FLAIL end
function modifier_invoker_tornado_custom_displacement:GetOverrideAnimationRate() 	return 1.0 end

function modifier_invoker_tornado_custom_displacement:CheckState()
	return {
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_invoker_tornado_custom_displacement)
Modifiers.Animation(modifier_invoker_tornado_custom_displacement)