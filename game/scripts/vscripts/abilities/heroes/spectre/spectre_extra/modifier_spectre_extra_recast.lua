modifier_spectre_extra_recast = class({})

function modifier_spectre_extra_recast:GetRecastAbility()
    if IsServer() then
        return self:GetParent():FindAbilityByName("spectre_extra_recast") 
    end
end

function modifier_spectre_extra_recast:GetRecastCharges()
	return 1
end

function modifier_spectre_extra_recast:GetRecastKey()
	return "F"
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast(modifier_spectre_extra_recast)
