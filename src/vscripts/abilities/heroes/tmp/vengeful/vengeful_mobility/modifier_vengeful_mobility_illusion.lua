modifier_vengeful_mobility_illusion = class({})

OnCreated(params){
    if(IsServer() ) {
        this.parent = this.parent
        this.origin = this.parent.GetAbsOrigin()
        this.radius_marker_modifier = CreateTimedRadiusMarker(this.parent, this.origin, 150, this.GetDuration(), 0.2, RADIUS_SCOPE_PUBLIC):FindModifierByName('radius_marker_thinker')
    }
}

OnDestroy(){
    if(IsServer() ) {
        if(this.radius_marker_modifier ~= undefined ) {
            if(! this.radius_marker_modifier:IsNull() ) {
                this.radius_marker_modifier:Destroy()
            }
        }
	}
}

CheckState(){
    return{
		[ModifierState.DISARMED] = true,
        [ModifierState.NO_HEALTH_BAR] = true,
        [ModifierState.NO_UNIT_COLLISION] = true,
        [ModifierState.FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
        [ModifierState.INVULNERABLE] = true,
        [ModifierState.OUT_OF_GAME] = true,
    }
}

function modifier_vengeful_mobility_illusion:GetStatusEffectName()
    return "particles/status_fx/status_effect_dark_seer_illusion.vpcf"
}