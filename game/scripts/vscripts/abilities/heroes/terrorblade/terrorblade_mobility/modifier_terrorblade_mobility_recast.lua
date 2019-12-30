modifier_terrorblade_mobility_recast = class({})

function modifier_terrorblade_mobility_recast:OnCreated()
	if IsServer() then
		local ability = self:GetCaster():FindAbilityByName("terrorblade_mobility_recast")
		self:StartIntervalThink(self:GetDuration() - ability:GetSpecialValueFor("cast_point") - 0.1)
	end
end

function modifier_terrorblade_mobility_recast:OnIntervalThink()
	if IsServer() then
		local ability = self:GetCaster():FindAbilityByName("terrorblade_mobility_recast")
		self:GetParent():CastAbilityImmediately(ability, self:GetParent():GetEntityIndex())
	end
end


if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast( 
	modifier_terrorblade_mobility_recast,
	{ ability_name = "terrorblade_mobility_recast", key = "SPACE" }
)
