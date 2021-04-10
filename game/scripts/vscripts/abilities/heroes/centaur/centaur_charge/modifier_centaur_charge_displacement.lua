modifier_centaur_charge_displacement = class({})

function modifier_centaur_charge_displacement:OnCreated(params)
	if IsServer() then
		self.origin = self:GetParent():GetAbsOrigin()
	end
end

function modifier_centaur_charge_displacement:OnDestroy()
	if IsServer() then 
		local trail_pfx = ParticleManager:CreateParticle("particles/phantom/mobility_trail.vpcf", PATTACH_ABSORIGIN, self:GetParent())
		ParticleManager:SetParticleControl(trail_pfx, 0, self.origin)
		ParticleManager:SetParticleControl(trail_pfx, 1, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(trail_pfx, 60, Vector(188,7,229))
		ParticleManager:SetParticleControl(trail_pfx, 61, Vector(1,0,0))
		ParticleManager:ReleaseParticleIndex(trail_pfx)
	end
end

function modifier_centaur_charge_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_centaur_charge_displacement:GetOverrideAnimation() 		return ACT_DOTA_CAST_ABILITY_2 end
function modifier_centaur_charge_displacement:GetOverrideAnimationRate() 	return 1.5 end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_centaur_charge_displacement)
Modifiers.Animation(modifier_centaur_charge_displacement)