modifier_nevermore_second_attack_recasts_counter = class({})

IsHidden(){     return true }
IsPurgable(){   return false }

OnCreated(params){
    this.recast_duration = this.ability.GetSpecialValueFor("recast_duration")

    if(IsServer() ) {
        this.parent.AddNewModifier(this.parent, this.ability, "modifier_nevermore_second_attack_recast", { duration = this.recast_duration })
        this.SetStackCount(this.ability.GetSpecialValueFor("recasts"))
    }
}

OnDestroy(){
    if(IsServer() ) {
        this.parent.AddNewModifier(this.parent, this.ability, "modifier_nevermore_second_attack_block_recast", { duration = 2.0 })
    }
}

function modifier_nevermore_second_attack_recasts_counter:OnStackCountChanged(iStackCount)
    if(IsServer() ) {
        if(this.GetStackCount() > 0 ) {
            this.SetDuration(this.recast_duration, true)
            this.parent.AddNewModifier(this.parent, this.ability, "modifier_nevermore_second_attack_recast", { duration = this.recast_duration })
        } else {
            this.Destroy()
        }
    }
}

