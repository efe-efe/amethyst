modifier_generic_invencible = class({})

function modifier_generic_invencible:IsHidden() return false
end

function modifier_generic_invencible:IsDebuff() return false
end

function modifier_generic_invencible:IsPurgable()
	return true
end

function modifier_generic_invencible:OnCreated(kv)
    if IsServer() then
		self:PlayEffects()
		self:StartIntervalThink(0.05)
    end
end

function modifier_generic_invencible:OnIntervalThink()
	self:GetParent():StrongPurge()
end

function modifier_generic_invencible:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

function modifier_generic_invencible:GetModifierIncomingDamage_Percentage(params)
	return -100
end

function modifier_generic_invencible:PlayEffects()
	local particle_cast = "particles/econ/items/monkey_king/arcana/fire/mk_arcana_fire_spring_ring_radial.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

-- Graphics & Animations
function modifier_generic_invencible:GetStatusEffectName()
	return "particles/status_fx/status_effect_electrical.vpcf"
end
