modifier_juggernaut_counter_recast = class({})

function modifier_juggernaut_counter_recast:IsHidden() return true end

function modifier_juggernaut_counter_recast:OnDestroy()
	if IsServer() then
		if self:GetRemainingTime() < 0.05 then
			self:GetParent():RemoveModifierByName("modifier_juggernaut_counter")
		end
	end
end

function modifier_juggernaut_counter_recast:GetRecastAbility()
	if IsServer() then
		return self:GetParent():FindAbilityByName("juggernaut_counter_recast")
	end
end	

function modifier_juggernaut_counter_recast:GetEffectName()
	return "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger.vpcf"
end

function modifier_juggernaut_counter_recast:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast( 
	modifier_juggernaut_counter_recast,
	{ key = "Q", charges = 1 }
)
