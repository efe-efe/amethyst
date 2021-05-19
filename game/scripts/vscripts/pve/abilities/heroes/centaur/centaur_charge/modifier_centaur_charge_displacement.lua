modifier_centaur_charge_displacement = class({})

function modifier_centaur_charge_displacement:OnCreated(params)
	if IsServer() then
		self.origin = self:GetParent():GetAbsOrigin()
		self.stun_duration = 0.5
		self.fading_slow_duration = 5.0
		self.fading_slow_pct = 100
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

function modifier_centaur_charge_displacement:OnCollide(params)
	if IsServer() then
		if params.type == UNIT_COLLISION then
			for _,unit in pairs(params.units) do
				if not unit:HasModifier("modifier_centaur_debuff") then
					unit:AddNewModifier(self:GetCaster(), self:GetAbility(), 'modifier_centaur_debuff', {
						duration = self.fading_slow_duration,
						max_slow_pct = self.fading_slow_pct
					})

					unit:AddNewModifier(self:GetCaster(), self:GetAbility(), 'modifier_generic_stunned', { duration = self.stun_duration })
				end
			end
		end
	end
end

function modifier_centaur_charge_displacement:GetCollisionTeamFilter()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_centaur_charge_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_centaur_charge_displacement:GetOverrideAnimation() 		return ACT_DOTA_RUN end
function modifier_centaur_charge_displacement:GetOverrideAnimationRate() 	return 1.5 end
function modifier_centaur_charge_displacement:GetCollisionRadius() 			return 200 end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_centaur_charge_displacement)
Modifiers.Animation(modifier_centaur_charge_displacement)