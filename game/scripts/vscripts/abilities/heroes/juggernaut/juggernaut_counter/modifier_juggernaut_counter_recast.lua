modifier_juggernaut_counter_recast = class({})

function modifier_juggernaut_counter_recast:OnDestroy()
	if IsServer() then
		if self:GetRemainingTime() < 0.05 then
			self:GetParent():RemoveModifierByName("modifier_juggernaut_counter")
		end
	end
end

--------------------------------------------------------------------------------
--Graphics & Animations
function modifier_juggernaut_counter_recast:GetEffectName()
	return "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger.vpcf"
end

function modifier_juggernaut_counter_recast:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast( 
	modifier_juggernaut_counter_recast,
	{ ability_name = "juggernaut_counter_recast", key = "Q", charges = 1 }
)
