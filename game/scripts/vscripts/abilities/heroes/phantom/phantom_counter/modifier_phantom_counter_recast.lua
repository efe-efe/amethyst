modifier_phantom_counter_recast = class({})

function modifier_phantom_counter_recast:IsHidden() 	return 	false 	end
function modifier_phantom_counter_recast:IsDebuff() 	return 	false 	end
function modifier_phantom_counter_recast:IsPurgable() 	return 	true 	end

function modifier_phantom_counter_recast:GetRecastAbility()
    if IsServer() then
        return self:GetParent():FindAbilityByName("phantom_counter_recast") 
    end
end

function modifier_phantom_counter_recast:GetRecastCharges()
	return 1
end

function modifier_phantom_counter_recast:GetRecastKey()
	return "Q"
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast(modifier_phantom_counter_recast)
