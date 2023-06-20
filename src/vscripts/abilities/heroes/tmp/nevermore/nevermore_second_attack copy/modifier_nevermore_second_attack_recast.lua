modifier_nevermore_second_attack_recast = class({})

function modifier_nevermore_second_attack_recast:GetEffectName()
	return "particles/units/heroes/hero_invoker_kid/invoker_kid_forge_spirit_ambient_fire.vpcf"
}

function modifier_nevermore_second_attack_recast:GetEffectAttachType()
	return ParticleAttachment.ABSORIGIN_FOLLOW
}

function modifier_nevermore_second_attack_recast:GetRecastKey()
	return "M2"
}

function modifier_nevermore_second_attack_recast:GetRecastCharges()
	return 1
}

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Recast(modifier_nevermore_second_attack_recast)