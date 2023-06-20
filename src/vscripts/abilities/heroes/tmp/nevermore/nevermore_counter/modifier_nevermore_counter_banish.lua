modifier_nevermore_counter_banish = class({})

OnDestroy(){
    if(IsServer() ) {
        const point = ClampPosition(this.parent.GetAbsOrigin(), CustomAbilitiesLegacy:GetCursorPosition(this.ability), this.ability.GetCastRange(Vector(0,0,0), undefined), undefined)
        const delay = this.ability.GetSpecialValueFor("delay_time")

        CreateModifierThinker(
            this.parent, --hCaster
            this.ability, --hAbility
            "modifier_nevermore_counter_thinker", --modifierName
            { duration = delay + 0.2 },
            point, --vOrigin
            this.parent.GetTeamNumber(), --nTeamNumber
            false --bPhantomBlocker
       )
    
        this.caster.AddNewModifier(this.caster, this.ability, "modifier_nevermore_counter_banish_no_indicator", { duration = delay })
    }
}

CheckState(){
    return {
        [ModifierState.COMMAND_RESTRICTED] = true,
	}
}

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Banish(modifier_nevermore_counter_banish)