modifier_puck_mobility_displacement = class({})

function modifier_puck_mobility_displacement:OnCreated(params)
	self.debuff_duration = self:GetAbility():GetSpecialValueFor("debuff_duration")
	EmitSoundOn("Hero_Puck.Phase_Shift", self:GetParent())

	if IsServer() then
		
		local particle_cast = "particles/econ/items/mirana/mirana_ti8_immortal_mount/mirana_ti8_immortal_leap_trail_embers.vpcf"
		self.effect_cast_trail = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())

		local particle_cast = "particles/puck/puck_mobility_trail.vpcf"
		self.effect_cast_dust = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	end
end

function modifier_puck_mobility_displacement:OnDestroy()
	StopSoundOn("Hero_Puck.Phase_Shift", self:GetParent())

	if IsServer() then
		if self:GetAbility():GetLevel() >= 2 then
			self:GetParent():FindModifierByName("modifier_puck_basic_attack_cooldown"):Replenish()
		end

		ParticleManager:DestroyParticle( self.effect_cast_trail, false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast_trail )

		ParticleManager:DestroyParticle( self.effect_cast_dust, false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast_dust )

		local particle_cast = "particles/econ/items/mirana/mirana_ti8_immortal_mount/mirana_ti8_immortal_leap_start_embers.vpcf"
		local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:ReleaseParticleIndex( effect_cast )
	end
end

function modifier_puck_mobility_displacement:OnCollide(params)
    if IsServer() then
		if params.type == UNIT_COLLISION then
			for _,unit in pairs(params.units) do
				if not self:GetParent():IsAlly(unit) and not unit:HasModifier("modifier_puck_mobility_debuff") then
					unit:AddNewModifier(
						self:GetParent(), -- player source
						self:GetAbility(), -- ability source
						"modifier_puck_mobility_debuff", -- modifier name
						{ duration = self.debuff_duration }
					)
				end
			end
        end
    end
end


function modifier_puck_mobility_displacement:GetStatusEffectName()
    return "particles/status_fx/status_effect_combo_breaker.vpcf"
end

function modifier_puck_mobility_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_puck_mobility_displacement:GetOverrideAnimation() 		return ACT_DOTA_GENERIC_CHANNEL_1 end
function modifier_puck_mobility_displacement:GetOverrideAnimationRate() 	return 1.8 end

function modifier_puck_mobility_displacement:CheckState()
	return {
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_puck_mobility_displacement)
Modifiers.Animation(modifier_puck_mobility_displacement)