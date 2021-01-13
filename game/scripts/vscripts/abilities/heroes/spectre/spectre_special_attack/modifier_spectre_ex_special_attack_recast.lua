modifier_spectre_ex_special_attack_recast = class({})

function modifier_spectre_ex_special_attack_recast:GetRecastAbility()
    if IsServer() then
        return self:GetParent():FindAbilityByName("spectre_ex_special_attack_recast") 
    end
end

function modifier_spectre_ex_special_attack_recast:GetRecastCharges()
	return 1
end

function modifier_spectre_ex_special_attack_recast:GetRecastKey()
	return "2"
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast(modifier_spectre_ex_special_attack_recast)
