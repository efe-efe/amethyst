modifier_pango_second_attack_displacement = class({})

function modifier_pango_second_attack_displacement:OnDestroy()
	if IsServer() then
		local caster = self:GetCaster()
		local origin = caster:GetAbsOrigin()
		local range = self:GetAbility():GetCastRange(Vector(0,0,0), nil)
		local direction = (self:GetAbility():GetCursorPosition() - origin):Normalized()
		self:GetAbility():Cut(origin, direction, range)

		local trail_pfx = ParticleManager:CreateParticle("particles/phantom/mobility_trail.vpcf", PATTACH_ABSORIGIN, self:GetParent())
		ParticleManager:SetParticleControl(trail_pfx, 0, self.origin)
		ParticleManager:SetParticleControl(trail_pfx, 1, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(trail_pfx, 60, Vector(188,7,229))
		ParticleManager:SetParticleControl(trail_pfx, 61, Vector(1,0,0))
		ParticleManager:ReleaseParticleIndex(trail_pfx)
	end
end


function modifier_pango_second_attack_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_pango_second_attack_displacement:GetOverrideAnimation() 		return ACT_DOTA_CAST_ABILITY_1 end
function modifier_pango_second_attack_displacement:GetOverrideAnimationRate() 	return 1.0 end

function modifier_pango_second_attack_displacement:CheckState()
	return {
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_pango_second_attack_displacement)
Modifiers.Animation(modifier_pango_second_attack_displacement)