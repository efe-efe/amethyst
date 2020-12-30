modifier_invoker_ice_wall_custom = class({})

function modifier_invoker_ice_wall_custom:OnCreated(params)
    if IsServer() then
        local damage_table = {
            victim = self:GetParent(),
            attacker = self:GetCaster(),
            damage = 3,
            damage_type = DAMAGE_TYPE_PURE,
        }
        ApplyDamage(damage_table)
    end
end

function modifier_invoker_ice_wall_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_invoker_ice_wall_custom:GetModifierMoveSpeedBonus_Percentage()
    return -25
end
