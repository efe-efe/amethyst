modifier_item_butterfly_custom_banish = class({})

function modifier_item_butterfly_custom_banish:OnDestroy()
	if IsServer() then
		self:PlayEffectsOnDestroy()
	end
end

function modifier_item_butterfly_custom_banish:PlayEffectsOnDestroy()
    EmitSoundOn( "Hero_PhantomAssassin.Blur.Break", self:GetCaster()  )

    local particle_cast = "particles/butterfly_effect/pa_arcana_event_glitch.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetOrigin() )

    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_item_butterfly_custom_banish:CheckState()
    return {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
    }
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Banish(modifier_item_butterfly_custom_banish)
