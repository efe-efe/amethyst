modifier_juggernaut_special_attack_recast = class({})

function modifier_juggernaut_special_attack_recast:OnCreated(params)
    if IsServer() then
        self.target_index = params.target_index
    end
end

function modifier_juggernaut_special_attack_recast:GetTargetIndex()
    return self.target_index
end

function modifier_juggernaut_special_attack_recast:GetRecastAbility()
    if IsServer() then
        return self:GetParent():FindAbilityByName("juggernaut_special_attack_recast") 
    end
end

function modifier_juggernaut_special_attack_recast:GetRecastCharges()
	return 1
end

function modifier_juggernaut_special_attack_recast:GetRecastKey()
	return "E"
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast(modifier_juggernaut_special_attack_recast)