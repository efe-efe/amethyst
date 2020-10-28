modifier_nevermore_second_attack_recast = class({})

function modifier_nevermore_second_attack_recast:GetEffectName()
	return "particles/units/heroes/hero_invoker_kid/invoker_kid_forge_spirit_ambient_fire.vpcf"
end

function modifier_nevermore_second_attack_recast:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_nevermore_second_attack_recast:GetRecastKey()
	return "M2"
end

function modifier_nevermore_second_attack_recast:GetRecastCharges()
	return 1
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast(modifier_nevermore_second_attack_recast)