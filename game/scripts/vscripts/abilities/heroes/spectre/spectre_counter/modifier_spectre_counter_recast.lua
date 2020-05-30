modifier_spectre_counter_recast = class({})

function modifier_spectre_counter_recast:GetRecastAbility()
    if IsServer() then
        return self:GetParent():FindAbilityByName("spectre_counter_recast") 
    end
end

function modifier_spectre_counter_recast:GetRecastCharges()
	return 1
end

function modifier_spectre_counter_recast:GetRecastKey()
	return "Q"
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast(modifier_spectre_counter_recast)
