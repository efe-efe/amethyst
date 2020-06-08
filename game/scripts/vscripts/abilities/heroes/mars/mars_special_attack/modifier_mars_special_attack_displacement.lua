modifier_mars_special_attack_displacement = class({})

function modifier_mars_special_attack_displacement:OnCreated(params)
	if IsServer() then
		self.extra_damage = self:GetAbility():GetSpecialValueFor("extra_damage")
		self.stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")
	end
end

function modifier_mars_special_attack_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_mars_special_attack_displacement:GetOverrideAnimation() 		return ACT_DOTA_FLAIL end
function modifier_mars_special_attack_displacement:GetOverrideAnimationRate() 	return 1.0 end

function modifier_mars_special_attack_displacement:CheckState()
	return {
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_mars_special_attack_displacement:OnCollide(params)
	if IsServer() then
		if params.type == WALL_COLLISION then
			local damage_table = {
				victim = self:GetParent(),
				attacker = self:GetCaster(),
				damage = self.extra_damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}
			ApplyDamage(damage_table)

			self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_stunned", { duration = self.stun_duration })

			self:PlayEffectsOnImpact()
			self:Destroy()
		end
	end
end

function modifier_mars_special_attack_displacement:PlayEffectsOnImpact()
	local origin = self:GetParent():GetAbsOrigin()
	local particle_cast = "particles/units/heroes/hero_mars/mars_spear_impact.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
   	ParticleManager:SetParticleControl(effect_cast, 0, Vector(origin.x, origin.y, origin.z - 64))
   	ParticleManager:SetParticleControl(effect_cast, 1, self:GetDirection() * 1000)
	ParticleManager:SetParticleControlForward(effect_cast, 0, self:GetDirection())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_mars_special_attack_displacement:GetCollisionOffset()
	return 120
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_mars_special_attack_displacement)
Modifiers.Animation(modifier_mars_special_attack_displacement)