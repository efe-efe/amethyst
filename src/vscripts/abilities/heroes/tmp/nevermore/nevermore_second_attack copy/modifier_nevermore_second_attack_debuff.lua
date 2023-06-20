modifier_nevermore_second_attack_debuff = class({})

OnCreated(params){
    if(IsServer() ) {
        this.SetStackCount(1)
    }
}

function modifier_nevermore_second_attack_debuff:OnRefresh(table)
    if(IsServer() ) {
        this.IncrementStackCount()
    }
}

function modifier_nevermore_second_attack_debuff:GetEffectName()
	return "particles/units/heroes/hero_nevermore/nevermore_shadowraze_debuff.vpcf"
}

function modifier_nevermore_second_attack_debuff:GetEffectAttachType()
	return ParticleAttachment.ABSORIGIN_FOLLOW
}

function modifier_nevermore_second_attack_debuff:GetStatusLabel() return "Raze" }
function modifier_nevermore_second_attack_debuff:GetStatusPriority() return 4 }
function modifier_nevermore_second_attack_debuff:GetStatusStyle() return "Raze" }

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Status(modifier_nevermore_second_attack_debuff)