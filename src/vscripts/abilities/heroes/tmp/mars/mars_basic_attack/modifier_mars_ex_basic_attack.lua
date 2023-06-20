modifier_mars_ex_basic_attack = class({})

OnCreated(params){
    if(IsServer() ) {
        const think_interval = this.ability.GetSpecialValueFor('think_interval')
        this.heal_per_tick = this.ability.GetSpecialValueFor('heal_per_tick')
        this.efx = EFX('particles/items5_fx/essence_ring.vpcf', ParticleAttachment.ABSORIGIN_FOLLOW, this.parent, {})
        this.StartIntervalThink(think_interval)
    }
}


OnIntervalThink(){
    this.parent.Heal(this.heal_per_tick, this.parent)
}


OnDestroy(){
    if(IsServer() ) {
        DEFX(this.efx, false)
    }
}
