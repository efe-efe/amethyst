modifier_juggernaut_second_attack_recast = class({})

function modifier_juggernaut_second_attack_recast:IsHidden() return true end

function modifier_juggernaut_second_attack_recast:OnCreated(params)
    if IsServer() then
        self.charges = params.charges
    end
end

function modifier_juggernaut_second_attack_recast:GetRecastAbility()
	if IsServer() then
		return self:GetParent():FindAbilityByName("juggernaut_second_attack_recast")
	end
end	

function modifier_juggernaut_second_attack_recast:GetEffectName()
	return "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger.vpcf"
end

function modifier_juggernaut_second_attack_recast:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_juggernaut_second_attack_recast:GetRecastCharges()
    if IsServer() then
	    return self.charges
    end
end

function modifier_juggernaut_second_attack_recast:GetRecastKey()
	return "M2"
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast(modifier_juggernaut_second_attack_recast)