modifier_phantom_second_attack_recast = class({})

function modifier_phantom_second_attack_recast:IsHidden()
    return true
end

function modifier_phantom_second_attack_recast:GetRecastAbility()
    if IsServer() then
        return self:GetParent():FindAbilityByName("phantom_second_attack_recast") 
    end
end

function modifier_phantom_second_attack_recast:GetRecastCharges()
	return 1
end

function modifier_phantom_second_attack_recast:GetRecastKey()
	return "M2"
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast(modifier_phantom_second_attack_recast)