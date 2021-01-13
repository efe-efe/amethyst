modifier_storm_special_attack_efx = class({})

function modifier_storm_special_attack_efx:OnCreated(params)
	if IsServer() then
		self.origin = Vector(params.originX, params.originY, self:GetParent():GetAbsOrigin().z)
		self.efx = EFX('particles/units/heroes/hero_stormspirit/stormspirit_electric_vortex.vpcf', PATTACH_CUSTOMORIGIN, nil, {
			cp0 = self.origin
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

		self:StartIntervalThink(0.03)
	end
end

function modifier_storm_special_attack_efx:OnDestroy()
	if IsServer() then
		DEFX(self.efx, false)
		StopSoundOn("Hero_StormSpirit.ElectricVortex", self:GetParent())
	end
end

function modifier_storm_special_attack_efx:OnIntervalThink()
	local direction = (self.origin - self:GetParent():GetAbsOrigin()):Normalized()
	local point = self:GetParent():GetAbsOrigin() + direction * 10
	self:GetParent():SetAbsOrigin(point)
end

function modifier_storm_special_attack_efx:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_storm_special_attack_efx:GetOverrideAnimation() 		return ACT_DOTA_FLAIL end
function modifier_storm_special_attack_efx:GetOverrideAnimationRate() 	return 1.0 end


function modifier_storm_special_attack_efx:GetStatusLabel() return "Electric Vortex" end
function modifier_storm_special_attack_efx:GetStatusPriority() return 1 end
function modifier_storm_special_attack_efx:GetStatusStyle() return "StormUnleashed" end


if IsClient() then require("wrappers/modifiers") end
Modifiers.Animation(modifier_storm_special_attack_efx)
Modifiers.Status(modifier_storm_special_attack_efx)