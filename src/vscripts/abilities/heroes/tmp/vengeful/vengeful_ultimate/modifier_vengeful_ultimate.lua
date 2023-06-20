modifier_vengeful_ultimate = class({})

DeclareFunctions(){
	return {
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}
}

function modifier_vengeful_ultimate:OnAbilityFullyCast(params)
    if(IsServer() ) {
        if(params.unit ~= this.parent ) { return }
        
        const ability = params.ability
        if(this.ShouldMimic(ability) ) {
            if(this.ability ) {
                this.RemoveAbility()
            }
            this.SetAbility(ability)
        }
	}
}

function modifier_vengeful_ultimate:ShouldMimic(hAbility)
    return this.ability ~= hAbility and hAbility.IsMimicable and hAbility:IsMimicable() and ! this.AlreadyCopied(hAbility)
}

function modifier_vengeful_ultimate:AlreadyCopied(hAbility)
    return this.ability and this.ability.GetName() == hAbility:GetName() .. "_ultimate"
}

function modifier_vengeful_ultimate:SetAbility(hAbility)
    const name = hAbility:GetName()
    const copy_name = name .. "_ultimate"
    this.ability = this.parent.AddAbility(copy_name)
    this.ability.SetLevel(hAbility:GetLevel())

    if(this.ability.GetAssociatedPrimaryAbilities() ) {
        const associated = this.parent.AddAbility(this.ability.GetAssociatedPrimaryAbilities())
        associated:SetLevel(this.ability.GetLevel())
    }

    this.parent.SwapAbilities(
        copy_name, 
        "vengeful_ultimate", 
        true, 
        false
    )
}

function modifier_vengeful_ultimate:RemoveAbility()
    const name = this.ability.GetAbilityName()

    if(this.ability.BeforeRemoved ) {
        this.ability.BeforeRemoved()
    }

    this.parent.SwapAbilities(
        "vengeful_ultimate",
        name, 
        true, 
        false 
    )

    if(this.ability.GetAssociatedPrimaryAbilities() ) {
        this.parent.RemoveAbility(this.ability.GetAssociatedPrimaryAbilities())
    }
    
    this.parent.RemoveAbility(name)

    this.abilities = undefined
}