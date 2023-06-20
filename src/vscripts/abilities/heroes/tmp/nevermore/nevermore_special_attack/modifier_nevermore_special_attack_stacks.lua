modifier_nevermore_special_attack_stacks = class({})

OnCreated(params){
    if(IsServer() ) {
        this.max_stacks = this.ability.GetSpecialValueFor('max_stacks')
        this.SetStackCount(1)
    }
}

function modifier_nevermore_special_attack_stacks:OnRefresh(params)
    if(IsServer() ) {
        this.IncrementStackCount()
    }
}

function modifier_nevermore_special_attack_stacks:OnStackCountChanged(iStackCount)
    if(IsServer() ) {
        if(this.GetStackCount() > this.max_stacks ) {
            this.SetStackCount(this.max_stacks)
            return
        }

        if(this.GetStackCount() == 0 ) {
            this.Destroy()
        }
    }
}

function modifier_nevermore_special_attack_stacks:GetEffectName()
	return "particles/units/heroes/hero_nevermore/nevermore_shadowraze_debuff.vpcf"
}


function modifier_nevermore_special_attack_stacks:GetEffectAttachType()
	return ParticleAttachment.ABSORIGIN_FOLLOW
}

function modifier_nevermore_special_attack_stacks:GetStatusLabel() return "Raze" }
function modifier_nevermore_special_attack_stacks:GetStatusPriority() return 4 }
function modifier_nevermore_special_attack_stacks:GetStatusStyle() return "Raze" }

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Status(modifier_nevermore_special_attack_stacks)