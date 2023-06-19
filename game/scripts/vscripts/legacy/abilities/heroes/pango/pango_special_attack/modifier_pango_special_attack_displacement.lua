modifier_pango_special_attack_displacement = class({})


function modifier_pango_special_attack_displacement:OnCreated(table)
    if IsServer() then
		self.radius = self:GetAbility():GetSpecialValueFor("radius")
	end
end

function modifier_pango_special_attack_displacement:OnDestroy()
	if IsServer() then
		self:GetAbility():Crash(self.radius)

		if self:GetAbility():GetLevel() >= 2 then
			local caster = self:GetCaster()
			local origin = caster:GetAbsOrigin()
			local direction = caster:GetForwardVector()
			local pango_second_attack = caster:FindAbilityByName("pango_second_attack")
			local range = pango_second_attack:GetCastRange(Vector(0,0,0), nil)/2

			pango_second_attack:Cut(origin, direction, range)
			pango_second_attack:Cut(origin, direction * -1, range)
		end
	end
end


function modifier_pango_special_attack_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_pango_special_attack_displacement:GetOverrideAnimation()
	if self:GetParent():HasModifier("modifier_pango_mobility") then 
		return
	end
	return ACT_DOTA_CAST_ABILITY_2 
end
function modifier_pango_special_attack_displacement:GetOverrideAnimationRate() 	return 1.0 end

function modifier_pango_special_attack_displacement:CheckState()
	return {
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_pango_special_attack_displacement)
Modifiers.Animation(modifier_pango_special_attack_displacement)