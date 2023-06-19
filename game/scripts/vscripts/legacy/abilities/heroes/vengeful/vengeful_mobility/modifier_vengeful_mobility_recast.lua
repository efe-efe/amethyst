modifier_vengeful_mobility_recast = class({})

function modifier_vengeful_mobility_recast:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_vengeful_mobility_recast:IsHidden() return true end

function modifier_vengeful_mobility_recast:GetRecastAbility()
	if IsServer() then
		return self:GetParent():FindAbilityByName(self:GetAbility():GetName() .. "_recast")
	end
end

function modifier_vengeful_mobility_recast:GetStatusEffectName()
	return "particles/status_fx/status_effect_dark_seer_illusion.vpcf"
end

function modifier_vengeful_mobility_recast:GetRecastCharges()
	return 1
end

function modifier_vengeful_mobility_recast:GetRecastKey()
    return "SPACE"
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast(modifier_vengeful_mobility_recast)