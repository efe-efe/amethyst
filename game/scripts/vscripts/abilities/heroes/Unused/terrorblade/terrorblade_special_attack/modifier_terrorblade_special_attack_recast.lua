modifier_terrorblade_special_attack_recast = class({})

function modifier_terrorblade_special_attack_recast:OnDestroy()
	if IsServer() then
		if self:GetRemainingTime() < 0.05 then 
			local ability = self:GetCaster():FindAbilityByName("terrorblade_special_attack_recast")
            self:GetParent():CastAbilityImmediately(ability, self:GetParent():GetEntityIndex())
		end
	end
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast(
	modifier_terrorblade_special_attack_recast,
	{ ability_name = "terrorblade_special_attack_recast", key = "E" }
)
