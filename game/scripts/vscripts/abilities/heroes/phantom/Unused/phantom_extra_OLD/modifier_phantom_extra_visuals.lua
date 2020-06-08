modifier_phantom_extra_visuals = class({})

function modifier_phantom_extra_visuals:IsDebuff() return false
end

function modifier_phantom_extra_visuals:IsHidden()
	return true
end

function modifier_phantom_extra_visuals:IsPurgable() return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_phantom_extra_visuals:OnCreated(kv)
    if IsServer() then
        self:PlayEffects_a()
		--self:GetParent():AddNoDraw()
	end
end

function modifier_phantom_extra_visuals:OnDestroy(kv)
	if IsServer() then
		--self:GetParent():RemoveNoDraw()
		self:PlayEffects_b()
	end
end

function modifier_phantom_extra_visuals:PlayEffects_a()
	-- Create Particles
	local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_event_glitch.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_phantom_extra_visuals:PlayEffects_b()
	-- Create Particles
	local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_event_glitch.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 3, self:GetCaster():GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end
