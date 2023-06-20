modifier_mars_mobility_banish = class({})

OnDestroy(){
    if(IsServer() ) {
        const point = ClampPosition(this.parent.GetAbsOrigin(), CustomAbilitiesLegacy:GetCursorPosition(this.ability), this.ability.GetCastRange(Vector(0,0,0), undefined), undefined)
        const delay = this.ability.GetSpecialValueFor("delay_time")

    }
}

CheckState(){
    return {
        [ModifierState.COMMAND_RESTRICTED] = true,
	}
}

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Banish(modifier_mars_mobility_banish) 