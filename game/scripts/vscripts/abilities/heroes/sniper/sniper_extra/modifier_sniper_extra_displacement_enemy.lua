modifier_sniper_extra_displacement_enemy = class({})

function modifier_sniper_extra_displacement_enemy:OnCreated(params)
    if IsServer() then
        self.damage_on_collision = self:GetAbility():GetSpecialValueFor("damage_on_collision")
    end
end

function modifier_sniper_extra_displacement_enemy:OnCollide(params)
	if IsServer() then
		if params.type == WALL_COLLISION then
            local damage_table = {
                victim = self:GetParent(),
                attacker = self:GetCaster(),
                damage = self.damage_on_collision,
                damage_type = DAMAGE_TYPE_MAGICAL,
            }
            ApplyDamage( damage_table )
            
            self:Destroy()
		end
	end
end

function modifier_sniper_extra_displacement_enemy:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_sniper_extra_displacement_enemy:GetOverrideAnimation() 		return ACT_DOTA_FLAIL end
function modifier_sniper_extra_displacement_enemy:GetOverrideAnimationRate() 	return 1.0 end

function modifier_sniper_extra_displacement_enemy:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_sniper_extra_displacement_enemy)
Modifiers.Animation(modifier_sniper_extra_displacement_enemy)