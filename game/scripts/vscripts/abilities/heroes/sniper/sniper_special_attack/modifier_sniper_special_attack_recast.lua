modifier_sniper_special_attack_recast = class({})

function modifier_sniper_special_attack_recast:GetRecastAbility()
    if IsServer() then
        return self:GetParent():FindAbilityByName("sniper_special_attack_recast") 
    end
end

function modifier_sniper_special_attack_recast:GetRecastCharges()
	return 1
end

function modifier_sniper_special_attack_recast:GetRecastKey()
	return "E"
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast(modifier_sniper_special_attack_recast)