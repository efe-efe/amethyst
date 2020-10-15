modifier_mars_special_attack_displacement = class({})

function modifier_mars_special_attack_displacement:OnCreated(params)
	if IsServer() then
		self.extra_damage = self:GetAbility():GetSpecialValueFor("extra_damage")
		self.debuff_duration = self:GetAbility():GetSpecialValueFor("debuff_duration")
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
		local stun = false

		if params.type == UNIT_COLLISION then
			for _,unit in pairs(params.units) do
				if unit:GetName() == "npc_dota_phantomassassin_gravestone" then
					stun = true
					break
				end
			end
		end

		if params.type == WALL_COLLISION or params.type == TREE_COLLISION then
			stun = true
		end

		if stun then
			local damage_table = {
				victim = self:GetParent(),
				attacker = self:GetCaster(),
				damage = self.extra_damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}
			ApplyDamage(damage_table)

			if self:GetAbility():GetLevel() >= 2 then
				self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_stunned", { duration = self.debuff_duration })
			else 
				self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_root", { duration = self.debuff_duration })
			end

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
	return 50
end

function modifier_mars_special_attack_displacement:GetCollisionTargetFilter()
	return DOTA_UNIT_TARGET_ALL
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_mars_special_attack_displacement)
Modifiers.Animation(modifier_mars_special_attack_displacement)