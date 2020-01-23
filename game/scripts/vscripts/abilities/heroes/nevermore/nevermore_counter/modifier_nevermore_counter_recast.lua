modifier_nevermore_counter_recast = class({})

function modifier_nevermore_counter_recast:OnCreated(params)
	if IsServer() then
		local ability = self:GetParent():FindAbilityByName("nevermore_counter_recast")
		local radius = ability:GetSpecialValueFor("radius")

		self:GetParent():AddNewModifier(
			self:GetParent(), 
			ability, 
			"modifier_target_indicator_permanent", 
			{
				radius = radius,
			})
	end
end

function modifier_nevermore_counter_recast:OnDestroy()
	if IsServer() then
		self:GetParent():RemoveModifierByName("modifier_target_indicator_permanent")
		if self:GetRemainingTime() < 0.05 then 
			local ability = self:GetCaster():FindAbilityByName("nevermore_counter_recast")
            self:GetParent():CastAbilityImmediately(ability, self:GetParent():GetEntityIndex())
		end
	end
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast( 
	modifier_nevermore_counter_recast,
	{ ability_name = "nevermore_counter_recast", key = "CASTING" }
)
