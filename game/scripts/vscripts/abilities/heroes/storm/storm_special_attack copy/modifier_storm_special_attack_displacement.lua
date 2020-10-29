modifier_storm_special_attack_displacement = class({})

function modifier_storm_special_attack_displacement:OnCreated(params)
	if IsServer() then

		self.efx = EFX('particles/units/heroes/hero_stormspirit/stormspirit_electric_vortex.vpcf', PATTACH_CUSTOMORIGIN, nil, {
			cp0 = Vector(params.originX, params.originY, self:GetParent():GetAbsOrigin().z)
		})

		ParticleManager:SetParticleControlEnt(
			self.efx,
			1,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			Vector(0,0,0), -- unknown
			true -- unknown, true
		)
			
		self:AddParticle(
			self.efx,
			false, -- bDestroyImmediately
			false, -- bStatusEffect
			-1, -- iPriority
			false, -- bHeroEffect
			false -- bOverheadEffect
		)

		EmitSoundOn("Hero_StormSpirit.ElectricVortex", self:GetParent())
	end
end

function modifier_storm_special_attack_displacement:OnDestroy()
	if IsServer() then
		DEFX(self.efx, false)
		StopSoundOn("Hero_StormSpirit.ElectricVortex", self:GetParent())
	end
end

function modifier_storm_special_attack_displacement:GetEffectName()
	return "particles/units/heroes/hero_stormspirit/stormspirit_ball_lightning.vpcf"
end

function modifier_storm_special_attack_displacement:GetEffectAttachType()
	return PATTACH_ROOTBONE_FOLLOW
end

function modifier_storm_special_attack_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_storm_special_attack_displacement:GetOverrideAnimation() 		return ACT_DOTA_FLAIL end
function modifier_storm_special_attack_displacement:GetOverrideAnimationRate() 	return 1.0 end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_storm_special_attack_displacement)
Modifiers.Animation(modifier_storm_special_attack_displacement)