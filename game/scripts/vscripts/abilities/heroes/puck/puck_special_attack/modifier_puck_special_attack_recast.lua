modifier_puck_special_attack_recast = class({})

function modifier_puck_special_attack_recast:GetRecastAbility()
    if IsServer() then
        return self:GetParent():FindAbilityByName("puck_special_attack_recast") 
    end
end

function modifier_puck_special_attack_recast:GetRecastCharges()
	return 1
end

function modifier_puck_special_attack_recast:GetRecastKey()
	return "E"
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast(modifier_puck_special_attack_recast)